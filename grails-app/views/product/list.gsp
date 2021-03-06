
<%@ page import="capri.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-product" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="create" action="create">Adicionar Produto</g:link></li>
			</ul>
		</div>
		<div id="list-product" class="content scaffold-list" role="main">
			<h1>Lista de Produtos</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'product.name.label', default: 'Nome')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'product.description.label', default: 'Descrição')}" />
					
						<g:sortableColumn property="cost" title="${message(code: 'product.cost.label', default: 'Valor')}" />
					
						<g:sortableColumn property="category" title="${message(code: 'product.cost.label', default: 'Categoria')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${productInstanceList}" status="i" var="productInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: productInstance, field: "description")}</td>
					
						<td><g:formatNumber number="${productInstance.cost}" type="currency" currencySymbol="R\$ "/></td>
					
						<td>${fieldValue(bean: productInstance, field: "category.name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${productInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
