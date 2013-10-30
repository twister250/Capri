<%@ page import="capri.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	</head>
	<body>
		<a href="#list-orders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="create" action="create">Novo Pedido</g:link></li>
			</ul>
		</div>
		<div id="list-orders" class="content scaffold-list" role="main">
			<h1>Relatório de Pedidos</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:formRemote 	
				name="report" 
				url="[action: 'reports']" 
				onSuccess="report(data)" 
				update="content"
			>
				<input type="submit" name="d" value="Vendas do Dia">
				<input type="submit" name="s" value="Vendas da Última Semana">
				<input type="submit" name="m" value="Vendas do Último Mês">
			</g:formRemote>
			
			
			<div id="content">				
				<table style="margin-top: 100px;">
					<thead>
						<tr>
							
							<g:sortableColumn property="client" title="${message(code: 'orders.date.label', default: 'Cliente')}" />
						
							<g:sortableColumn property="date" title="${message(code: 'orders.date.label', default: 'Data')}" />
						
							<g:sortableColumn property="total" title="${message(code: 'orders.total.label', default: 'Total')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${ordersInstance.id}">${fieldValue(bean: ordersInstance, field: "client.name")}</g:link></td>
						
							<td><g:formatDate date="${ordersInstance.date}" /></td>
						
							<td>R$ ${fieldValue(bean: ordersInstance, field: "total")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${ordersInstanceTotal}" />
				</div>
			</div>
		</div>
		<g:javascript src="/orders/reports.js"/>
	</body>
</html>
