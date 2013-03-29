<%@ page import="capri.Orders" %>
<%@ page import="capri.Items" %>

<g:hiddenField name="clientId" value="${client.id}"/>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'client', 'error')} required">
	<label for="client">
		<g:message code="orders.client.label" default="Cliente:" />		
	</label>	
	<g:field type="text" name="client" value="${client.name}" readonly="true" style="width: 300px; border: 0"/>		
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'client', 'error')} required">
	<label for="address">
		<g:message code="orders.client.label" default="Endereço:" />		
	</label>	
	<g:field type="text" name="address" value="${client.address}" readonly="true" style="width: 300px; border: 0"/>		
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'client', 'error')} required">
	<label for="phone">
		<g:message code="orders.client.label" default="Telefone:" />		
	</label>	
	<g:field type="text" name="phone" value="${client.phone}" readonly="true" style="width: 300px; border: 0"/>		
</div>

<%--
<%@ page import="capri.Orders" %>



<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'client', 'error')} required">
	<label for="client">
		<g:message code="orders.client.label" default="Client" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="client" name="client.id" from="${capri.Client.list()}" optionKey="id" required="" value="${ordersInstance?.client?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="orders.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${ordersInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'total', 'error')} required">
	<label for="total">
		<g:message code="orders.total.label" default="Total" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="total" value="${fieldValue(bean: ordersInstance, field: 'total')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="orders.items.label" default="Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${ordersInstance?.items?}" var="i">
    <li><g:link controller="items" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="items" action="create" params="['orders.id': ordersInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'items.label', default: 'Items')])}</g:link>
</li>
</ul>

</div>
--%>