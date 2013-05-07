<%@ page import="capri.Product" %>



<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="product.name.label" default="Nome:" />		
	</label>
	<g:textField name="name" required="" value="${productInstance?.name}"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="product.description.label" default="Descrição:" />		
	</label>
	<g:textField name="description" required="" value="${productInstance?.description}"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'cost', 'error')} required">
	<label for="cost">
		<g:message code="product.cost.label" default="Preço:" />		
	</label>
	<g:field name="cost" value="${fieldValue(bean: productInstance, field: 'cost')}" required=""/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="product.category.label" default="Categoria:" />		
	</label>
	<g:select id="category" name="category.id" from="${capri.Category.list()}" optionKey="id" optionValue="name" required="" value="${productInstance?.category?.id}" class="many-to-one"/>
	<span class="required-indicator">* obrigatório</span>
</div>

