$(function(){
	$("form").submit(function(event){
		var phone = this.phone.value;
		var cpf = this.cpf.value;
		var array = new Array();
		var sum = null;
		var digit = null;
		var bool = true;
		var msg = validateForm(this);		
		/*
		if(msg != true){
			alert(msg);
			return false;
		}
				
		if(cpf.length > 0){
			if(cpf.length == 11){
				for(var i = 0; i < (cpf.length - 2); i++){
					array.push(cpf[i]);
				}
				for(var i = 1; i >= 0; --i){			
					for(var j = 0; j < array.length; j++){				
						sum += array[j] * ((cpf.length - i) - j);
					}
					(sum % cpf.length) < 2 ? digit = 0 : digit = 11 - (sum % 11);					
					if(cpf[array.length] == digit){
						array.push(cpf[array.length]);
						bool = true;
					}else{
						bool = false;
					}
					sum = null;
					digit = null;
				}
			}else{
				bool = false;
			}
		}
		*/		
		if(bool == false){
			alert("CPF Inválido.");
			return false;
		}		
	});
});