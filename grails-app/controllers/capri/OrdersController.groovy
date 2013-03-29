package capri

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
	
	/*
    def create() {
        [ordersInstance: new Orders(params)]
    } 
	*/
	
	def create(String phone) {
		[ordersInstance: new Orders(params)]
		if(!phone.equals(null)){
			def client = clientSearch(phone)
			if(!client){
				redirect(action: "create", controller: "client")
			}else{
				def products = Product.list(sort: "category")
				def items = new Items()
				render(view: "create", model: [client: client, items: items, products: products])
			}
		}
	}	

    def save() {
        
		params.date = new Date()
		params.client = Client.findById(params.clientId)		
		params.total = 0
				
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
				print product
				amount[index] = obj[2]
				print amount
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
        def ordersInstance = Orders.get(id)
		def client = Client.get(ordersInstance.client.id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [ordersInstance: ordersInstance, client: client]
    }

    def update(Long id, Long version) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (ordersInstance.version > version) {
                ordersInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'orders.label', default: 'Orders')] as Object[],
                          "Another user has updated this Orders while you were editing")
                render(view: "edit", model: [ordersInstance: ordersInstance])
                return
            }
        }

        ordersInstance.properties = params

        if (!ordersInstance.save(flush: true)) {
            render(view: "edit", model: [ordersInstance: ordersInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'orders.label', default: 'Orders'), ordersInstance.id])
        redirect(action: "show", id: ordersInstance.id)
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
