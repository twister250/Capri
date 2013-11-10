<%@ page import="capri.Account" %>
<%@ page import="capri.Role" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Contas')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-category" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="create" action="create">Adicionar Usuário</g:link></li>
			</ul>
		</div>
		<div id="list-category" class="content scaffold-list" role="main">
			<h1>Usuários</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="username" title="Nome" />
						
						<g:sortableColumn property="enable" title="${message(code: 'client.active.label', default: 'Ativo')}" />
						
						<g:sortableColumn property="role" title="Conta" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accountInstanceList}" status="i" var="accountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${accountInstance.id}">${accountInstance.username}</g:link></td>
						
						<td><g:formatBoolean boolean="${accountInstance.enabled}" /></td>
						
						<td>
							<g:if test="${accountInstance.id == role[i][0].id}">${Role.findById(role[i][1].id).authority}</g:if>
						</td>
					
					</tr>
					
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${accountInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
