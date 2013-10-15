class UrlMappings {
		
	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		
		"/$controller/report"(controller: "$controller", action: "report") 
		
		"/"(view: "/index")
		
		"500"(view:'/error')
	}
}
