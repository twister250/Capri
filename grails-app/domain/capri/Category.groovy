package capri

class Category {
	
	int id
	
	String name
	
	String type
	
	static hasMany = [ product: Product ]
	
    static constraints = {
		name nullable: false, blank: false
	}
		
	static mapping = {
		version false
	}
}
