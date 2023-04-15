<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>成绩管理</title>
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

        // function add() {
        //     fillForm({});
        //     $('#username').attr("readOnly", false);
        //     $('#addForm').attr("action", "addAjax");
        //     $('#title').text("添加学生");
        //     $('#addModal').modal("toggle");
        // }

        // function del(id) {
        //     if (confirm("确定删除该学生吗？")) {
        //         $.ajax({
        //             url: "deleteAjax",
        //             type: "POST",
        //             data: {
        //                 id: id
        //             },
        //             success: function (data) {
        //                 alert(data.retMsg);
        //                 vum.showData(page);
        //             }
        //         });
        //     }
        // }

        // function openImportForm() {
        //     $('#importForm').attr("action", "importAjax");
        //     $('#importModalLabel').text("导入学生");
        //     $('#importModal').modal("toggle");
        // }

        function load(data) {
            $('#username').attr("readOnly", true);
            $('#addForm').attr("action", "updateStuResAjax");
            $('#title').text("查看学生成绩");
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
            <input type="hidden" name="columns" value="grade">
            <input type="hidden" name="columns" value="calss">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="logicalopts" value="">
            <input type="hidden" name="logicalopts" value="and">
            <div class="input-group">
                <input type="text" name="values" class="form-control" placeholder="届级">
                <input type="text" name="values" class="form-control" placeholder="班级">
                <button class="btn btn-secondary" type="button" onClick="search(1,'listAjax','searchForm', vum);"><i
                        class="bi-search"></i> 搜索学生
                </button>
                <%--                <button class="btn btn-secondary" onClick="add();" type="button"><i class="bi-plus"></i> 添加学生</button>--%>
                <%--                <button class="btn btn-secondary" onClick="openImportForm()" type="button"><i class="bi-folder-plus"></i> 导入学生</button>--%>
                <%--                <button class="btn btn-secondary" onClick="location.href='export'" type="button"><i class="bi-folder-minus"></i> 导出学生</button>--%>
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
                    <h1 class="fw-bold mb-0 fs-2" id="title">添加学生</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-5 pt-0">
                    <form id="addForm" method="post" action="" class="form-horizontal">
                        <div>
                            <input type="text" class="form-control rounded-3" id="id" name="id" placeholder="年级">
                            <label for="id">学号</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="name" name="name"
                                   placeholder="姓名">
                            <label for="name">姓名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="grade" name="grade"
                                   placeholder="年级">
                            <label for="grade">年级</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="calss" name="calss" placeholder="班级">
                            <label for="calss">班级</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="chinese" name="chinese"
                                   placeholder="语文">
                            <label for="chinese">语文</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="math" name="math"
                                   placeholder="数学">
                            <label for="math">数学</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="english" name="english"
                                   placeholder="英语">
                            <label for="english">英语</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="physics" name="physics"
                                   placeholder="物理">
                            <label for="physics">物理</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="chemistry" name="chemistry"
                                   placeholder="化学">
                            <label for="chemistry">化学</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="biology" name="biology"
                                   placeholder="生物">
                            <label for="biology">生物</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="history" name="history"
                                   placeholder="历史">
                            <label for="history">历史</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="geography" name="geography"
                                   placeholder="地理">
                            <label for="geography">地理</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="politics" name="politics"
                                   placeholder="政治">
                            <label for="politics">政治</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="all_result" name="all_result"
                                   placeholder="总分">
                            <label for="all_result">总分</label>
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
                    <th>学号</th>
                    <th>名字</th>
                    <th>年级</th>
                    <th>班级</th>
                    <th>语文</th>
                    <th>数学</th>
                    <th>英语</th>
                    <th>物理</th>
                    <th>化学</th>
                    <th>生物</th>
                    <th>历史</th>
                    <th>地理</th>
                    <th>政治</th>
                    <th>总分</th>
                </tr>
                <tr v-for="data in datas">
                    <td>{{data.id}}</td>
                    <td>{{data.name}}</td>
                    <td>{{data.grade}}</td>
                    <td>{{data.calss}}</td>
                    <td>{{data.chinese}}</td>
                    <td>{{data.math}}</td>
                    <td>{{data.english}}</td>
                    <td>{{data.physics}}</td>
                    <td>{{data.chemistry}}</td>
                    <td>{{data.biology}}</td>
                    <td>{{data.history}}</td>
                    <td>{{data.geography}}</td>
                    <td>{{data.politics}}</td>
                    <td>{{data.all_result}}</td>
                    <td>
                        <button type="编辑用户信息" class="btn btn-sm btn-outline-secondary" @click="load(data)">
                            <span class="glyphicon glyphicon-edit">编辑用户信息</span>
                        </button>
                        <%--                        <button type="删除用户" class="btn btn-sm btn-outline-secondary" @click="del(data.id);">--%>
                        <%--                            <span class="glyphicon glyphicon-remove">删除用户</span>--%>
                        <%--                        </button>--%>
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