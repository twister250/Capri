function report(data){
	$.each(data, function(){
		console.log(this);
	});
	
	//console.log(data.ordersInstanceTotal);
	/*
	$.each(data.ordersInstanceList, function(){
		console.log(this);
	});*/
	
	$('#content')
	.append(
		$('<table>')
		.css('marginTop','100px')
		.append(
			$('<thead>')
			.append(
				$('<tr>')
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
						.attr('href','/Capri/orders/report?sort=total&max=10&order=asc')
						.html('Total')
					)
				)
			)
		)
	);
	
	$('#content')
	.append(
		$('<tbody>')
		.attr('id','listBody')
	);
	
	
	$.each(data.ordersInstanceList, function(index){
		$('#listBody')
		.append(
			$('<tr>')
			.addClass(index % 2 == 0 ? 'even' : 'odd')
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
				.append(
					'<g:formatDate date="this[2]" format="dd/MM/yyyy"/>'
				)
			)
		);
	});
}




