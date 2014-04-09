package capri

import java.awt.geom.Arc2D.Float;

import org.springframework.dao.DataIntegrityViolationException

//import com.oracle.jrockit.jfr.ContentType;

import grails.plugins.springsecurity.Secured
import grails.validation.Validateable;

import grails.converters.*


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
				def products = Product.list(sort: "id")
				def category = Category.list()
				render(view: "create", model: [client: client, products: products, category: category])
			}
		}
	}	

    def save() {        
		params.date = new Date()
		params.client = Client.findById(params.clientId)
		params.total = params.total.toDouble()

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
				product[index] = Product.get(obj.split(":")[0])
				amount[index] = obj.split(":")[1]				
				items = new Items(order: order, product: product[index], amount: amount[index].toDouble())
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
		def products = Product.list(sort: "id")		
		def category = Category.list()
        if (!order) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [order: order, client: client, items: items, products: products, category: category]
    }

    def update(Long id, Long version) {
		def order = Orders.get(id)
		def client = Client.findById(params.clientId)
		def items = Items.findAllByOrder(order)
		def product = null
		def amount = null
		def total = params.total.toDouble()
		
		print "total: "+total	
		
		items?.each{
			it.delete(flush: true)
		}
		
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
				product[index] = Product.get(obj.split(":")[0])
				amount[index] = obj.split(":")[1]
				items = new Items(order: order, product: product[index], amount: amount[index].toDouble())
				order.addToItems(items)
				items.save()
			}
		}
								
		order.setTotal(total)

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
	
	def searchProduct(){
		def query = params.q
		def result = Product.findAll("from capri.Product as p where p.name like '"+query+"%'") 
		println "Busca: " + result
		println "params: "+ params
		render(contentType: "text/json", encoding: "UTF-8"){
			result
		}
	}
	
	def report(Integer max) {
		Date from
		Date to
		def amount
		def totalAmount = 0
		def total = 0
		def range = 0
		def map = [:]
		def model = [:]
		def items = [:]
		def ordersInstanceList
		def ordersInstanceTotal = Orders.count()
		def queryItem = "select sum(i.amount) from Items i where i.order = :order"
		def query = "select o.id as id, " +
					"o.client as cliente, " +
					"o.date as data, "+
					"o.total as total, "+
					"sum(i.amount) as items " +
					"from "+
					"Orders as o, "+
					"Items as i " +
					"where " +
					"o.id = i.order " +
					"and o.date between :from and :to "+
					"group by " +
					"o.id, o.client, o.date, o.total"
		
		if (params.from == null && params.to == null){
			from = new Date().clearTime()
			to = new Date()
			to.set(hourOfDay: 23, minute: 59, second: 59)
			ordersInstanceList = Orders.findAllByDateBetween(from, to)
			map.put("view", "report")
			map.put("encoding", "UTF-8")
			
			ordersInstanceList.eachWithIndex{ order, index ->
				amount = Items.executeQuery(queryItem, [order: order])
				totalAmount += amount
				total += order.total
				items.put(order.id, amount.toString().substring(1, amount.toString().indexOf(".")))
			}
			
		}else{		
			from = new Date().parse("dd/MM/yyyy", params.from)
			to = new Date().parse("dd/MM/yyyy", params.to)
			ordersInstanceList = Orders.executeQuery(query, [from:from, to: to])
			map.put("contentType", "text/json")
			map.put("encoding", "UTF-8")
			range = 1
		}
		
		model.put("ordersInstanceList", ordersInstanceList)
		model.put("ordersInstanceTotal", ordersInstanceTotal)
		model.put("items", items)
		model.put("totalAmount", totalAmount)
		model.put("total",total)
		map.put("model", model)
		
		if(range == 0){
			render(map)
		}else{
			render(contentType: "text/json", encoding: "UTF-8"){
				[ordersInstanceList: ordersInstanceList, ordersInstanceTotal: ordersInstanceTotal, items: items]
			}
		}	
	}
}
