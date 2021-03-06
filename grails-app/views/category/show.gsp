
<%@ page import="capri.Category" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-category" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list">Listar Categorias</g:link></li>
				<li><g:link class="create" action="create">Adicionar Categoria</g:link></li>
			</ul>
		</div>
		<div id="show-category" class="content scaffold-show" role="main">
			<h1>Categoria</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list category">
			
				<g:if test="${categoryInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="category.name.label" default="Nome:" /></span>					
					<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${categoryInstance}" field="name"/></span>					
				</li>
				</g:if>
				
				<%--
				<g:if test="${categoryInstance?.product}">
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="category.product.label" default="Product" /></span>					
					<g:each in="${categoryInstance.product}" var="p">
						<span class="property-value" aria-labelledby="product-label">
							<g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>
						</span>
					</g:each>					
				</li>
				</g:if>
				--%>
			
				<g:if test="${categoryInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="category.type.label" default="Tipo:" /></span>					
					<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${categoryInstance}" field="type"/></span>					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${categoryInstance?.id}" />
					<g:link class="edit" action="edit" id="${categoryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
