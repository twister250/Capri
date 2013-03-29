<%@ page import="capri.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${categoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'product', 'error')} ">
	<label for="product">
		<g:message code="category.product.label" default="Product" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.product?}" var="p">
    <li><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="product" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'product.label', default: 'Product')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="category.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${categoryInstance?.type}"/>
</div>

