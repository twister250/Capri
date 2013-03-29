package capri

import java.util.Date;

class Orders {

    int id
	Date date
	float total

	static belongsTo = [ client: Client ]
	
	static hasMany = [ items: Items ]
	
	static constraints = {
		client nullable: false, blank: false
		date nullable: false, blank: false
		total nullable: false, blank: false
	}
		
	static mapping = {
		version false
	}
}
