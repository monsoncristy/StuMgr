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





        // var chartDom = document.getElementById('main');
        // var myChart = echarts.init(chartDom);
        // var option;
        //
        // option = {
        //     title: {
        //         text: '综合评价图'
        //     },
        //     legend: {
        //         data: ['甲科室']
        //     },
        //     radar: {
        //         // shape: 'circle',
        //         indicator: [
        //             { name: '语文', max: 150 },
        //             { name: '数学', max: 150 },
        //             { name: '英语', max: 150 },
        //             { name: '物理', max: 100 },
        //             { name: '化学', max: 100 },
        //             { name: '生物', max: 100 }
        //         ]
        //     },
        //     series: [
        //         {
        //             name: '甲科室',
        //             type: 'radar',
        //             data: [
        //                 {
        //                     value: [1200, 1545, 20000, 35000, 50000, 18000],
        //                     name: '综分'
        //                 },
        //
        //             ]
        //         }
        //     ]
        // };
        //
        // option && myChart.setOption(option);
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


<div id="main" style="width: 600px;height:400px;"></div>
<script type="text/javascript">
    // 初始化echarts实例 echarts.init()
    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);
    var option;

    option = {
        title: {
            text: '综合评价图'
        },
        legend: {
            data: ['甲科室']
        },
        radar: {
            // shape: 'circle',
            indicator: [
                { name: '语文', max: 150 },
                { name: '数学', max: 150 },
                { name: '英语', max: 150 },
                { name: '物理', max: 100 },
                { name: '化学', max: 100 },
                { name: '生物', max: 100 }
            ]
        },
        series: [
            {
                name: '甲科室',
                type: 'radar',
                data: [
                    {
                        value: [dat, data.chinese, 20000, 35000, 50000, 18000],
                        name: '综分'
                    },

                ]
            }
        ]
    };

    option && myChart.setOption(option);
</script>
</div>
</body>
</html>