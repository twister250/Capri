package capri

import java.awt.geom.Arc2D.Float;

import org.springframework.dao.DataIntegrityViolationException

class OrdersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [ordersInstanceList: Orders.list(params), ordersInstanceTotal: Orders.count()]
    }
	
	def create(String phone) {
		[ordersInstance: new Orders(params)]
		if(!phone.equals(null)){
			def client = clientSearch(phone)
			if(!client){
				redirect(action: "create", controller: "client")
			}else{
				def products = Product.list(sort: "category")
				products.each {
					print it
				}
				def category = Category.list()
				render(view: "create", model: [client: client, category: category, products: products])
			}
		}
	}	

    def save() {        
		params.date = new Date()
		params.client = Client.findById(params.clientId)		

		print params
			
		def product
		def amount
		def items
		def order
		
		if(!(params.product instanceof Object[])){
			product = Product.get(params.product.split(":",0)[0])
			amount = params.product.split(":")[1]
			items = new Items(order: order, product: product, amount: amount)
			order = new Orders(params)
			.addToItems(items)
			if (!order.save(flush: true)) {
				render(view: "create", model: [order: order])
				return
			}
		}else{
			product = []
			amount = []
			order = new Orders(params)
			if (!order.save(flush: true)) {
				render(view: "create", model: [order: order])
				return
			}
			params.product.eachWithIndex{ obj, index ->
				product[index] = Product.get(obj[0])
				amount[index] = obj[2]
				items = new Items(order: order, product: product[index], amount: amount[index])
				order.addToItems(items)
				items.save()
			}
		}
		
        flash.message = message(code: 'default.created.message', args: [message(code: 'orders.label', default: 'Orders'), order.id])
        redirect(action: "show", id: order.id)
    }

    def show(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [ordersInstance: ordersInstance]
    }

    def edit(Long id) {
        def order = Orders.get(id)
		def client = Client.get(order.client.id)
		def items = Items.findAllByOrder(order)
		def products = Product.list(sort: "category")
        if (!order) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [order: order, client: client, items: items, products: products]
    }

    def update(Long id, Long version) {
		def order = Orders.get(id)
		def client = Client.findById(params.clientId)
		def items = Items.findAllByOrder(order)
		def product = null
		def amount = null
		def total = params.total
		
		print "total: "+total	
		
		items?.each{
			it.delete(flush: true)
		}
		
		print "Params Update: "+params		
				
        if (!order) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (order.version > version) {
                order.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'orders.label', default: 'Orders')] as Object[],
                          "Another user has updated this Orders while you were editing")
                render(view: "edit", model: [order: order])
                return
            }
        }
		
		if(!(params.product instanceof Object[])){
			product = Product.get(params.product.split(":",0)[0])
			amount = params.product.split(":")[1]
			items = new Items(order: order, product: product, amount: amount)
			order.addToItems(items)			
		}else{
			product = []
			amount = []			
			params.product.eachWithIndex{ obj, index ->
				product[index] = Product.get(obj[0])
				amount[index] = obj[2]
				items = new Items(order: order, product: product[index], amount: amount[index])
				order.addToItems(items)
				items.save()
			}
		}
						
		order.setTotal(total.toFloat())

        if (!order.save(flush: true)) {
            render(view: "edit", model: [order: order, client: client])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'orders.label', default: 'Orders'), order.id])
        redirect(action: "show", id: order.id)
    }

    def delete(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        try {
            ordersInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def clientSearch(String phone) {
		if(!phone){
			return
		}
		def client = Client.findByPhone(phone)
		if(!client){
			return null
		}else{
			return client
		}
	}
}
