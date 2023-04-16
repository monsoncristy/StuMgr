<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<style>
	body {
		background:url("../y/pic/welcome.jpg")  no-repeat center center;   /*加载背景图*/   /* 背景图不平铺 */
		background-size:cover;  /* 让背景图基于容器大小伸缩 */
		background-attachment:fixed;        /* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */    //此条属性必须设置否则可能无效/
	background-color:#CCCCCC;   /* 设置背景颜色，背景图加载过程中会显示背景色 */
	}
</style>
<html>
<head>
	<title>欢迎</title>
</head>
<body>
	<div class="container-fluid" >
		<h1 >欢迎使用本系统</h1>
<%--		<img src="../y/pic/pic1.jpg"/>--%>
	</div>
</body>
</html>