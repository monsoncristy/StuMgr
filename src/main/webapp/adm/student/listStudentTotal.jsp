<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>
        综合评测
    </title>
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

    <script src="../../y/js/echarts.min.js"></script>
    <!-- 在head标签中添加对Echarts的引用 -->
    <script type="text/javascript">
        var vum;
        var page = 1;

        $(document).ready(function () {
            vum = new Vue({
                el: "#app",
                data: {
                    datas: [],
                    pages: [],
                    dataList: []
                },
                methods: {
                    showData: function (p) {
                        page = p;
                        search(1, 'listTotalAjax', 'searchForm', vum);
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
            $('#addForm').attr("action", "addTotalAjax");
            $('#title').text("添加学生");
            $('#addModal').modal("toggle");
        }

        //
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
        //
        // function openImportForm() {
        //     $('#importForm').attr("action", "importAjax");
        //     $('#importModalLabel').text("导入学生");
        //     $('#importModal').modal("toggle");
        // }

        function load(data) {
            alert(data)
            $('#username').attr("readOnly", true);
            $('#addForm').attr("action", "updateTotalAjax");
            $('#title').text("修改学生信息");
            $('#addModal').modal("toggle");
            fillForm(data);
        }

        function ook(data){
            myChart.setOption({
                title:{
                    title:"test"
                },
                series: {
                    data: data
                }
            })
            console.log(data);
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
            <input type="hidden" name="columns" value="id">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="operators" value="like">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="orders" value="none">
            <input type="hidden" name="logicalopts" value="">
            <input type="hidden" name="logicalopts" value="and">
            <input type="hidden" name="logicalopts" value="and">
            <div class="input-group">
                <input type="text" name="values" class="form-control" placeholder="届级">
                <input type="text" name="values" class="form-control" placeholder="班级">
                <input type="text" name="values" class="form-control" placeholder="学号">
                <button class="btn btn-secondary" type="button" onClick="search(1,'listAjax','searchForm', vum);"><i
                        class="bi-search"></i> 搜索学生
                </button>

            </div>
        </form>
    </div>


    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content rounded-4 shadow">


                <div class="modal-body p-5 pt-0">
                    <form id="addForm" method="post" action="" class="form-horizontal">

                        <div class="form-floating mb-3">
                            <input type="hidden">
                            <label></label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="id" name="id" placeholder="学号">
                            <label for="id">学号</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="de" name="de" placeholder="德">
                            <label for="de">德</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="zhi" name="zhi" placeholder="智">
                            <label for="zhi">智</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="ti" name="ti" placeholder="体">
                            <label for="ti">体</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="mei" name="mei" placeholder="美">
                            <label for="mei">美</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="lao" name="lao" placeholder="劳">
                            <label for="lao">劳</label>
                        </div>


                        <button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="submit">确认添加</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div id="app" class="bd-example-snippet bd-code-snippet">
        <div class="bd-example">
            <table class="table table-striped">
                <tr>
                    <th>学号</th>
                    <th>年级</th>
                    <th>班级</th>
                    <th>姓名</th>
                    <th>德</th>
                    <th>智</th>
                    <th>体</th>
                    <th>美</th>
                    <th>劳</th>
                    <th>综合评分</th>
                    <th>操作</th>
                </tr>
                <tr v-for="data in datas">
                    <td>{{data.id}}</td>
                    <td>{{data.grade}}</td>
                    <td>{{data.calss}}</td>
                    <td>{{data.name}}</td>
                    <td>{{data.de}}</td>
                    <td>{{data.zhi}}</td>
                    <td>{{data.ti}}</td>
                    <td>{{data.mei}}</td>
                    <td>{{data.lao}}</td>
                    <td>{{data.total}}</td>
                    <td>
                        <button type="编辑用户信息" class="btn btn-sm btn-outline-secondary" @click="load(data)">
                            <span class="glyphicon glyphicon-edit">编辑用户信息</span>
                        </button>
                        <button type="添加综合评分" class="btn btn-sm btn-outline-secondary" @click="add()">
                            <span class="glyphicon glyphicon-edit">添加综合评分</span>
                        </button>
                        <button type="查看" class="btn btn-sm btn-outline-secondary" @click="initChart(data)">
                            <span class="glyphicon glyphicon-edit">查看</span>
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
<div>
    <div id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        // 初始化echarts实例
        function initChart(data){
            var chartDom = document.getElementById('main');
            var myChart = echarts.init(chartDom);
            var option;
            option = {
                title: {
                    text: 'Basic Radar Chart'
                },
                legend: {
                    data: 'kook'
                },
                radar: {
                    // shape: 'circle',
                    indicator: [
                        { name: '德', max: 500 },
                        { name: '智', max: 500 },
                        { name: '体', max: 500 },
                        { name: '美', max: 500 },
                        { name: '劳', max: 500 },
                        { name: '总', max: 500 }
                    ]
                },
                series: [
                    {
                        name: 'kook',
                        type: 'radar',
                        data: [
                            {
                                value: [data["de"],data["zhi"],data["ti"],data["mei"],data["lao"],data["total"]],
                                name: 'test'
                            },
                        ]
                    }
                ]
            };

            option && myChart.setOption(option);
        }
    </script>

</div>
</body>
</html>