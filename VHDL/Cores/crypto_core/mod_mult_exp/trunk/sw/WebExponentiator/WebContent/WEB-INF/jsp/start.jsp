<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title><fmt:message key="title"/></title>
  </head>
  <body>
    <h1><fmt:message key="heading"/></h1>
    <p><fmt:message key="info"/> <c:out value="${model.now}"/></p>
    <a href="exponentiation.htm"><fmt:message key="exponentiation"/></a>
  </body>
</html>