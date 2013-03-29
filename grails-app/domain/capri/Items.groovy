package capri

class Items {

	int id
	
	int amount
	
	Product product
	
	static belongsTo = [ order: Orders ]
	
    static constraints = {
    }
	
	static mapping = {
		version false
	}
}
