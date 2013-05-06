<%@ page import="capri.Client" %>



<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="client.name.label" default="Nome:" />		
	</label>
	<g:textField name="name" required="" value="${clientInstance?.name}"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'phone', 'error')} required">
	<label for="phone">
		<g:message code="client.phone.label" default="Telefone:" />		
	</label>
	<g:textField name="phone" required="" value="${clientInstance?.phone}"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'address', 'error')} required">
	<label for="address">
		<g:message code="client.address.label" default="Endereço:" />		
	</label>
	<g:textField name="address" required="" value="${clientInstance?.address}"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'cpf', 'error')} ">
	<label for="cpf">
		<g:message code="client.cpf.label" default="CPF:" />
		
	</label>
	<g:textField name="cpf" value="${clientInstance?.cpf}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="client.active.label" default="Ativo" />
		
	</label>
	<g:checkBox name="active" value="${clientInstance?.active}" />
</div>

<%--
<div class="fieldcontain ${hasErrors(bean: clientInstance, field: 'orders', 'error')} ">
	<label for="orders">
		<g:message code="client.orders.label" default="Orders" />
		
	</label>


<ul class="one-to-many">
<g:each in="${clientInstance?.orders?}" var="o">
    <li><g:link controller="orders" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="orders" action="create" params="['client.id': clientInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'orders.label', default: 'Orders')])}</g:link>
</li>
</ul>

</div>
--%>
