<%@ page import="capri.Orders" %>
<%@ page import="capri.Client" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Pedidos')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
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
										<th class="center">Broto</th>
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
													<td class="center" style="width: 65px;">R$ ${p.cost}</td>
													<td class="center"><g:checkBox name="mini" /></td>
													<td class="center"><g:checkBox name="half" /></td>
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
									<th>Produto</th><th>Unidade</th><th>Quantidade</th><th>Subtotal</th><th>Remover Produto</th>
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
										
					<%--
					<h1>Pizzas</h1>
					
					<g:each in="${category}" var="c">
						<g:if test="${c.type == 'Pizza' }">
							<h1 onclick="show('category${c.id}')" style="cursor: pointer; border: outset 2px; background-color: #efefef; width: 250px; text-align: center;">${c.name}</h1>
							<div id="category${c.id}" style="display: none;">
								<fieldset class="form" style="padding: 0;">
									<g:each in="${products}" var="p" status="i">
										<g:if test="${p.category.id.equals(c.id)}">
											<div id="div">
												<div id="pizza${p.id}" class="fieldcontain pizzas" 
												<g:if test="${c.type == 'Pizza' }"> onclick="show('size${p.id}','${i}','${c.type.toLowerCase()}')"</g:if>
												<g:else>onclick="addToCart('${i}','${c.type.toLowerCase()}')"</g:else>>
													<dl>
														<dt>
															<strong>${p.name}</strong><span>R$ ${p.cost}</span>
														</dt>
														<dd>${p.description}</dd>
													</dl>
												</div>
												<div id="size${p.id}" style="width: 100px; height: 50px; margin-left: 30px; display: none;">
													<span class="span" onclick="addToCart('${i}','${c.type.toLowerCase()}')">Inteira</span>
													<span class="span" onclick="addToCart('${i}','${c.type.toLowerCase()}','${true}','size${p.id}')">1/2</span>
												</div>
												<div id="half${p.id}" style="width: 250px; height: 50px; margin: 3px 0px 0px 10px; display: none;">
													<span class="span2">Escolha a segunda opção !</span>
												</div>
											</div>									
										</g:if>
									</g:each>
								</fieldset>
							</div>
						</g:if>
					</g:each>
					
					<br><br>
					
					<h1>Bebidas</h1>
					
					<g:each in="${category}" var="c">
						<g:if test="${c.type == 'Bebida' }">
							<h1 onclick="show('category${c.id}')" style="cursor: pointer; border: outset 2px; background-color: #efefef; width: 250px; text-align: center;">${c.name}</h1>
							<div id="category${c.id}" style="display: none;">
								<fieldset class="form" style="padding: 0;">
									<g:each in="${products}" var="p" status="i">
										<g:if test="${p.category.id.equals(c.id)}">
											<div id="div">
												<div id="pizza${p.id}" class="fieldcontain pizzas" onclick="addToCart('${i}','${c.type.toLowerCase()}')">
													<dl>
														<dt>
															<strong>${p.name}</strong><span>R$ ${p.cost}</span>
														</dt>
														<dd>${p.description}</dd>
													</dl>
												</div>												
											</div>									
										</g:if>
									</g:each>
								</fieldset>
							</div>
						</g:if>
					</g:each>
					
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
					
					--%>
					
				</g:form>
			</g:else>
		</div>
		<g:javascript src="/orders/tab.js"/>
		<g:javascript src="/orders/orders.js"/>
		<script type="text/javascript">		
			$('input[id*="spinner"]').spinner({min: 1});
		</script>
	</body>	
</html>