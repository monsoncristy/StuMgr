<%--
  Created by IntelliJ IDEA.
  User: qh
  Date: 2018/6/2
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cust.slei.login.*"%>
<%@ page import="cust.slei.login.MyAuthenticationException" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>管理员登录</title>

    <!-- Bootstrap core CSS -->
    <link href="../y/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../y/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../y/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="../y/js/html5shiv.min.js"></script>
    <script src="../y/js/respond.min.js"></script>
    <![endif]-->

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

	<!-- Custom styles for this template -->
	<link href="../y/css/sign-in.css" rel="stylesheet">
</head>

<body>


	<main class="form-signin w-100 m-auto">
		<form action="" method="post" class="form-signin">
			<h1 class="h3 mb-3 fw-normal">登录</h1>
			<%
				Exception ex = (Exception) request.getAttribute("shiroLoginFailure");
				if (ex != null) {
			%>
			<div class="alert alert-danger">
				<%=ex instanceof MyAuthenticationException ? ex.getMessage() : "登录验证失败！"%>
			</div>
			<%
				}
			%>
			<div class="form-floating">
				<input name="username" type="text" id="username" class="form-control" placeholder=户名" required autofocus>
				<label for="username" class="sr-only floatingInput">用户名</label>
			</div>

			<div class="form-floating">
				<input name="password" type="password" id="password" class="form-control" placeholder="密码" required>
				<label for="password" class="sr-only floatingPassword">密码</label>
			</div>

			<div class="checkbox mb-3">
				<label>
					<input name="rememberMe" type="checkbox" id="rememberMe" value="true">记住我
				</label>
			</div>


			<button class="w-100 btn btn-lg btn-primary" type="submit">登录</button>
			<button class="w-100 btn btn-sm btn-secondary" type="button" url="../Result.jsp">查询成绩</button>
			<p class="mt-5 mb-3 text-muted">&copy; 2017–2022 Mr.Yang</p>
		</form>
	</main>


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../y/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
