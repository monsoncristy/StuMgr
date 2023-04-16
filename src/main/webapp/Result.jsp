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
    </script>
</head>
<body>
<div class="container-fluid" align="center">
    <h2 id="title"></h2>
    <input class="input-group-lg" placeholder="请输入你的学号。。。" type="text" id="id">
    <button class="btn btn-secondary" type="button" onclick="check()"></button>
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
                <td>第一次模拟考试</td>
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
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>