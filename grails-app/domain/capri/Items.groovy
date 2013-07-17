package capri

class Items {

	int id
	
	double amount
	
	Product product
	
	static belongsTo = [ order: Orders ]
	
    static constraints = {
    }
	
	static mapping = {
		version false
	}
}
