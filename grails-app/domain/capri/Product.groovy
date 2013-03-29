package capri

class Product {

	int id
	
	String name
	
	String description
	
	float cost
	
	static hasOne = [ category: Category ]
	
    static constraints = {
		name nullable: false, blank: false
		description nullable: false, blank: false
		cost nullable: false, blank: false
	}
		
	static mapping = {
		version false
	}
}
