var cart = new Array();

$(document).on('click','.product', function(){
	var id = this.id;
	var divCart = $('#cart');
	var amount = $('#spinner'+id).val();
	var half = $('input[id="half'+id+'"]:checked').val();
		
	if(amount == "" && half == undefined){
		alert("Selecione quantidade");
		return;
	}
	
	products[id-1].amount = amount == "" ? 1/2 : amount;
	
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


$(document).on('click','span[class*="span"]', function(){
	var spanCart = $('.spanCart');
	var spanOrder = $('.spanOrder');
	var tabsList = $('#tabs_list');
	var tabsContent = $('#tabs_content');
	var cartTable = $('#cartTable');
	var save = $('.save');
	var del = $('.delete');
	var checkHalf = $('input[id*="half"]:checked');
	
	if(spanCart.css('display') == "block"){
		if(checkHalf.size() % 2 != 0){
			alert('Por favor selecione a outra metade.');
			return;
		}
		tabsList.fadeOut();
		tabsContent.fadeOut();
		spanCart.fadeOut();
		setTimeout(function(){
			cartTable.fadeIn();			
			spanOrder.fadeIn();
			showCart();
			save.fadeIn();
			del.fadeIn();
		},500);				
	}else{
		cartTable.fadeOut();
		spanOrder.fadeOut();
		save.fadeOut();
		del.fadeOut();
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
					.attr('value',cart[i].amount < 1 ? "1/2" : cart[i].amount)
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
						$('<span>')
						.attr('id',cart[i].id)						
						.css('cursor','pointer')						
						.addClass('remover')
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

function search(data){
	
	console.log(cart);
	
	$('#content')
	.append(
		$('<div>')
		.attr('id','tabs_list')
	)
	.append(
		$('<div>')
		.attr('id','tabs_content')
		.css('border-top','1px solid #cccccc')
		.append(
			$('<div>')
			.addClass('category')
			.css('display','block')
			.append(
				$('<table>')
				.append(
					$('<thead>')
					.append(
						$('<tr>')
						.append(
							$('<th>')
							.addClass('left')
							.text('Produto')
						)
						.append(
							$('<th>')
							.addClass('left')
							.html('Descri&ccedil;&atilde;o')
						)
						.append(
							$('<th>')
							.addClass('center')
							.text('Valor')
						)						
						.append(
							$('<th>')
							.addClass('center')
							.text('1/2')
						)
						.append(
							$('<th>')
							.addClass('center')
							.text('Quantidade')
						)
						.append(
							$('<th>')
							.addClass('center')
							.text('Carrinho')
						)
					)
				)
				.append(
					$('<tbody>')					
				)
			)			
		)		
	)
	.append(
		$('<fieldset>')
		.append(
			$('<table>')
			.attr('id','cartTable')
			.css('display','none')
			.append(
				$('<thead>')
				.attr('id','cartHead')
				.append(
					$('<tr>')
					.append(
						$('<th>')
						.text('Produto')
					)
					.append(
						$('<th>')
						.text('Unidade')
					)
					.append(
						$('<th>')
						.text('Quantidade')
					)
					.append(
						$('<th>')
						.text('Sub-total')
					)
					.append(
						$('<th>')
						.text('Remover')
					)
				)				
			)
			.append(
				$('<tbody>')
				.attr('id','cartBody')						
			)
			.append(
				$('<tfoot>')
				.attr('id','cartFoot')
				.append(
					$('<tr>')
					.append(
						$('<th>')
						.text('Total')
					)
					.append(
						$('<th>')						
					)
					.append(
						$('<th>')
						.attr('id','totalAmount')
					)
					.append(
						$('<th>')
						.attr('id','totalCost')
					)
					.append(
						$('<th>')
						.text('')
					)
				)
			)
		)
	)
	.append(
		$('<div>')
		.attr('id','cart')
		.append(
			$('<input>')
			.attr('id','total')
			.attr('type','hidden')
			.attr('name','total')
		)
	);
	
	if(cart.length > 0){
		for(var i = 0; i < cart.length; i++){
			if(cart[i] == undefined){
				continue;
			}else{
				$('#cart')
				.append(
					$('<input>')
					.attr('type','hidden')
					.attr('value',cart[i].id+':'+cart[i].amount)
					.attr('name','product')
				)
			}
		}
	}
		
	$.each(data, function(){
		console.log(this);
		
		$('.category table').find('tbody')
		.append(
			$('<tr>')
			.attr('id',this.id)
			.css('border','1px solid #cccccc')
			.append(
				$('<td>').text(this.name)
				.css('padding-left','5px')
			)
			.append(
				$('<td>')
				.text(this.description)
				.addClass('productdescription')
			)
			.append(
				$('<td>')
				.attr('value',this.cost)
				.text('R$ '+parseFloat(this.cost).toFixed(2))
			)			
			.append(
				$('<td>')
				.addClass('center')
				.append(
					$('<input>')
					.attr('id','half'+this.id)
					.attr('name','half')
					.attr('type','checkbox')
				)
			)
			.append(
				$('<td>')
				.addClass('center')
				.append(
					$('<input>')
					.attr('id','spinner'+this.id)
					.attr('name','value')
				)
			)
			.append(
				$('<td>')
				.css('text-align','center')
				.css('padding-right','0')
				.append(
					$('<img>')
					.attr('id',this.id)
					.attr('src','../images/skin/cart.png')
					.css('border','none')
					.addClass('product')
				)
			)
		);
		$('input[id*="spinner"]').spinner({min: 1});
		
		if(cart.length > 0){
			$('.spanCart').css('display','block');
		}
		
	});
	
	$('#content')
	.append(
		$('<fieldset>')
		.addClass('buttons')
		.css('margin-top','50px')
		.append(
			$('<span>')
			.addClass('spanCart')
			.text('Visualizar')
		)
		.append(
			$('<span>')
			.addClass('spanOrder')
			.text('Voltar para pedido')
		)
		.append(
			$('<input>')
			.attr('id','create')
			.attr('type','submit')
			.attr('name','create')
			.attr('value','Salvar')
			.addClass('save')
			.css('display','none')
		)
	);
}

$(document).on('click','span[class*="remover"]', function(){
	console.log(this.id);
	cart.splice(this.id, 1);
	$('input[value^="'+this.id+':"]').remove();
	showCart();
});

