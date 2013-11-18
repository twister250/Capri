
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
				<li><g:link class="create" action="create">Cadastrar Cliente</g:link></li>
			</ul>
		</div>
		<div id="list-client" class="content scaffold-list" role="main">
			<h1>Lista de Clientes</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'client.name.label', default: 'Nome')}" />
					
						<g:sortableColumn property="data" title="${message(code: 'client.phone.label', default: 'Último Pedido')}"/>
						
						<g:sortableColumn property="amount" title="Total de Pedidos" style="text-align: center;"/>
						
						<g:sortableColumn property="total" title="Total"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${clientInstanceList}" status="i" var="c">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${c[0]}">${c[1]}</g:link></td>
					
						<td><g:formatDate date="${c[2]}" format="dd/MM/yyyy"/></td>
						
						<td style="text-align: center;">${c[3]}</td>
						
						<td><g:formatNumber number="${c[4]}" type="currency" currencySymbol="R\$"/></td>
					
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
