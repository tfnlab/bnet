<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
// Get the filename from the request parameter
String filename = request.getParameter("filename");

// Define the path to the file
String filePath = "/var/lib/tomcat9/webapps/pdf/bnet/" + filename;

// Create a File object for the requested file
File file = new File(filePath);

// Check if the file exists
if (file.exists()) {
    // Set the response headers
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
    response.setHeader("Content-Length", String.valueOf(file.length()));

    // Create an input stream to read the file
    FileInputStream fis = new FileInputStream(file);

    // Create an output stream to write the file content to the response
    OutputStream os = response.getOutputStream();
    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = fis.read(buffer)) != -1) {
        os.write(buffer, 0, bytesRead);
    }
    os.flush();
    os.close();
    fis.close();
} else {
    // File not found, handle the error as per your requirement
    response.setContentType("text/html");
    response.getWriter().println("<h2>File not found.</h2>");
}
%>
