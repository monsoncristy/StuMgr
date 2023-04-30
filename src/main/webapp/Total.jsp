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
    <link rel="stylesheet" href="y/css/bootstrap.min.css">
    <link rel="stylesheet" href="y/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="y/css/common.css">
    <link rel="stylesheet" href="y/css/modals.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script type="text/javascript" src="y/js/jquery.min.js"></script>
    <script type="text/javascript" src="y/js/jquery.form.min.js"></script>
    <script type="text/javascript" src="y/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="y/js/jquery.placeholder.min.js"></script>
    <script type="text/javascript" src="y/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="y/js/vue.min.js"></script>
    <script type="text/javascript" src="y/js/common.js"></script>
    <script type="text/javascript" src="y/js/bootstrap.bundle.min.js"></script>

    <script src="y/js/echarts.min.js"></script>
    <!-- 在head标签中添加对Echarts的引用 -->
    <script type="text/javascript">
        var vum;
        $(document).ready(function () {
            vum = new Vue({
                el: "#app",
                data: {
                    datas: [],
                    pages: [],
                },
                methods: {
                    showData: function (id) {
                        $.ajax({
                            url:"getTotal",
                            type: "GET",
                            data:{
                                id : id
                            },
                            success(data){
                                if(data.status != "ok")alert(data.status);
                                else{
                                    vum.datas = data.result;
                                    $("#title").text(data.name+"同学")
                                }
                            }
                        })
                    }
                }
            });
            vum.showData(1111);
        })

        function check(){
            var id = $("#id").val();
            alert(id);
            vum.showData(id);
        }



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
                        { name: '德', max: 100 },
                        { name: '智', max: 100 },
                        { name: '体', max: 100 },
                        { name: '美', max: 100 },
                        { name: '劳', max: 100 },
                        //{ name: '总', max: 100 }
                    ]
                },
                series: [
                    {
                        name: 'kook',
                        type: 'radar',
                        data: [
                            {
                                value: [data["de"],
                                    data["zhi"],
                                    data["ti"],
                                    data["mei"],
                                    data["lao"]],//,data["total"]
                                name: 'test'
                            },
                        ]
                    }
                ]
            };

            option && myChart.setOption(option);
        }
    </script>
</head>
<body>

<div class="container-fluid" align="center">
    <h2 id="title"></h2>
    <input class="input-group-lg" placeholder="请输入你的学号。。。" type="text" id="id">
    <button class="btn btn-secondary" type="button" onclick="check()">查询成绩</button>

    <ul class="navbar-nav me-auto">
        <li class="nav-item">
            <a class="nav-link" href="./adm/login.jsp">
                <p style="text-align: center">返回登陆</p>
            </a>
        </li>
    </ul>
    <div class="table-responsive" id="app">
        <table class="table table-striped table-sm">
            <thead>
            <tr>
                <th>德</th>
                <th>智</th>
                <th>体</th>
                <th>美</th>
                <th>劳</th>
                <th>综合</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="data in datas">
                <td>{{data.de}}</td>
                <td>{{data.zhi}}</td>
                <td>{{data.ti}}</td>
                <td>{{data.mei}}</td>
                <td>{{data.lao}}</td>
                <td>{{data.total}}</td>
                <td><button type="查看" class="btn btn-sm btn-outline-secondary"  @click="initChart(data)">
                    <span class="glyphicon glyphicon-edit">查看</span>
                </button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

<div id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        // 初始化echarts实例

    </script>

</div>
</body>
</html>