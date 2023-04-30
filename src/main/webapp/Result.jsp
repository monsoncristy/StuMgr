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
                            url:"getResult",
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



        // function initChart(data){
        //     var chartDom = document.getElementById('main');
        //     var myChart = echarts.init(chartDom);
        //     var option;
        //
        //     option = {
        //         title: {
        //             text: 'Stacked Line'
        //         },
        //         tooltip: {
        //             trigger: 'axis'
        //         },
        //         legend: {
        //             data: ['语文', '数学', '英语', '物理', '化学', '生物', '历史', '地理', '政治']
        //         },
        //         grid: {
        //             left: '3%',
        //             right: '4%',
        //             bottom: '3%',
        //             containLabel: true
        //         },
        //         toolbox: {
        //             feature: {
        //                 saveAsImage: {}
        //             }
        //         },
        //         xAxis: {
        //             type: 'category',
        //             boundaryGap: false,
        //             data: [
        //                 {
        //                     value:[data["testName"]],
        //                     name:'testName'
        //                 }
        //             ]
        //         },
        //         yAxis: {
        //             type: 'value'
        //         },
        //         series: [
        //             {
        //                 name: '语文',
        //                 type: 'line',
        //                 stack: 'Total',
        //                 data: [
        //                     {
        //                         value: [data["chinese"]],
        //                         name: 'test'
        //                     },
        //                 ]
        //             },
        //             {
        //                 name: 'Union Ads',
        //                 type: 'line',
        //                 stack: 'Total',
        //                 data: [220, 182, 191, 234, 290, 330, 310]
        //             },
        //             {
        //                 name: 'Video Ads',
        //                 type: 'line',
        //                 stack: 'Total',
        //                 data: [150, 232, 201, 154, 190, 330, 410]
        //             },
        //             {
        //                 name: 'Direct',
        //                 type: 'line',
        //                 stack: 'Total',
        //                 data: [320, 332, 301, 334, 390, 330, 320]
        //             },
        //             {
        //                 name: 'Search Engine',
        //                 type: 'line',
        //                 stack: 'Total',
        //                 data: [820, 932, 901, 934, 1290, 1330, 1320]
        //             }
        //         ]
        //     };
        //
        //     option && myChart.setOption(option);
        // }


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
                <th>考试</th>
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
            </thead>
            <tbody>
            <tr v-for="data in datas">
                <td>{{data.testName}}</td>
                <td>{{data.chinese}}</td>
                <td>{{data.math}}</td>
                <td>{{data.english}}</td>
                <td>{{data.physics}}</td>
                <td>{{data.chemistry}}</td>
                <td>{{data.biology}}</td>
                <td>{{data.history}}</td>
                <td>{{data.geography}}</td>
                <td>{{data.politics}}</td>
                <td>{{data.allResult}}</td>
                <td><button type="查看" class="btn btn-sm btn-outline-secondary"  @click="initChart(data)">
                    <span class="glyphicon glyphicon-edit">查看</span>
                </button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <div  id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">

        function initChart(data){
            var chartDom = document.getElementById('main');
            var myChart = echarts.init(chartDom);
            var option;

            option = {
                title: {
                    text: 'Stacked Line'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['语文', '数学', '英语', '物理', '化学', '生物', '历史', '地理', '政治']
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: [
                        {
                            value:[data["testName"]],
                            name:'testName'
                        }
                    ]
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: '语文',
                        type: 'line',
                        stack: 'Total',
                        data: [
                            {
                                value: [data["chinese"]],
                                name: 'test'
                            },
                        ]
                    },
                    {
                        name: '数学',
                        type: 'line',
                        stack: 'Total',
                        data: [data["math"]]
                    },
                    {
                        name: '英语',
                        type: 'line',
                        stack: 'Total',
                        data: [data["english"]]
                    },
                    {
                        name: '物理',
                        type: 'line',
                        stack: 'Total',
                        data: [data["physics"]]
                    },
                    {
                        name: '化学',
                        type: 'line',
                        stack: 'Total',
                        data: [data['chemistry']]
                    },
                    {
                        name: '生物',
                        type: 'line',
                        stack: 'Total',
                        data: [data['biology']]
                    },
                    {
                        name: '历史',
                        type: 'line',
                        stack: 'Total',
                        data: [data['history']]
                    },
                    {
                        name: '地理',
                        type: 'line',
                        stack: 'Total',
                        data: [data['geography']]
                    },
                    {
                        name: '政治',
                        type: 'line',
                        stack: 'Total',
                        data: [data['politics']]
                    }
                ]
            };

            option && myChart.setOption(option);
        }
    </script>



</div>
</body>
</html>