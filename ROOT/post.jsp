<%@ page import="java.util.*,java.io.*, java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="org.json.JSONObject" %>
<%
  // Generate a UUID
  String uuid = UUID.randomUUID().toString();

  // Set the file name using the UUID
  String fileName = uuid + ".txt";

  // Access the HttpServletRequest object
  HttpServletRequest httpRequest = (HttpServletRequest) request;

  // Get referring URL
  String referringUrl = httpRequest.getHeader("Referer");

  // Get the source IP address
  String sourceIpAddress = httpRequest.getRemoteAddr();

  // Iterate through the request parameters and add them to the POST data
  String postData = "Data Request";

  // Read the request body
  String requestBody = IOUtils.toString(httpRequest.getReader());

  // Parse the request body as JSON
  JSONObject requestBodyJson = new JSONObject(requestBody);
  postData += requestBodyJson.toString();

  // Append referring URL and source IP address to the POST data
  postData += "\nReferring URL: " + referringUrl;
  postData += "\nSource IP Address: " + sourceIpAddress;

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
