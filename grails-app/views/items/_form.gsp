<%@ page import="capri.Items" %>



<div class="fieldcontain ${hasErrors(bean: itemsInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="items.amount.label" default="Amount" />		
	</label>
	<g:field name="amount" type="number" value="${itemsInstance.amount}" required=""/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: itemsInstance, field: 'order', 'error')} required">
	<label for="order">
		<g:message code="items.order.label" default="Order" />		
	</label>
	<g:select id="order" name="order.id" from="${capri.Orders.list()}" optionKey="id" required="" value="${itemsInstance?.order?.id}" class="many-to-one"/>
	<span class="required-indicator">* obrigatório</span>
</div>

<div class="fieldcontain ${hasErrors(bean: itemsInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="items.product.label" default="Product" />		
	</label>
	<g:select id="product" name="product.id" from="${capri.Product.list()}" optionKey="id" required="" value="${itemsInstance?.product?.id}" class="many-to-one"/>
	<span class="required-indicator">* obrigatório</span>
</div>

