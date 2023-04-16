<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../../y/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../y/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="../../y/css/common.css">
    <link rel="stylesheet" href="../../y/css/modals.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script type="text/javascript" src="../../y/js/jquery.min.js"></script>
    <script type="text/javascript" src="../../y/js/jquery.form.min.js"></script>
    <script type="text/javascript" src="../../y/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../y/js/jquery.placeholder.min.js"></script>
    <script type="text/javascript" src="../../y/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../../y/js/vue.min.js"></script>
    <script type="text/javascript" src="../../y/js/common.js"></script>
    <script type="text/javascript" src="../../y/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        var vum;
        var page = 1;

        $(document).ready(function () {
            vum = new Vue({
                el: "#app",
                data: {
                    datas: [],
                    pages: []
                },
                methods: {
                    showData: function (p) {
                        page = p;
                        search(1, 'listAjax', 'searchForm', vum);
                    }
                }
            });
            vum.showData(page);

            $("#addForm").validate({
                submitHandler: function (form) {
                    $(form).ajaxSubmit({
                        dataType: "json",
                        success: function (data) {
                            alert(data.retMsg);
                            $("#addModal").modal("hide");
                            vum.showData(page);
                        },
                        error: function (data) {
                            alert(data.status);
                        }
                    });
                }
            });

            $("#importForm").validate({
                submitHandler: function (form) {
                    var btn = loading($("#importForm input[type='submit']"))
                    if (btn.isloading) {
                        return;
                    }
                    $(form).ajaxSubmit({
                        dataType: "json",
                        success: function (data) {
                            alert(data.retMsg);
                            $("#importModal").modal("hide");
                            vum.showData(page);
                            unloading(btn);
                        },
                        error: function (data) {
                            alert(data.status);
                            unloading(btn);
                        }
                    });
                }
            });

        });

        function add() {
            fillForm({});
            $('#username').attr("readOnly", false);
            $('#addForm').attr("action", "addAjax");
            $('#title').text("添加用户");
            $('#addModal').modal("toggle");
        }

        function del(id) {
            if (confirm("确定删除该用户吗？")) {
                $.ajax({
                    url: "deleteAjax",
                    type: "POST",
                    data: {
                        username: id
                    },
                    success: function (data) {
                        alert(data.retMsg);
                        vum.showData(page);
                    }
                });
            }
        }

        function reset(id) {
                $.ajax({
                    url: "resetPassword",
                    type: "POST",
                    data: {
                        username: id
                    },
                    success: function (data) {
                        alert(data.retMsg);
                    }
                });
        }

        function openImportForm() {
            $('#importForm').attr("action", "importAjax");
            $('#importModalLabel').text("导入用户");
            $('#importModal').modal("toggle");
        }

        function load(data) {
            $('#username').attr("readOnly", true);
            $('#addForm').attr("action", "updateAjax");
            $('#title').text("修改用户信息");
            $('#addModal').modal("toggle");
            fillForm(data);
        }

        function fillForm(obj) {
            $('#addForm input').val(function (index, value) {
                return obj[this.id];
            });
        }
    </script>
