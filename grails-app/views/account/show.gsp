<%@ page import="capri.Account" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-account" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Usuários</g:link></li>
				<li><g:link class="create" action="create">Adicionar Usuários</g:link></li>
			</ul>
		</div>
		<div id="show-account" class="content scaffold-show" role="main">
			<h1>Usuário</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list account">
			
				<g:if test="${accountInstance?.username}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="account.username.label" default="Nome:" /></span>					
					<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${accountInstance}" field="username"/></span>					
				</li>
				</g:if>
				
				<g:if test="${accountInstance?.enabled}">
					<li class="fieldcontain">
						<span id="active-label" class="property-label">
							<g:message code="account.active.label" default="Ativo:" />
						</span>
						<span class="property-value" aria-labelledby="active-label">
							<g:formatBoolean boolean="${accountInstance?.enabled}" />
						</span>
					</li>
				</g:if>
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${accountInstance?.id}" />
					<g:link class="edit" action="edit" id="${accountInstance?.id}">
						<g:message code="default.button.edit.label" default="Edit" />
					</g:link>
					<g:actionSubmit 
						class="delete" 
						action="delete" 
						value="${message(code: 'default.button.delete.label', default: 'Delete')}" 
						onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" 
					/>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
