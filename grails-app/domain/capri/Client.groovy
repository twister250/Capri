package capri

class Client {

    int id
	String name
	String address
	String phone
	String cpf
	
	static searchable = true
	
	static hasMany = [ orders : Orders ]
	
	static constraints = {
		name nullable: false, blank: false
		phone nullable: false, blank: false, unique: true
		address nullable: false, blank: false
		cpf nullable: true, blank: true, unique: true
	}
		
	static mapping = {
		version false
	}
}
