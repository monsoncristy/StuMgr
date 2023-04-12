<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">
<title>主界面</title>
<script type="text/javascript" src="../y/js/jquery.min.js"></script>
<link href="../y/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="../y/css/dashboard.css" rel="stylesheet" type="text/css" />



	<link href="../y/css/navbars.css" rel="stylesheet">
<style>
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}

	@media (min-width: 768px) {
		.bd-placeholder-img-lg {
			font-size: 3.5rem;
		}
	}

	.b-example-divider {
		height: 3rem;
		background-color: rgba(0, 0, 0, .1);
		border: solid rgba(0, 0, 0, .15);
		border-width: 1px 0;
		box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
	}

	.b-example-vr {
		flex-shrink: 0;
		width: 1.5rem;
		height: 100vh;
	}

	.bi {
		vertical-align: -.125em;
		fill: currentColor;
	}

	.nav-scroller {
		position: relative;
		z-index: 2;
		height: 2.75rem;
		overflow-y: hidden;
	}

	.nav-scroller .nav {
		display: flex;
		flex-wrap: nowrap;
		padding-bottom: 1rem;
		margin-top: -1px;
		overflow-x: auto;
		text-align: center;
		white-space: nowrap;
		-webkit-overflow-scrolling: touch;
	}
</style>
<script>
	
</script>
</head>

<body style="padding-top: 0px">
<main>
<nav class="navbar navbar-expand navbar-dark bg-dark" aria-label="Second navbar example">
	<div class="container-fluid container-sm">
		<a class="navbar-brand" href="#">素质评测管理系统</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarsExample02">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" data-src="welcome.jsp" href="#a">主页</a>
				</li>
				<shiro:hasRole name="sa">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">人员管理</a>
					<ul class="dropdown-menu">
						<shiro:hasPermission name="jsgl">
						<li><a class="dropdown-item" href="#a" data-toggle="tab"
							   data-src="users/listUsers.jsp">用户管理</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="jsgl">
						<li><a class="dropdown-item" href="#a" data-toggle="tab"
							   data-src="roles/listRoles.jsp">角色管理</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="qxgl">
							<li><a class="dropdown-item" href="#a" data-toggle="tab"
								   data-src="perms/listPerms.jsp">权限管理</a></li>
						</shiro:hasPermission>
						<li><a class="dropdown-item" href="#a">Another action</a></li>
					</ul>
				</li>
				</shiro:hasRole>
				<li class="nav-item">
					<a class="nav-link" href="#a" data-src="changepasswd" data-toggle="tab">修改密码</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="logout">退出</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Link</a>
				</li>
			</ul>
			<form role="search">
				<input class="form-control" type="search" placeholder="Search" aria-label="Search">
			</form>
		</div>
	</div>
</nav>

	<div class="container-fluid">
		<div class="tab-pane active" id="a">
			<iframe src="welcome.jsp" frameborder="0" scrolling="auto"
					style="width: 100%; height: 80vh"></iframe>
		</div>
	</div>
</main>



<%--	<nav class="navbar navbar-inverse navbar-fixed-top">--%>
<%--		<div class="container-fluid">--%>
<%--			<div class="navbar-header">--%>
<%--				<button type="button" class="navbar-toggle collapsed"--%>
<%--					data-toggle="collapse" data-target="#navbar" aria-expanded="false"--%>
<%--					aria-controls="navbar">--%>
<%--					<span class="sr-only">Toggle navigation</span> <span--%>
<%--						class="icon-bar"></span> <span class="icon-bar"></span> <span--%>
<%--						class="icon-bar"></span>--%>
<%--				</button>--%>
<%--				<a class="navbar-brand" href="#">管理系统</a>--%>
<%--			</div>--%>
<%--			<div class="navbar-collapse collapse">--%>
<%--				<ul class="nav navbar-nav navbar-right">--%>
<%--					<li><a href="#a" data-src="changepasswd">修改密码</a></li>--%>
<%--					<li><a href="logout">退出</a></li>--%>
<%--				</ul>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</nav>--%>

<%--	<div class="container-fluid">--%>
<%--		<div class="row">--%>
<%--			<div id="navbar" class="col-sm-3 col-md-2 col-lg-2 sidebar">--%>
<%--				<ul class="nav nav-sidebar" id="myTabs">--%>
<%--					<li class="active"><a href="#a" data-toggle="tab"--%>
<%--						data-src="welcome.jsp"><span class="glyphicon glyphicon-home"></span>--%>
<%--							首页</a></li>--%>
<%--					<shiro:hasPermission name="bmgl">--%>
<%--					<li><a href="#a" data-toggle="tab"--%>
<%--						data-src="orgs/listOrgs.jsp"><span--%>
<%--							class="glyphicon glyphicon-tree-conifer"></span> 部门管理</a></li>--%>
<%--					</shiro:hasPermission>--%>
<%--					<shiro:hasPermission name="yhgl">--%>
<%--					<li><a href="#a" data-toggle="tab"--%>
<%--						data-src="users/listUsers.jsp"><span--%>
<%--							class="glyphicon glyphicon-user"></span> 用户管理</a></li>--%>
<%--					</shiro:hasPermission>--%>
<%--					<shiro:hasPermission name="jsgl">--%>
<%--					<li><a href="#a" data-toggle="tab"--%>
<%--						data-src="roles/listRoles.jsp"><span--%>
<%--							class="glyphicon glyphicon-th-large"></span> 角色管理</a></li>--%>
<%--					</shiro:hasPermission>--%>
<%--					<shiro:hasPermission name="qxgl">--%>
<%--					<li><a href="#a" data-toggle="tab"--%>
<%--						data-src="perms/listPerms.jsp"><span--%>
<%--							class="glyphicon glyphicon-th"></span> 权限管理</a></li>--%>
<%--					</shiro:hasPermission>--%>

<%--					<li><a href="#a" data-src="changepasswd" data-toggle="tab">修改密码</a></li>--%>
<%--					<li><a href="logout">退出</a></li>--%>
<%--				</ul>--%>
<%--			</div>--%>

<%--		</div>--%>
<%--	</div>--%>

	<script src="../y/js/jquery.min.js" type="text/javascript"></script>
	<script src="../y/js/jquery.form.min.js" type="text/javascript"></script>
	<script src="../y/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../y/js/bootstrap.bundle.min.js"></script>
	<script src="../y/js/holder.min.js" type="text/javascript"></script>

	<script>
		$(function() {
			$('a')
					.click(
							function() {
								$("li").removeClass("active");
								$(this).parents("li").addClass("active");
								var src = $(this).attr('data-src');

								if (src === undefined) {//没有data-src的就是一级菜单
									var span = $(this).children("span:last");
									var cls = span.attr("class");
									console.log(cls);
									if (cls == "pull-right glyphicon glyphicon-chevron-down") {
										span
												.attr("class",
														"pull-right glyphicon glyphicon-chevron-right");
									} else if (cls == "pull-right glyphicon glyphicon-chevron-right") {
										span
												.attr("class",
														"pull-right glyphicon glyphicon-chevron-down");
									}
									return;
								}

								var paneId = $(this).attr('href');
								$(paneId + " iframe").attr("src", src);
								if ($(this).attr('data-toggle') === undefined) {
									return false;
								}
							});
		});
	</script>
</body>
</html>
