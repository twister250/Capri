var cart = new Array();
var totalAmt = 0;
var ncost = 0;
var halfPizza = false;

function show(obj){
	$('#'+obj).slideToggle();
}


function addToCart(i, product){
	var obj;
	
	obj = products;
	show('size'+obj[i].id);		
	show('category'+obj[i].category);
	
	var bool = false;
	
	if(cart.length == 0){
		
		cart.push(obj[i]);
		
	}else{
		
		for(var cont = 0; cont < cart.length; cont++){
			
			if(cart[cont].type == obj[i].type && cart[cont].id == obj[i].id){
				
				cart[cont].qtd++;
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
	
	populateCart(product);
	
}

function populateCart(product){
	
	var input = $('#cartproduct').children('input[name="product"]');
	var bool = false;
	
	if(input.length != 0){
		$('#cartproduct')
		.children('input[name="product"]')
		.each(function(index){
			for(var cont = 0; cont < cart.length; cont++){
				if($(this).val().substring(0,1) == cart[cont].id){
					$(this).attr('value',cart[index].id + ":" + cart[index].qtd);
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
			.attr('value',cart[cart.length - 1].id+':'+cart[cart.length - 1].qtd)
			.attr('name','product')
		);
	}		
}

/*
function addToCart(i, product){
	
	var obj;
	
	if(product == "pizza"){
		obj = pizzas;
		show('size'+obj[i].id);		
		show('category'+obj[i].category);
	}else{
		obj = beverages;
		show('beverage');
	} 
	
	cart.push(obj[i]);
	
	$('#cart')
	.append(
		$('<input>')
		.attr('type','hidden')
		.attr('value',cart[(cart.length - 1)].id)
		.attr('name',product)
	);
		
	if($('#cartFoot').css('display') == 'none'){
		$('#cartFoot').css('display','');
	}
	
	if($('#' + obj[i].id + ' td:nth-child(1)').html() != obj[i].name){			
			
		obj[i].qtd = 1;
		ncost = (obj[i].qtd * obj[i].cost);
			
		$('#cartBody')
		.append(
			$('<tr>')
			.attr('id',obj[i].id)
			.append(
				$('<td>').text(obj[i].name)				
			)
			.append(
				$('<td>').text(obj[i].qtd)
			)
			.append(
				$('<td>')
				.addClass('cost')
				.attr('value',ncost.toFixed(2))
				.text('R$ ' + ncost.toFixed(2))
			)
			.append(
				$('<td>')
				.append(
					$('<a>')
					.attr('href','javascript:removePizzasFromCart('+1+');')
					.text('Remover')
				)
			)
		);
		
	}else{		
		obj[i].qtd++;
		ncost = (obj[i].qtd * obj[i].cost);
		
		$('#' + obj[i].id + ' td:nth-child(2)').html(obj[i].qtd);
		$('#' + obj[i].id + ' td:nth-child(3)').html('R$ ' + ncost.toFixed(2));
				
	}
		
	totalAmt++;
	
	$('#totalQtd').html(totalAmt);
	
	var totalCost = 0;
	
	for(var i = 0; i < cart.length; i++){
		totalCost += parseFloat(cart[i].cost);
	}
	
	$('#totalCost').html('R$ ' + totalCost.toFixed(2));
	
	$('#total')
	.attr('value',totalCost);
	
		
}
*/