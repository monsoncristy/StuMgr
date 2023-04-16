<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>角色管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${ctx}/y/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/y/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${ctx}/y/css/common.css">
	<link rel="stylesheet" href="../../y/css/modals.css">
<script type="text/javascript" src="${ctx}/y/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/jquery.placeholder.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/vue.min.js"></script>
<script type="text/javascript" src="${ctx}/y/js/common.js"></script>
	<script type="text/javascript" src="../../y/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	var vum;
	//var page = 1;

	$(document).ready(function() {
		vum = new Vue({
			el : "#app",
			data : {
				datas : []
			},
			methods : {
				showData : function() {
					//page = p;
					$.ajax({
						url : "listRolesAjax",
						type : "POST",
						success : function(data) {
							vum.datas = data.result;
						}
					})
				}
			}
		});
		vum.showData();

		$("#addForm").validate({
			submitHandler : function(form) {
				$(form).ajaxSubmit({
					dataType : "json",
					success : function(data) {
						alert(data.retMsg);
						$("#addModal").modal("hide");
						vum.showData();
					},
					error : function(data) {
						alert(data.status);
					}
				});
			}
		});
		
	});

	function add() {
		fillForm({});
		$('#id').attr("readOnly", false);
		$('#addForm').attr("action", "addRoleAjax");
		$('#addModalLabel').text("添加角色信息");
		$('#addModal').modal("toggle");
	}

	function del(id) {
		if (confirm("确定删除该角色吗？")) {
			$.ajax({
				url : "deleteRoleAjax",
				type : "POST",
				data : {
					id : id
				},
				success : function(data) {
					alert(data.retMsg);
					vum.showData();
				}
			});
		}
	}

	// function load(data) {
	// 	$('#id').attr("readOnly", true);
	// 	$('#addForm').attr("action", "updateRoleAjax");//class=???
	// 	$('#addModalLabel').text("修改服务信息");
	// 	$('#addModal').modal("toggle");//让模态框弹出来
	// 	fillForm(data);//
	// }
	function load(data) {
		$('#username').attr("readOnly", true);
		$('#addForm').attr("action", "updateRoleAjax");
		$('#title').text("修改角色信息");
		$('#addModal').modal("toggle");
		fillForm(data);
	}

	function fillForm(obj) {
		$('#addForm input:text').val(function(index, value) {
			return obj[this.id];
		});
	}
</script>
</head>
<body>
	<div class="container-fluid" align="center">
		<p align="left">
			<button class="btn btn-secondary" onClick="add();">添加角色</button>
		</p>


		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
			aria-labelledby="addModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
<%--						<button type="button" class="close" data-dismiss="modal"--%>
<%--							aria-label="Close">--%>
<%--							<span aria-hidden="true">&times;</span>--%>
<%--						</button>--%>
						<h4 class="modal-title" id="addModalLabel">添加角色</h4>
					</div>
					<form id="addForm" method="post" action="" class="form-horizontal">
						<div class="modal-body">
							<div class="form-group">
								<label for="roleId" class="col-sm-3 control-label">角色代码</label>
								<div class="col-sm-9">
									<input type="text" name="roleId" id="roleId" class="form-control"
										placeholder="角色代码">
								</div>
							</div>
							<div class="form-group">
								<label for="role" class="col-sm-3 control-label">角色名称</label>
								<div class="col-sm-9">
									<input type="text" name="role" id="role" class="form-control"
										placeholder="角色名称">
								</div>
							</div>
						</div>
						<div class="modal-footer">
<%--							<button type="button" class="btn btn-default"--%>
<%--								data-dismiss="modal">关闭</button>--%>
							<input type="submit" class="btn btn-primary" value="提交">
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<div id="app">
			<table class="table table-hover">
				<tr>
					<th>角色代码</th>
					<th>角色名称</th>
					<th>操作</th>
				</tr>
				<tr v-for="data in datas">
					<td>{{data.roleId}}</td>
					<td>{{data.role}}</td>
					<td>
						<button type="编辑角色信息" class="btn btn-sm btn-outline-secondary" @click="load(data)">
							<span class="glyphicon glyphicon-edit">编辑角色信息</span>
						</button>
						<button class="btn btn-sm btn-outline-secondary" title="删除角色" @click="del(data.id);">
							<span class="glyphicon glyphicon-remove">删除角色</span>
						</button>
						<button class="btn btn-sm btn-outline-secondary" title="管理权限" @click="location.href='listPermsInRole?roleId=' + data.roleId">
							<span class="glyphicon glyphicon-th">管理权限</span>
						</button>
						<button class="btn btn-sm btn-outline-secondary" title="管理用户" @click="location.href='listUsersInRole?roleId=' + data.roleId">
							<span class="glyphicon glyphicon-user">管理用户</span>
						</button>
					</td>
			</table>
		</div>
	</div>
</body>
</html>