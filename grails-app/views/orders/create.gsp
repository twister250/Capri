<%@ page import="capri.Orders" %>
<%@ page import="capri.Client" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Pedidos')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/orders/', file: 'orders.css')}" type="text/css">
		<r:require module="jquery-ui"/>
		<g:javascript src="/orders/orders.js"/>	
	</head>
		
		<r:script>
			var products = [			
				<g:each in="${products}" var="product" status="i">
					{
						id: ${product.id},
						name: '${product.name}',
						cost: '${product.cost}',
						category: '${product.category.id}',
						type:'${product.category.type.toLowerCase()}',
						amount: 1
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
				<g:form action="save">
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>						
				
					<h1>Pizzas</h1>
					<g:each in="${products}" var="product" status="i">
						<g:if test="${product.category.type == 'Pizza'}">
							<fieldset class="form" style="padding: 0;">
								<h1 onclick="show('category${product.category.id}')" style="cursor: pointer; border: outset 2px; background-color: #efefef; width: 250px; text-align: center;">${product.category.name}</h1>
								<div id="category${product.category.id}" style="display: none;">
									<div id="div">
										<div id="pizza${product.id}" class="fieldcontain pizzas" onclick="show('size${product.id}')">
											<dl>
												<dt>
													<strong>${product.name}</strong><span>R$ ${product.cost}</span>
												</dt>
												<dd>${product.description}</dd>
											</dl>
										</div>
										<div id="size${product.id}" style="width: 100px; height: 50px; margin-left: 30px; display: none;">
											<span class="span" onclick="addToCart('${i}','${product.category.type.toLowerCase()}')">Inteira</span>
											<span class="span" onclick="teste('${i}')">1/2</span>
										</div>
										<div id="half${product.id}" style="width: 250px; height: 50px; margin: 3px 0px 0px 10px; display: none;">
											<span class="span2">Escolha a segunda opção !</span>
										</div>
									</div>
								</div>						
							</fieldset>
						</g:if>					
					</g:each>
					
					<h1>Bebidas</h1>
					<g:each in="${products}" var="product" status="i">
						<g:if test="${product.category.type == 'Bebida'}">
							<fieldset class="form" style="padding: 0;">
								<h1 onclick="show('category${product.category.id}')" style="cursor: pointer; border: outset 2px; background-color: #efefef; width: 250px; text-align: center;">${product.category.name}</h1>
								<div id="category${product.category.id}" style="display: none;">
									<div id="div">
										<div id="bebida${product.id}" class="fieldcontain pizzas" onclick="addToCart('${i}','${product.category.type.toLowerCase()}')">
											<dl>
												<dt>
													<strong>${product.name}</strong><span>R$ ${product.cost}</span>
												</dt>
												<dd>${product.description}</dd>
											</dl>
										</div>
									</div>
								</div>
							</fieldset>
						</g:if>
					</g:each>
					
					<br><br>
					
					<h1></h1>
					
					<br><br>					
					
					<h1>Pedido</h1>
					<fieldset style="padding: 20px 0 30px;">										
						<table id="cartTable">
							<thead id="cartHead">
								<tr>
									<th>Produto</th><th>Unidade</th><th>Quantidade</th><th>Subtotal</th><th>Remover Produto</th>
								</tr>
							</thead>
							<tbody id="cartBody">
							</tbody>
							<tfoot id="cartFoot" style="display: none;">
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
						<div id="cartproduct"></div>
					</div>
				
					<fieldset class="buttons" style="margin-top: 50px;">
						<g:submitButton name="create" class="save" value="Criar Pedido" />
					</fieldset>
					
				</g:form>
			</g:else>
		</div>
	</body>
</html>


<%--
<%@ page import="capri.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-orders" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
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
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
 --%>
 