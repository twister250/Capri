var cart = new Array();
var ncost = 0;
var halfPizza = false;


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

function search(data){
	
	$('#content')
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
							.text('Broto')
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
					.attr('id','cartBody')
				)
			)
		)
	);
		
	$.each(data, function(){
		console.log(this);
		$('#cartBody')
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
					.attr('type','checkbox')
				)
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
		
		$('#content')
		.append(
			$('<div>')
			.attr('id','cart')
			.append(
				$('<input>')
				.attr('type','hidden')
				.attr('id','total')
				.attr('name','product')
			)	
		);
		/*
		<span class="spanCart">Visualizar</span>						
		<span class="spanOrder">Voltar para Pedido</span>
		<g:submitButton name="create" class="save" value="Salvar" style="display: none;"/>
		</fieldset>
		*/
		
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
				$('<input>')	// <input type="submit" name="create" class="save" value="Salvar" style="display: none;" id="create">
				.attr('id','create')
				.attr('type','submit')
				.attr('name','create')
				.attr('value','Salvar')
				.addClass('save')
				.css('display','none')
			)
		);
		
		

		if(cart.length > 0){
			$('.spanCart').css('display','block');
		}
		
	});
}
