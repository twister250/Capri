package capri

import javassist.bytecode.stackmap.BasicBlock.Catch;

import org.grails.datastore.mapping.query.Query.ProjectionList;
import org.springframework.dao.DataIntegrityViolationException

import grails.plugins.springsecurity.Secured


class ClientController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [clientInstanceList: Client.list(params), clientInstanceTotal: Client.count()]
    }

    def create() {		
        [clientInstance: new Client(params)]
    }

    def save() {
        def clientInstance = new Client(params)
		
		try{
			validateCPF()
		}catch(Error e){
			flash.message = message(code: e.getMessage())
			render(view: "create", model: [clientInstance: clientInstance, css: "errors"])
			return
		}
		
		if (!clientInstance.save(flush: true)) {
            render(view: "create", model: [clientInstance: clientInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'client.label', default: 'Client'), clientInstance.id])
        redirect(action: "show", id: clientInstance.id)
    }

    def show(Long id) {
        def clientInstance = Client.get(id)
        if (!clientInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "list")
            return
        }

        [clientInstance: clientInstance]
    }

    def edit(Long id) {
        def clientInstance = Client.get(id)
        if (!clientInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "list")
            return
        }

        [clientInstance: clientInstance]
    }

    def update(Long id, Long version) {
        def clientInstance = Client.get(id)
        if (!clientInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (clientInstance.version > version) {
                clientInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'client.label', default: 'Client')] as Object[],
                          "Another user has updated this Client while you were editing")
                render(view: "edit", model: [clientInstance: clientInstance])
                return
            }
        }

        clientInstance.properties = params

        if (!clientInstance.save(flush: true)) {
            render(view: "edit", model: [clientInstance: clientInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'client.label', default: 'Client'), clientInstance.id])
        redirect(action: "show", id: clientInstance.id)
    }

    def delete(Long id) {
        def clientInstance = Client.get(id)
        if (!clientInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "list")
            return
        }

        try {
            clientInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'client.label', default: 'Client'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def report(Integer pages) {
		params.max = Math.min(pages ?: 10, 100)		
		def criteria = Orders.createCriteria()		
		def result = criteria.list {
			createAlias("client","c")			
			projections {
				groupProperty("c.id","id")
				property("c.name","name")				
				max("date")
				rowCount()
				sum("total")
			}
			order("total","asc")
		}
		println result		
		[clientInstanceList: result, clientInstanceTotal: result.size()]
	}
	
	/* Verifica se o cpf digitado é válido */
	def validateCPF(){
		def cpf = params.cpf		
		def sum = 0
		def dv = 0		
		if(cpf.size() > 0) {			
			[1,0].each{
				cpf.substring(0, cpf.length() - (it + 1)).eachWithIndex { c, index ->
					sum += c.toInteger() * (cpf.size() - it.toInteger() - index)
				}
				dv = sum % cpf.size() < 2 ?: 11 - (sum % 11)				
				if(Integer.parseInt(cpf.getAt(cpf.length() - it - 1)) != dv){					
					assert dv == cpf.getAt(cpf.length() - it - 1), "Número de CPF inválido"
				}else{
					sum = 0
					dv = 0
				}
			}
		}		
	}
}
