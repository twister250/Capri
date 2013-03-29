package capri



import org.junit.*
import grails.test.mixin.*

@TestFor(ItemsController)
@Mock(Items)
class ItemsControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/items/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.itemsInstanceList.size() == 0
        assert model.itemsInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.itemsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.itemsInstance != null
        assert view == '/items/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/items/show/1'
        assert controller.flash.message != null
        assert Items.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/items/list'

        populateValidParams(params)
        def items = new Items(params)

        assert items.save() != null

        params.id = items.id

        def model = controller.show()

        assert model.itemsInstance == items
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/items/list'

        populateValidParams(params)
        def items = new Items(params)

        assert items.save() != null

        params.id = items.id

        def model = controller.edit()

        assert model.itemsInstance == items
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/items/list'

        response.reset()

        populateValidParams(params)
        def items = new Items(params)

        assert items.save() != null

        // test invalid parameters in update
        params.id = items.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/items/edit"
        assert model.itemsInstance != null

        items.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/items/show/$items.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        items.clearErrors()

        populateValidParams(params)
        params.id = items.id
        params.version = -1
        controller.update()

        assert view == "/items/edit"
        assert model.itemsInstance != null
        assert model.itemsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/items/list'

        response.reset()

        populateValidParams(params)
        def items = new Items(params)

        assert items.save() != null
        assert Items.count() == 1

        params.id = items.id

        controller.delete()

        assert Items.count() == 0
        assert Items.get(items.id) == null
        assert response.redirectedUrl == '/items/list'
    }
}
