
<%@ page import="capri.Client" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-client" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Clientes</g:link></li>
				<li><g:link class="create" action="create">Cadastrar Cliente</g:link></li>
			</ul>
		</div>
		<div id="show-client" class="content scaffold-show" role="main">
			<h1>Cliente</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list client">
			
				<g:if test="${clientInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="client.name.label" default="Nome:" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${clientInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clientInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="client.phone.label" default="Telefone:" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${clientInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clientInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="client.address.label" default="Endereço:" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${clientInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clientInstance?.cpf}">
				<li class="fieldcontain">
					<span id="cpf-label" class="property-label"><g:message code="client.cpf.label" default="CPF:" /></span>
					
						<span class="property-value" aria-labelledby="cpf-label"><g:fieldValue bean="${clientInstance}" field="cpf"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clientInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="client.active.label" default="Ativo:" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:formatBoolean boolean="${clientInstance?.active}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${clientInstance?.orders}">
				<li class="fieldcontain">
					<span id="orders-label" class="property-label"><g:message code="client.orders.label" default="Orders" /></span>
					
						<g:each in="${clientInstance.orders}" var="o">
						<span class="property-value" aria-labelledby="orders-label"><g:link controller="orders" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${clientInstance?.id}" />
					<g:link class="edit" action="edit" id="${clientInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
