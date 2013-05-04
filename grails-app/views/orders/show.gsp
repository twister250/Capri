<%@ page import="capri.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Pedidos</g:link></li>
				<li><g:link class="create" action="create">Adicionar Pedido</g:link></li>
			</ul>
		</div>
		<div id="show-orders" class="content scaffold-show" role="main">
			<h1>Pedido</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list orders">			
				<g:if test="${ordersInstance?.client}">
				<li class="fieldcontain">
					<span id="client-label" class="property-label"><g:message code="orders.client.label" default="Cliente: " /></span>					
					<span class="property-value" aria-labelledby="client-label">
						<g:link controller="client" action="show" id="${ordersInstance?.client?.id}">${ordersInstance?.client?.name}</g:link>
					</span>					
				</li>
				</g:if>
				
				<g:if test="${ordersInstance?.client}">
				<li class="fieldcontain">
					<span id="client-label" class="property-label"><g:message code="orders.client.label" default="Endereço: " /></span>
					<span class="property-value" aria-labelledby="client-label">${ordersInstance?.client?.address}</span>
				</li>
				</g:if>
				
				<g:if test="${ordersInstance?.client}">
				<li class="fieldcontain">
					<span id="client-label" class="property-label"><g:message code="orders.client.label" default="Telefone: " /></span>
					<span class="property-value" aria-labelledby="client-label">${ordersInstance?.client?.phone}</span>
				</li>
				</g:if>
			
				<g:if test="${ordersInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="orders.date.label" default="Data: " /></span>					
					<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${ordersInstance?.date}"/></span>					
				</li>
				</g:if>
				
				<%--
				<g:if test="${ordersInstance?.total}">
				<li class="fieldcontain">
					<span id="total-label" class="property-label"><g:message code="orders.total.label" default="Total: " /></span>					
					<span class="property-value" aria-labelledby="total-label">R$ <g:fieldValue bean="${ordersInstance}" field="total"/></span>					
				</li>
				</g:if>
				
				
				<li class="fieldcontain">
					<span id="items-label" class="property-label"><g:message code="orders.items.label" default="Items: " /></span>
					<g:each in="${ordersInstance.items}" var="item">
						<span class="property-value" aria-labelledby="items-label">${item?.amount} - ${item?.product.name}</span>
					</g:each>
				</li>
				--%>
			</ol>
			
			<h1>Itens do Pedido</h1>
			
			<fieldset>
				<g:if test="${ordersInstance?.items}">
					<table>
						<thead>
							<tr>
								<g:sortableColumn property="item" title="Produto"/>
								<g:sortableColumn property="type" title="Tipo"/>
								<g:sortableColumn property="cost" title="Preço Unitário"/>
								<g:sortableColumn property="amount" title="Quantidade"/>							
								<g:sortableColumn property="subtotal" title="Sub-Total"/>
							</tr>
						</thead>
						<tbody>
							<g:set var="totalamount" value="${0}"/>
							<g:each in="${ordersInstance.items}" var="item">							
								<tr>									
									<td>${item?.product.name}</td>
									<td>${item?.product.category.type}</td>
									<td>R$ ${item?.product.cost}</td>
									<td>${item?.amount}</td>						
									<td>R$ ${item?.product.cost * item?.amount}</td>
								</tr>
								<g:set var="totalamount" value="${totalamount = (totalamount + item?.amount)}"/>
							</g:each>
						</tbody>
						<tfoot>
							<tr>
								<th>Total</th>
								<th></th>
								<th></th>
								<th>${totalamount}</th>
								<th>R$ ${ordersInstance.total}</th>
							</tr>
						</tfoot>
					</table>				
				</g:if>
			</fieldset>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${ordersInstance?.id}" />
					<g:link class="edit" action="edit" id="${ordersInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
