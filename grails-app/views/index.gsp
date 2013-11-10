<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Pizzaria Ilha de Capri</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="status" role="complementary" class="nav">
			<h1>Clientes</h1>
			<ul>
				<li><a class="create" href="${createLink(uri: '/client/create')}">Cadastrar</a></li>
				<li><a class="list" href="${createLink(uri: '/client/list')}">Consultar</a></li>				
			</ul>
			<h1>Pedidos</h1>
			<ul>
				<li><a class="create" href="${createLink(uri: '/orders/create')}">Cadastrar</a></li>
				<li><a class="list" href="${createLink(uri: '/orders/list')}">Consultar</a></li>				
			</ul>
			<h1>Produtos</h1>
			<ul>
				<li><a class="create" href="${createLink(uri: '/product/create')}">Cadastrar</a></li>
				<li><a class="list" href="${createLink(uri: '/product/list')}">Consultar</a></li>
				<li><a class="list" href="${createLink(uri: '/category/list')}">Tipos de Produtos</a></li>
			</ul>
			<h1>Relatório</h1>
			<ul>
				<li><a class="list" href="${createLink(uri: '/client/report')}">Clientes</a></li>
				<li><a class="list" href="${createLink(uri: '/orders/report')}">Pedidos</a></li>
				<li><a class="list" href="${createLink(uri: '/product/report')}">Produtos</a></li>
			</ul>
			<h1>Usuários</h1>
			<ul>
				<li><a class="create" href="${createLink(uri: '/account/create')}">Cadastrar</a></li>
				<li><a class="list" href="${createLink(uri: '/account/list')}">Consultar</a></li>
			</ul>
			<h1 style="width: 50px;">
				<a href="${createLink(uri: '/logout')}" style="padding-left: 5px;">Sair</a>
			</h1>


		</div>
		<div id="page-body" role="main">
			<div id="logo">
				<g:img uri="/images/skin/logo.png" />
			</div>
			
			<!--<h1>Pizzaria Ilha de Capri</h1>		
			<div id="controller-list" role="navigation">
				<ul>
					<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
						<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
					</g:each>
				</ul>
			</div>
			-->
			
		</div>
	</body>
</html>
