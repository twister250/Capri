package capri



import org.junit.*
import grails.test.mixin.*

@TestFor(OrdersController)
@Mock(Orders)
class OrdersControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/orders/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.ordersInstanceList.size() == 0
        assert model.ordersInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.ordersInstance != null
    }

    void testSave() {
        controller.save()

        assert model.ordersInstance != null
        assert view == '/orders/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/orders/show/1'
        assert controller.flash.message != null
        assert Orders.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/orders/list'

        populateValidParams(params)
        def orders = new Orders(params)

        assert orders.save() != null

        params.id = orders.id

        def model = controller.show()

        assert model.ordersInstance == orders
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/orders/list'

        populateValidParams(params)
        def orders = new Orders(params)

        assert orders.save() != null

        params.id = orders.id

        def model = controller.edit()

        assert model.ordersInstance == orders
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/orders/list'

        response.reset()

        populateValidParams(params)
        def orders = new Orders(params)

        assert orders.save() != null

        // test invalid parameters in update
        params.id = orders.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/orders/edit"
        assert model.ordersInstance != null

        orders.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/orders/show/$orders.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        orders.clearErrors()

        populateValidParams(params)
        params.id = orders.id
        params.version = -1
        controller.update()

        assert view == "/orders/edit"
        assert model.ordersInstance != null
        assert model.ordersInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/orders/list'

        response.reset()

        populateValidParams(params)
        def orders = new Orders(params)

        assert orders.save() != null
        assert Orders.count() == 1

        params.id = orders.id

        controller.delete()

        assert Orders.count() == 0
        assert Orders.get(orders.id) == null
        assert response.redirectedUrl == '/orders/list'
    }
}
