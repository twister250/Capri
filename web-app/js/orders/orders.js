var cart = new Array();
var ncost = 0;
var halfPizza = false;


$('.product').click(function(){
	var id = this.id;
	var divCart = $('#cart');
	var amount = $('#spinner'+id).val();
	var half = $('input[id="half'+id+'"]:checked').val();
	
	if(amount == "" && half == undefined){
		alert("Selecione quantidade");
		return;
	}
	
	products[id-1].amount = amount == "" ? 1/2 : amount;
	
	/*cart.push(products[id-1]);*/
	if(cart[id] == undefined){
		cart[id] = products[id-1];
	}else{
		return;
	}
	
	console.log(cart);
	
	divCart.append(
			$('<input>')
			.attr('type','hidden')
			.attr('value',cart[id].id+':'+cart[id].amount)
			.attr('name','product')
	);	
	
	if(cart.length > 0){
		$('.spanCart').css('display','block');
	}			
});

$('span[class*="span"]').click(function(){
	var spanCart = $('.spanCart');
	var spanOrder = $('.spanOrder');
	var tabsList = $('#tabs_list');
	var tabsContent = $('#tabs_content');
	var cartTable = $('#cartTable');
	var save = $('.save');
	
	if(spanCart.css('display') == "block"){		
		tabsList.fadeOut();
		tabsContent.fadeOut();
		spanCart.fadeOut();
		setTimeout(function(){
			cartTable.fadeIn();			
			spanOrder.fadeIn();
			showCart();
			save.fadeIn();
		},500);				
	}else{
		cartTable.fadeOut();
		spanOrder.fadeOut();
		save.fadeOut();
		setTimeout(function(){			
			tabsList.fadeIn();
			tabsContent.fadeIn();
			spanCart.fadeIn();
		},500);
		
	}
});

function showCart(){
	var totalAmount = 0;
	var totalCost = 0;
	
	$('#cartBody').remove();
	$('#cartTable')
	.append(
		$('<tbody>')
		.attr('id','cartBody')
	);
	
	for(var i = 0; i < cart.length; i++){
		console.log(i + " - " + cart[i]);
		if(cart[i] == undefined){
			continue;
		}else{
			totalAmount += parseFloat(cart[i].amount);
			totalCost += parseFloat(cart[i].cost * cart[i].amount);			
			$('#cartBody')
			.append(
				$('<tr>')
				.attr('id',cart[i].id)
				.css('border','1px solid #cccccc')
				.append(
					$('<td>').text(cart[i].name)
					.css('padding-left','5px')
				)			
				.append(
					$('<td>')
					.attr('value',cart[i].cost)
					.text('R$ '+parseFloat(cart[i].cost).toFixed(2))
				)
				.append(
					$('<td>')
					.attr('value',cart[i].amount)
					.text(cart[i].amount)
					.addClass('center')
				)
				.append(
					$('<td>')
					.attr('value',cart[i].cost)
					.text('R$ '+parseFloat((cart[i].cost) * cart[i].amount).toFixed(2))
				)
				.append(
					$('<td>')
					.css('text-align','center')
					.css('padding-right','0')
					.append(
						$('<input>')
						.attr('type','image')
						.attr('src','../images/skin/close.png')
						.css('border','none')
					)
				)
			);
		}
	}
	$('#totalAmount')
	.css('text-align','center')
	.text(totalAmount);
	
	$('#totalCost')
	.text('R$ '+totalCost.toFixed(2));
	
	$('#total')
	.attr('value',totalCost);
}


/*
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
	
	if(halfPizza)
		alert("Selecione outro sabor.");
	
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
*/




