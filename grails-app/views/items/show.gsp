
<%@ page import="capri.Items" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'items.label', default: 'Items')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-items" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-items" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list items">
			
				<g:if test="${itemsInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="items.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${itemsInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemsInstance?.order}">
				<li class="fieldcontain">
					<span id="order-label" class="property-label"><g:message code="items.order.label" default="Order" /></span>
					
						<span class="property-value" aria-labelledby="order-label"><g:link controller="orders" action="show" id="${itemsInstance?.order?.id}">${itemsInstance?.order?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${itemsInstance?.product}">
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="items.product.label" default="Product" /></span>
					
						<span class="property-value" aria-labelledby="product-label"><g:link controller="product" action="show" id="${itemsInstance?.product?.id}">${itemsInstance?.product?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${itemsInstance?.id}" />
					<g:link class="edit" action="edit" id="${itemsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
