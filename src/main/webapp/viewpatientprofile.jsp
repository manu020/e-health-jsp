<%@page import="java.sql.Connection"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Profile</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	color: #333;
}

.doctor-info {
	margin-top: 20px;
}

.doctor-info p {
	margin: 10px 0;
}

a {
	text-decoration: none;
	color: #007BFF;
}

a:hover {
	text-decoration: underline;
}

.card {
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	width: 400px;
}

.patient-info {
	margin-bottom: 20px;
}

p {
	margin: 10px 0;
}
</style>
</head>
<body>
	<jsp:include page="patient.jsp" />
	<c:choose>
		<c:when test="${empty userID or empty userType}">
			<p>
				Session data not available. Please <a href="login.jsp">log in</a>
				again.
			</p>
		</c:when>
		<c:otherwise>
			<div class="card container">
				<c:set var="id" value="${userID}" />
				<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
					url="jdbc:mysql://localhost:3306/ehms" user="root"
					password="939164" />
				<sql:query dataSource="${ds}" var="patientData">
                SELECT * FROM patients WHERE id = ?
                <sql:param value="${id}" />
				</sql:query>
				<c:choose>
					<c:when test="${fn:length(patientData.rows) > 0}">
						<div class="patient-info">
							<c:forEach items="${patientData.rows}" var="row">
								<p>Patient ID: ${row.id}</p>
								<p>First Name: ${row.first_name}</p>
								<p>Last Name: ${row.last_name}</p>
								<p>Gender: ${row.gender}</p>
								<p>Contact Number: ${row.contact_number}</p>
								<p>Age: ${row.age}</p>
								<p>Email: ${row.email}</p>
								<p>Blood Group: ${row.blood_group}</p>
								<p>Address: ${row.address}</p>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<p>No patient found with the provided ID.</p>
					</c:otherwise>
				</c:choose>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>