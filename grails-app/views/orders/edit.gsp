<%@ page import="capri.Orders" %>
<%@ page import="capri.Client" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/orders/', file: 'orders.css')}" type="text/css">
		<%--<r:require module="jquery-ui"/>--%>		
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" type="text/css">
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	</head>
	
	<r:script>
		var products = [			
			<g:each in="${products}" var="product" status="i">
				{
					"id": "${product.id}",
					"name": "${product.name}",
					"cost": "${product.cost}",
					"category": "${product.category.id}",
					"type":"${product.category.type.toLowerCase()}",
					"amount": "1"
				}<g:if test="${products.get(i) != products[-1]}">,</g:if>
			</g:each>
		]
	</r:script>
	
	<body>
		<a href="#edit-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Pedidos</g:link></li>
				<li><g:link class="create" action="create">Novo Pedido</g:link></li>
			</ul>
		</div>
		<div id="edit-orders" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${order}">
			<ul class="errors" role="alert">
				<g:eachError bean="${order}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${order?.id}" />
				<g:hiddenField name="version" value="${order?.version}" />
								
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>						
				
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
									<th class="center">1/2</th>
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
												<td class="center"><g:checkBox id="half${p.id}" name="half" /></td>
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
				
				<fieldset class="buttons">
					<span class="spanCart">Visualizar</span>						
					<span class="spanOrder">Voltar para Pedido</span>
					<g:actionSubmit class="save" action="update" value="Alterar" style="display: none;"/>
					<g:actionSubmit class="delete" action="delete" value="Deletar" formnovalidate="" onclick="return confirm('Deseja remover pedido ${order.id} ?');" style="display: none;"/>
				</fieldset>
			</g:form>
		</div>
		<g:javascript src="orders/tab.js"/>
		<g:javascript src="orders/orders.js"/>
		<script type="text/javascript">		
			$('input[id*="spinner"]').spinner({min: 1});
		</script>
	</body>
</html>