<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File List</title>
</head>
<body>
    <h1>File List</h1>
    <ul>
        <%
            String directoryPath = "/var/lib/tomcat9/webapps/pdf/bnet/";
            java.io.File directory = new java.io.File(directoryPath);
            java.io.File[] files = directory.listFiles();
            if (files != null) {
                for (java.io.File file : files) {
                    if (file.isFile()) {
                        out.println("<li><a href=\"rf.jsp?filename=" + file.getName() + "\"" + file.getName() + "</a></li>");
                    }
                }
            }
        %>
    </ul>
</body>
</html>
