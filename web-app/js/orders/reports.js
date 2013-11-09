$('#range').click(function(){
	var display = $('#report');
	if(display.css('display') == "none"){
		display.css('display','block');
		$('#table').css('marginTop','150px');
	}
});

function report(data){
	//console.log(data.ordersInstanceTotal);
	var total = 0;
	var totalProdutos = 0;
	
	$.each(data.ordersInstanceList, function(){
		console.log(this);
	});
	
	$('#content')
	.append(
		$('<table>')
		.css('marginTop','40px')
		.attr('id','table')
		.append(
			$('<thead>')
			.append(
				$('<tr>')
				.append(
					$('<th>')
					.addClass('sortable')
					.html('ID')
				)
				.append(
					$('<th>')
					.addClass('sortable')
					.append(
						$('<a>')
						.attr('href','/Capri/orders/report?sort=client&max=10&order=asc')
						.html('Cliente')
					)
				)
				.append(
					$('<th>')
					.addClass('sortable')
					.append(
						$('<a>')
						.attr('href','/Capri/orders/report?sort=date&max=10&order=asc')
						.html('Data')
					)					
				)
				.append(
					$('<th>')
					.addClass('sortable')
					.append(
						$('<a>')
						.attr('href','/Capri/orders/report?sort=date&max=10&order=asc')
						.html('Quantidade Produtos')
						.css('textAlign','center')
					)					
				)
				.append(
					$('<th>')
					.addClass('sortable')
					.append(
						$('<a>')
						.attr('href','/Capri/orders/report?sort=total&max=10&order=asc')
						.html('Total')
					)
				)
			)
		)
	);
	
	$('#table')
	.append(
		$('<tbody>')
		.attr('id','listBody')
	);
	
	
	$.each(data.ordersInstanceList, function(index){
		var date = $.datepicker.formatDate('dd/mm/yy',new Date(this[2]));
		
		$('#listBody')
		.append(
			$('<tr>')
			.addClass(index % 2 == 0 ? 'even' : 'odd')
			.append(
				$('<td>')
				.html(this[0])
			)
			.append(
				$('<td>')
				.append(
					$('<a>')
					.attr('href','/Capri/orders/show/' + this[0])
					.html(this[1].name)
				)
			)
			.append(
				$('<td>')
				.html(date)
			)
			.append(
				$('<td>')
				.html(this[4])
				.css('textAlign','center')
			)
			.append(
				$('<td>')
				.html('R$ '+this[3])
			)
		);
		
		total += this[3];
		totalProdutos += this[4];
		
		console.log(total);
		console.log(totalProdutos);
		
	});
	
	$('#table')
	.append(
		$('<tfoot>')
		.append(
			$('<tr>')
			.append(
				$('<th>')
				.html("Total")
			)
			.append(
				$('<th>')
			)
			.append(
				$('<th>')
			)
			.append(
				$('<th>')
				.html(totalProdutos)
				.css('textAlign','center')
			)
			.append(
				$('<th>')
				.html("R$ "+total)
			)
		)	
	);
}

function validateRange(){
	var from = $('#from').val();
	var to = $('#to').val();
	
	if(from == ""){
		alert("Por favor preencha a data inicial.");
	}else{
		if(to == ""){
			alert("Por favor preencha a data final.");
		}		
	}	
}

$('#dateRange').click(function(){
	$('#report').css('display','none');	
});
	

