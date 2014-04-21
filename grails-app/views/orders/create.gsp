<%@ page import="capri.Orders" %>
<%@ page import="capri.Client" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Pedidos')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/orders/', file: 'orders.css')}" type="text/css">		
		<link rel="stylesheet" href="${resource(dir: 'jquery/jquery-ui-themes-1.10.4/themes/smoothness/', file: 'jquery-ui.css')}" type="text/css">		
		<script src="../jquery/jquery-1.11.0/jquery-1.11.0.js" type="text/javascript"></script>
		<script src="../jquery/jquery-ui-1.10.4/js/jquery-ui-1.10.4.js" type="text/javascript"></script>				
	</head>
		
	<r:script>
		var products = [			
			<g:each in="${products}" var="p" status="i">
				{
					"id": "${p.id}",
					"name": "${p.name}",
					"cost": "${p.cost}",
					"category": "${p.category.id}",
					"type": "${p.category.type.toLowerCase()}",
					"amount": "1"
				}<g:if test="${products.get(i) != products[-1]}">,</g:if>
			</g:each>
		]
	</r:script>
		
	<body>
		<a href="#create-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Pedidos</g:link></li>
			</ul>
		</div>
		<div id="create-orders" class="content scaffold-create" role="main">
			<h1>Cliente</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${ordersInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${ordersInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>			
			
			<g:if test="${!client}">
				<g:form action="create" >
					<fieldset class="form">
						<div class="fieldcontain">
							<label>Telefone:</label>
							<g:field type="text" name="phone"/>
						</div>
					</fieldset>
				</g:form>			
			</g:if>
			<g:else>
				
				
				<g:formRemote
					name="search"
					url="[action: 'searchProduct']" 
					onSuccess="search(data)"
					update="content" 
					style="position: relative; float: right; margin-right: 30px;">
					<label>Buscar: </label><input name="q" type="text"/>
				</g:formRemote>
				
				<g:form action="save">
					<fieldset class="form" style="margin-bottom: 100px;">
						<g:render template="form"/>
					</fieldset>	
					
					<div id="content">		
						<div id="tabs_list">
							<ul id="tabs">
								<g:each in="${category}" var="c">
									<li><a href="#category${c.id}">${c.name}</a></li>
								</g:each>							
							</ul>
						</div>
						<div id="tabs_content">
							<g:each in="${category}" var="c">
								<div id="category${c.id}" class="category">
									<table>
										<thead>
											<th class="left">Produto</th>
											<th class="left">Descrição</th>
											<th class="center">Valor</th>											
											<g:if test="${c.type.equals('Pizza')}">
												<th class="center">1/2</th>
											</g:if>
											<th class="center">Quantidade</th>
											<th class="center">Carrinho</th>
										</thead>
										<tbody>
											<g:each in="${products}" var="p">
												<g:if test="${c.id == p.categoryId}">
													<tr>
														<td>${p.name}</td>
														<td class="productdescription">${p.description}</td>
														<td class="center" style="width: 65px;">R$ <g:formatNumber number="${p.cost}" minFractionDigits="2"/></td>														
														<g:if test="${c.type.equals('Pizza')}">
															<td class="center"><g:checkBox id="half${p.id}" name="half" /></td>
														</g:if>
														<td class="center"><input id="spinner${p.id}" name="value"/></td>
														<td class="center"><g:img id="${p.id}" class="product" file="skin/cart.png" /></td>
													</tr>
												</g:if>											
											</g:each>
										</tbody>
									</table>
								</div>																
							</g:each>
						</div>
						
						<fieldset style="padding: 20px 0 30px;">
							<table id="cartTable">
								<thead id="cartHead">
									<tr>
										<th class="left">Produto</th>
										<th class="left">Unidade</th>
										<th class="center">Quantidade</th>
										<th class="left">Subtotal</th>
										<th class="center">Remover</th>
									</tr>
								</thead>
								<tbody id="cartBody">
								</tbody>
								<tfoot id="cartFoot">
									<tr>
										<th>Total</th>
										<th></th>
										<th id="totalAmount"></th>
										<th id="totalCost"></th>
										<th></th>
									</tr>							
								</tfoot>
							</table>											
						</fieldset>
																										
						<div id="cart">
							<input type="hidden" id="total" name="total"/>
						</div>
						
						<fieldset class="buttons" style="margin-top: 50px;">
							<span class="spanCart">Visualizar</span>						
							<span class="spanOrder">Voltar para Pedido</span>
							<g:submitButton name="create" class="save" value="Salvar" style="display: none;"/>
						</fieldset>
					</div>
				</g:form>
			</g:else>
		</div>
		<g:javascript src="orders/tab.js"/>
		<g:javascript src="orders/orders.js"/>
		<script type="text/javascript">		
			$('input[id*="spinner"]').spinner({min: 1});
		</script>
	</body>	
</html>