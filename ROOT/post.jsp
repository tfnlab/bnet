<%@ page import="java.util.*,java.io.*, java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%

  // Generate a UUID
  String uuid = UUID.randomUUID().toString();

  // Set the file name using the UUID
  String fileName = uuid + ".txt";

  // Iterate through the request parameters and add them to the POST data
  String postData = "Data Request";

  // Get referring URL
  String referringUrl = request.getHeader("Referer");

  // Get the source IP address
  String sourceIpAddress = request.getRemoteAddr();

  // Get the X-Real-IP address
  String xrealip = request.getHeader("X-Real-IP");

  // Read the request body
  BufferedReader reader = request.getReader();
  StringBuilder requestBody = new StringBuilder();
  String line;
  while ((line = reader.readLine()) != null) {
    requestBody.append(line);
  }

  reader.close();

  // Remove the last character '}' from the requestBody
  requestBody.setLength(requestBody.length() - 1);

  // Append referringUrl, sourceIpAddress, and xrealip as JSON properties
  requestBody.append(", \"referringUrl\": \"" + referringUrl + "\", \"sourceIpAddress\": \"" + sourceIpAddress + "\", \"xrealip\": \"" + xrealip + "\"");

  // Add '}' back to complete the JSON object
  requestBody.append("}");

  // Write the Post Data content to a file
  try (FileWriter fileWriter = new FileWriter("/var/lib/tomcat9/webapps/pdf/bnet/" + fileName)) {
    fileWriter.write(requestBody.toString());
    %>Data saved successfully.<%
  } catch (IOException e) {
    // Handle file write error
    StringWriter stringWriter = new StringWriter();
    PrintWriter printWriter = new PrintWriter(stringWriter);
    e.printStackTrace(printWriter);
    String stackTrace = stringWriter.toString();
    %><%= stackTrace %><%
  }
%>
