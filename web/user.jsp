<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>AmritaNews</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon">

</head>

<body>
<div class="col-md-12" id="center">
    <div class="row masonry-archive" data-columns>
<%@include file="/WEB-INF/jspf/navbar.jspf" %>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%
   String email = (String) session.getAttribute("user");
   
  if (email != null && !email.isEmpty()) {
        try {
                Class.forName("org.gjt.mm.mysql.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/news", "root", "amma");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("select * from article where category = (select category from user where email='"+email+"')");
                while (rs.next()) { 
                    String title = rs.getString("title");
                    String subtitle = rs.getString("subtitle");
                    String content = rs.getString("content");
                    String link = rs.getString("link");
                    %>
            <div class="item">
            <div class="thumbnail">
                <p class="text-right article-img">
                   
                    <img src="" alt="" class="img-responsive">
                </p>
                <div class="caption">
                    <h3><a href="<%= link %>"><%= title %></a></h3>
                    <p><strong><%= subtitle %></strong></p>
            <hr>
            <p><%= content %></p>
                    <a href="<%= link %>" class="btn btn-success">Read more <i
                            class="glyphicon glyphicon-chevron-right"></i></a>
                </div>
            </div>
        </div>
                    <%
                    
                }
                stmt.close();
        }
                catch(SQLException e) {
                out.println("SQLException caught: " +e.getMessage());
        }
  }          

%>
    </div>
</div>
<%@include file="/WEB-INF/jspf/footer.jspf" %>


<script src="${pageContext.request.contextPath}/js/comeback.js" type="text/javascript"></script>
</body>

</html>