</head>
<body>
<div class="container-fluid" align="center">
    <div class="form-group" style="text-align: left">
        <form id="searchForm" class="card p-2">
            <input type="hidden" name="columns" value="username">
            <input type="hidden" name="columns" value="name">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="logicalopts" value="">
            <input type="hidden" name="logicalopts" value="and">
            <div class="input-group">
                <input type="text" name="values" class="form-control" placeholder="用户名">
                <input type="text" name="values" class="form-control" placeholder="姓名">
                <button class="btn btn-secondary" type="button" onClick="search(1,'listAjax','searchForm', vum);"><i
                        class="bi-search"></i> 搜索用户
                </button>
                <button class="btn btn-secondary" onClick="add();" type="button"><i class="bi-plus"></i> 添加用户
                </button>
                <button class="btn btn-secondary" onClick="openImportForm()" type="button"><i
                        class="bi-folder-plus"></i> 导入用户
                </button>
                <button class="btn btn-secondary" onClick="location.href='export'" type="button"><i
                        class="bi-folder-minus"></i> 导出用户
                </button>
            </div>
        </form>
    </div>


    <%--		<div class="container">--%>
    <%--		<header class="d-flex justify-content-center py-3">--%>
    <%--			<ul class="nav nav-pills">--%>
    <%--				<li class="nav-item">--%>
    <%--					<button class="btn btn-primary"--%>
    <%--											 onClick="search(1,'listAjax','searchForm', vum);">搜索用户--%>
    <%--					<span class="glyphicon glyphicon-search"></span>--%>
    <%--				</button>--%>
    <%--				</li>--%>
    <%--				<li class="nav-item"><button class="btn btn-primary" onClick="add();">添加用户</button></li>--%>
    <%--				<li class="nav-item"><button class="btn btn-primary" onClick="openImportForm()"><span class="glyphicon glyphicon-import"></span>导入用户</button></li>--%>
    <%--				<li class="nav-item"><button class="btn btn-primary" onClick="location.href='export'"><span class="glyphicon glyphicon-export"></span>导出用户</button></li>--%>
    <%--			</ul>--%>
    <%--		</header>--%>
    <%--	</div>--%>

    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content rounded-4 shadow">
                <div class="modal-header p-5 pb-4 border-bottom-0">
                    <!-- <h1 class="modal-title fs-5" >Modal title</h1> -->
                    <h1 class="fw-bold mb-0 fs-2" id="title">添加用户</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-5 pt-0">
                    <form id="addForm" method="post" action="" class="form-horizontal">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="username" name="username"
                                   placeholder="用户名">
                            <label for="username">用户名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="name" name="name" placeholder="姓名">
                            <label for="name">姓名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="classNumber" name="classNumber"
                                   placeholder="届-班号">
                            <label for="classNumber">届-班号</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control rounded-3" id="email" name="email"
                                   placeholder="邮箱">
                            <label for="email">邮箱</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="phone" name="phone"
                                   placeholder="手机号">
                            <label for="phone">手机号</label>
                        </div>
                        <button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="submit">确认添加</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="importModal" tabindex="-1" role="dialog"
         aria-labelledby="importModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="importModalLabel">导入用户</h4>
                </div>
                <form id="importForm" method="post" action="" enctype="multipart/form-data" class="form-horizontal">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="file" class="col-sm-3 control-label">Excel文件</label>
                            <div class="col-sm-9">
                                <input type="file" name="file" id="file" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <input type="submit" class="btn btn-primary" value="提交">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="app" class="bd-example-snippet bd-code-snippet">
        <div class="bd-example">
            <table class="table table-striped">
                <tr>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>届-班号</th>
                    <th>邮箱</th>
                    <th>电话号</th>
                    <th>操作</th>
                </tr>
                <tr v-for="data in datas">
                    <td>{{data.username}}</td>
                    <td>{{data.name}}</td>
                    <td>{{data.classNumber}}</td>
                    <td>{{data.email}}</td>
                    <td>{{data.phone}}</td>
                    <td>
                        <%--						<button title="编辑用户信息"--%>
                        <%--							@click="load(data)">--%>
                        <%--							<span class="glyphicon glyphicon-edit">编辑用户信息</span>--%>
                        <%--						</button>--%>
                        <button type="编辑用户信息" class="btn btn-sm btn-outline-secondary" @click="load(data)">
                            <span class="glyphicon glyphicon-edit">编辑用户信息</span>
                        </button>
                        <button title="重置密码" class="btn btn-sm btn-outline-secondary" @click="reset(data.username);">
                            <span class="glyphicon glyphicon-reset">重置密码</span>
                        </button>
                        <button type="删除用户" class="btn btn-sm btn-outline-secondary" @click="del(data.username);">
                            <span class="glyphicon glyphicon-remove">删除用户</span>
                        </button>
                    </td>
            </table>
            <span>总数量：{{pages.rowCount}}</span> <span>总页数：{{pages.lastPage}}</span>
            <button class="btn btn-default btn-sm"
                    @click="showData(pages.firstPage)">
                <i class="bi bi-chevron-double-left"></i>
            </button>
            <button class="btn btn-default btn-sm"
                    @click="showData(pages.prePage)">
                <i class="bi bi-chevron-left"></i>
            </button>
            <span>当前页：{{pages.pageNum}}</span>
            <button class="btn btn-default btn-sm"
                    @click="showData(pages.nextPage)">
                <i class="bi bi-chevron-right"></i>
            </button>
            <button class="btn btn-default btn-sm"
                    @click="showData(pages.lastPage)">
                <i class="bi bi-chevron-double-right"></i>
            </button>
        </div>
    </div>
</div>
</body>
</html>