package capri

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import capri.AccountRole

@Secured(['ROLE_ADMIN'])
class AccountController {

    def index() {
        redirect(action: "list", params: params)
    }
	
	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		def role = AccountRole.executeQuery("select ar.account, ar.role from AccountRole ar")
		println role
		[accountInstanceList: Account.list(params), accountInstanceTotal: Account.count(), role: role]
	}
	
	def show(Long id) {
		def accountInstance = Account.get(id)
		if (!accountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "list")
			return
		}

		[accountInstance: accountInstance]
	}
	
	def edit(Long id) {
		def accountInstance = Account.get(id)
		if (!accountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "list")
			return
		}
		[accountInstance: accountInstance]
	}
	
	def create() {
		[accountInstance: new Account(params), role: Role.list()]
	}
	
	def save() {
		def accountInstance = new Account(params)
		def role = Role.findById(params.role)
		
		println role
		
		if (!accountInstance.save(flush: true)) {
			render(view: "create", model: [accountInstance: accountInstance])
			return
		}
		if(!AccountRole.create(accountInstance, role, true)){
			render(view: "create", model: [accountInstance: accountInstance])
			return
		}
		flash.message = message(code: 'default.created.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.id])
		redirect(action: "show", id: accountInstance.id)
	}
	
	def update(Long id, Long version) {
		def accountInstance = Account.get(id)
		if (!accountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (accountInstance.version > version) {
				accountInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'account.label', default: 'Account')] as Object[],
						  "Another user has updated this Account while you were editing")
				render(view: "edit", model: [accountInstance: accountInstance])
				return
			}
		}

		accountInstance.properties = params

		if (!accountInstance.save(flush: true)) {
			render(view: "edit", model: [accountInstance: accountInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.id])
		redirect(action: "show", id: accountInstance.id)
	}
	
	def delete(Long id) {
		def accountInstance = Account.get(id)
		if (!accountInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "list")
			return
		}

		try {
			accountInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'account.label', default: 'Account'), id])
			redirect(action: "show", id: id)
		}
	}
}
