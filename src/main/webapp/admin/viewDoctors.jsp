<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Records</title>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

th {
	background-color: #4CAF50;
	color: white;
}
</style>
</head>
<body>
  <%
    Object userId = session.getAttribute("userID"); // Change to your attribute name
    String userType = (String) session.getAttribute("userType"); // Change to your attribute name
    if(userId == null || userType == null) {
    	response.sendRedirect("../logout.jsp");
    }
%>
	<jsp:include page="header.jsp" />
	<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost/ehms" user="root" password="939164" />
	<sql:query dataSource="${db}" var="rs">  
SELECT first_name, last_name, gender, contact_number, age, entry_fee, qualification, doctor_type FROM doctors;
</sql:query>
	<h1>Doctor Records</h1>
	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Gender</th>
			<th>Contact Number</th>
			<th>Age</th>
			<th>Entry Charge</th>
			<th>Qualification</th>
			<th>Doctor Type</th>
		</tr>
		
		<c:forEach var="table" items="${rs.rows}">
			<tr>
				<td><c:out value="${table.first_name}" /></td>
				<td><c:out value="${table.last_name}" /></td>
				<td><c:out value="${table.gender}" /></td>
				<td><c:out value="${table.contact_number}" /></td>
				<td><c:out value="${table.age}" /></td>
				<td><c:out value="${table.entry_fee}" /></td>
				<td><c:out value="${table.qualification}" /></td>
				<td><c:out value="${table.doctor_type}" /></td>
			</tr>
			
		</c:forEach>
</body>
</html>