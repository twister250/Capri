
<%@ page import="capri.Client" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-client" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-client" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'client.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'client.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="address" title="${message(code: 'client.address.label', default: 'Address')}" />
					
						<g:sortableColumn property="cpf" title="${message(code: 'client.cpf.label', default: 'Cpf')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'client.active.label', default: 'Active')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${clientInstanceList}" status="i" var="clientInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${clientInstance.id}">${fieldValue(bean: clientInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: clientInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: clientInstance, field: "address")}</td>
					
						<td>${fieldValue(bean: clientInstance, field: "cpf")}</td>
					
						<td><g:formatBoolean boolean="${clientInstance.active}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${clientInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
