package capri

import org.springframework.dao.DataIntegrityViolationException

class ItemsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [itemsInstanceList: Items.list(params), itemsInstanceTotal: Items.count()]
    }

    def create() {
        [itemsInstance: new Items(params)]
    }

    def save() {
        def itemsInstance = new Items(params)
        if (!itemsInstance.save(flush: true)) {
            render(view: "create", model: [itemsInstance: itemsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'items.label', default: 'Items'), itemsInstance.id])
        redirect(action: "show", id: itemsInstance.id)
    }

    def show(Long id) {
        def itemsInstance = Items.get(id)
        if (!itemsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "list")
            return
        }

        [itemsInstance: itemsInstance]
    }

    def edit(Long id) {
        def itemsInstance = Items.get(id)
        if (!itemsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "list")
            return
        }

        [itemsInstance: itemsInstance]
    }

    def update(Long id, Long version) {
        def itemsInstance = Items.get(id)
        if (!itemsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (itemsInstance.version > version) {
                itemsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'items.label', default: 'Items')] as Object[],
                          "Another user has updated this Items while you were editing")
                render(view: "edit", model: [itemsInstance: itemsInstance])
                return
            }
        }

        itemsInstance.properties = params

        if (!itemsInstance.save(flush: true)) {
            render(view: "edit", model: [itemsInstance: itemsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'items.label', default: 'Items'), itemsInstance.id])
        redirect(action: "show", id: itemsInstance.id)
    }

    def delete(Long id) {
        def itemsInstance = Items.get(id)
        if (!itemsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "list")
            return
        }

        try {
            itemsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'items.label', default: 'Items'), id])
            redirect(action: "show", id: id)
        }
    }
}
