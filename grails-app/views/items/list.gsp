
<%@ page import="capri.Items" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'items.label', default: 'Items')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-items" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-items" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="amount" title="${message(code: 'items.amount.label', default: 'Amount')}" />
					
						<th><g:message code="items.order.label" default="Order" /></th>
					
						<th><g:message code="items.product.label" default="Product" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${itemsInstanceList}" status="i" var="itemsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${itemsInstance.id}">${fieldValue(bean: itemsInstance, field: "amount")}</g:link></td>
					
						<td>${fieldValue(bean: itemsInstance, field: "order")}</td>
					
						<td>${fieldValue(bean: itemsInstance, field: "product")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${itemsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
