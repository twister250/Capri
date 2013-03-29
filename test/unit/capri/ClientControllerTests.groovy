package capri



import org.junit.*
import grails.test.mixin.*

@TestFor(ClientController)
@Mock(Client)
class ClientControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/client/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.clientInstanceList.size() == 0
        assert model.clientInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.clientInstance != null
    }

    void testSave() {
        controller.save()

        assert model.clientInstance != null
        assert view == '/client/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/client/show/1'
        assert controller.flash.message != null
        assert Client.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/client/list'

        populateValidParams(params)
        def client = new Client(params)

        assert client.save() != null

        params.id = client.id

        def model = controller.show()

        assert model.clientInstance == client
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/client/list'

        populateValidParams(params)
        def client = new Client(params)

        assert client.save() != null

        params.id = client.id

        def model = controller.edit()

        assert model.clientInstance == client
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/client/list'

        response.reset()

        populateValidParams(params)
        def client = new Client(params)

        assert client.save() != null

        // test invalid parameters in update
        params.id = client.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/client/edit"
        assert model.clientInstance != null

        client.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/client/show/$client.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        client.clearErrors()

        populateValidParams(params)
        params.id = client.id
        params.version = -1
        controller.update()

        assert view == "/client/edit"
        assert model.clientInstance != null
        assert model.clientInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/client/list'

        response.reset()

        populateValidParams(params)
        def client = new Client(params)

        assert client.save() != null
        assert Client.count() == 1

        params.id = client.id

        controller.delete()

        assert Client.count() == 0
        assert Client.get(client.id) == null
        assert response.redirectedUrl == '/client/list'
    }
}
