<%@ page import="capri.Account" %>
<%@ page import="capri.Role" %>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="account.username.label" default="Nome:" />		
	</label>
	<g:textField name="username" required="" value="${accountInstance?.username}"/>
	<span class="required-indicator">* Preenchimento obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="account.password.label" default="Senha:" />		
	</label>
	<g:textField name="password" required="" value="${accountInstance?.password}"/>
	<span class="required-indicator">* Preenchimento obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="client.enabled.label" default="Ativo:" />
		
	</label>
	<g:checkBox name="enabled" value="${accountInstance?.enabled}" />
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'role', 'error')}">
	<label for="role">
		<g:message code="account.role.label" default="Conta:" />
	</label>
	<g:select name="role" from="${role.authority}" keys="${role.id}"/>
</div>

<%--
<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'product', 'error')} ">
	<label for="product">
		<g:message code="account.product.label" default="Produto:" />
		
	</label>
<ul class="one-to-many">
<g:each in="${accountInstance?.product?}" var="p">
    <li><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="product" action="create" params="['account.id': accountInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'product.label', default: 'Product')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="account.type.label" default="Tipo de Produto:" />		
	</label>
	<g:select name="type" from="${['Pizza','Bebida']}"/>
</div>

--%>