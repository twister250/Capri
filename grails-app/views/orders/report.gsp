<%@ page import="capri.Orders" %>
<%@ page import="capri.Items" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		
		<link rel="stylesheet" href="${resource(dir: 'css/jquery-ui/', file: 'jquery-ui-1.10.3.custom.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/orders/', file: 'reports.css')}" type="text/css">
		<g:javascript src="jquery/jquery-1.9.1.js"/>
		<g:javascript src="jquery-ui/jquery-ui-1.10.3.js"/>
		
		<script>
			$(function() {
				$( "#from" ).datepicker({
					defaultDate: "+1w",
					changeMonth: true,
					numberOfMonths: 3,
					dateFormat: "dd/mm/yy",
					onClose: function( selectedDate ) {
						$( "#to" ).datepicker( "option", "minDate", selectedDate );
					}
				});
				$( "#to" ).datepicker({
					defaultDate: "+1w",
					changeMonth: true,
					numberOfMonths: 3,
					dateFormat: "dd/mm/yy",
					onClose: function( selectedDate ) {
						$( "#from" ).datepicker( "option", "maxDate", selectedDate );
					}
				});
			});
		</script>
		
		<script>
			var items = [
				{
					<g:each in="${items}" var="item" status="i">
					{
						"id": "${item.get(i)}",
					}<g:if test="${item.get(i) != item[-1]}">,</g:if>
				</g:each>
				}
			]		
		</script>
		
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

			<div class="range">
				<span id="range">Selecione o Período</span>
				<g:formRemote
					name="report" 
					url="[action: 'report']"
					before="validateRange()" 
					onSuccess="report(data)" 
					update="content"
					style="display: none;"
				>
					<p>Início: <input type="text" id="from" name="from"/></p>
					<p>Fim: <input type="text" id="to" name="to"/></p>
					<input type="submit" id="dateRange" value="Enviar"/>
				</g:formRemote>
			</div>
			
			<div id="content">
				<table id="table" style="margin-top: 40px;">
					<thead>
						<tr>
							
							<g:sortableColumn property="id" title="${message(code: 'orders.date.label', default: 'ID')}" />
							
							<g:sortableColumn property="client" title="${message(code: 'orders.date.label', default: 'Cliente')}" />
						
							<g:sortableColumn property="date" title="${message(code: 'orders.date.label', default: 'Data')}" />
							
							<g:sortableColumn property="${items}" title="${message(code: 'orders.date.label', default: 'Items')}" />
						
							<g:sortableColumn property="total" title="${message(code: 'orders.total.label', default: 'Total')}" />
						
						</tr>
					</thead>
					<tbody id="listBody">
					<g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td>${fieldValue(bean: ordersInstance, field: "id")}</td>
						
							<td><g:link action="show" id="${ordersInstance.id}">${fieldValue(bean: ordersInstance, field: "client.name")}</g:link></td>
						
							<td><g:formatDate date="${ordersInstance.date}" format="dd/MM/yyyy"/></td>
							
							<td>${items[i]}</td>
							
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
		
		<h1>${items}</h1>
		
		<g:javascript src="/orders/reports.js"/>
	</body>
</html>
