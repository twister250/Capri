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