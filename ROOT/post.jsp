<%@ page import="java.util.*,java.io.*, java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%

  // Generate a UUID
  String uuid = UUID.randomUUID().toString();

  // Set the file name using the UUID
  String fileName = uuid + ".txt";

  // Iterate through the request parameters and add them to the POST data
  String postData = "Data Request";

  // Read the request body
  BufferedReader reader = request.getReader();
  StringBuilder requestBody = new StringBuilder();
  String line;
  while ((line = reader.readLine()) != null) {
    requestBody.append(line);
  }
  reader.close();

  // Parse the request body as JSON
  postData += requestBody.toString();

  // Write the Post Data content to a file
  try (FileWriter fileWriter = new FileWriter("/var/lib/tomcat9/webapps/pdf/bnet/" + fileName)) {
    fileWriter.write(postData);

  } catch (IOException e) {
    // Handle file write error
    StringWriter stringWriter = new StringWriter();
    PrintWriter printWriter = new PrintWriter(stringWriter);
    e.printStackTrace(printWriter);
    String stackTrace = stringWriter.toString();
    %><%= stackTrace %><%
  }

%>Done
