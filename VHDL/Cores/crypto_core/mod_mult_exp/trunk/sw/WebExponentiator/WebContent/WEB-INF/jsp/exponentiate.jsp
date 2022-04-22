<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><fmt:message key="prepare_title"/></title>
</head>
<body>
<h1><fmt:message key="exponentiate_title"/></h1>

<table width="95%" bgcolor="f8f8ff" border="0" cellspacing="0" cellpadding="5">
    <c:forEach var="el" items="${exponentiation}">
	    <tr>
	      <td align="left" width="100%">${el}</td>
	    </tr>
    </c:forEach>
</table>

<a href="<c:url value="start.htm"/>"><fmt:message key="home"/></a>
</body>
</html>