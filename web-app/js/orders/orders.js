var cart = new Array();
var ncost = 0;
var halfPizza = false;

function show(objSlide, i, product){
	if(halfPizza){
		addToCart(i, product, halfPizza, objSlide)
		halfPizza = false;
	}else{
		$('#'+objSlide).slideToggle();
	}	
}


function addToCart(i, product, half, objSlide){
	var obj;
		
	obj = products;
	
	var bool = false;
	
	halfPizza = half;
	
	if($('#'+objSlide).css('display') == 'block'){
		$('#'+objSlide).slideToggle();
	}
		
	if(cart.length == 0){
		
		cart.push(obj[i]);
		
	}else{
		
		for(var cont = 0; cont < cart.length; cont++){
			
			if(cart[cont].type == obj[i].type && cart[cont].id == obj[i].id){
				
				cart[cont].amount++;
				bool = false;
				
				break;
				
			}else{
				
				bool = true;
				
			}
		}
	}
	
	if(bool === true){
		cart.push(obj[i]);
	}

	console.log(cart);
	
	createParams(product);
	
	populateCart();	
	
}

function createParams(product){
	
	var input = $('#cartproduct').children('input[name="product"]');
	var bool = false;
	
	if(input.length != 0){
		$('#cartproduct')
		.children('input[name="product"]')
		.each(function(index){
			for(var cont = 0; cont < cart.length; cont++){
				if($(this).val().split(":",1) == cart[cont].id){
					$(this).attr('value',cart[index].id + ":" + cart[index].amount);
					bool = false;
				}else{
					bool = true;
				}
			}			
		});	
	}else{
		bool = true;
	}
	
	if(bool){
		$('#cartproduct')
		.append(
			$('<input>')
			.attr('type','hidden')
			.attr('value',cart[cart.length - 1].id+':'+cart[cart.length - 1].amount)
			.attr('name','product')
		);
	}		
}

function populateCart(){
	var totalAmount = 0;
	var totalCost = 0;
	
	if($('#cartFoot').css('display') == 'none'){
		$('#cartFoot').css('display','');
	}
	
	$('#cartBody').remove();
	$('#cartTable')
	.append(
		$('<tbody>')
		.attr('id','cartBody')
	);
	
	for(var cont = 0; cont < cart.length; cont++){
		totalAmount += parseInt(cart[cont].amount);
		totalCost += parseFloat(cart[cont].cost * cart[cont].amount);
		
		$('#cartBody')
		.append(
			$('<tr>')
			.attr('id',cart[cont].id)
			.append(
				$('<td>').text(cart[cont].name)				
			)			
			.append(
				$('<td>')
				.attr('value',cart[cont].cost)
				.text('R$ '+parseFloat(cart[cont].cost).toFixed(2))
			)
			.append(
				$('<td>')
				.attr('value',cart[cont].amount)
				.text(cart[cont].amount)
			)
			.append(
				$('<td>')
				.attr('value',cart[cont].cost)
				.text('R$ '+parseFloat((cart[cont].cost) * cart[cont].amount).toFixed(2))
			)
			.append(
				$('<td>')
				.append(
					$('<a>')
					.attr('href','javascript:removeProduct();')
					.text('Remover')
				)
			)
		);		
	}
	$('#totalAmount')
	.text(totalAmount);
	
	$('#totalCost')
	.text('R$ '+totalCost.toFixed(2));
	
	$('#total')
	.attr('value',totalCost)
}





