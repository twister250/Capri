import capri.Account
import capri.AccountRole
import capri.Role

class BootStrap {

    def init = { servletContext ->
		
		def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
		
		def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
		
		def rootAccount = new Account(username: 'root', enabled: true, password: 'root') 
		
		rootAccount.save(flush: true)
				
		AccountRole.create rootAccount, adminRole, true
		
		/*
		assert Account.count() == 1 
		assert Role.count() == 2
		assert AccountRole.count() == 1
		*/
		
    }
	
    def destroy = {
    }
}
