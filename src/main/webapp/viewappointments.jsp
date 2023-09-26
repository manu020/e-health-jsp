<%@page import="java.sql.Connection"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment and Doctor Details</title>
<style>
/* Your existing styles here */
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #e0e0e0;
}

th {
	background-color: #f4f4f4;
}

.btn-view-report {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="patient.jsp" />
	<div class="container">
		<div class="header">
			<h3>Appointment and Doctor Details</h3>
		</div>
		<table>
			<tr>
				<th>Appointment ID</th>
				<th>Problem</th>
				<th>Doctor ID</th>
				<th>Doctor Fees</th>
				<th>Doctor Type</th>
				<th>Doctor Contact Number</th>
				<th>Qualification</th>
				<th>Action</th>
			</tr>
			<c:set var="userId" value="${userID}" />
			<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
				url="jdbc:mysql://localhost:3306/ehms" user="root" password="939164" />
			<sql:query dataSource="${ds}" var="appointmentData">
            SELECT a.id, a.problem, a.doctor_id, a.doctor_fees, d.doctor_type,d.contact_number, d.qualification
            FROM appointments a
            JOIN doctors d ON a.doctor_id = d.id
            WHERE a.patient_id = ?
            <sql:param value="${userId}" />
			</sql:query>
			<c:forEach items="${appointmentData.rows}" var="appointment">
				<tr>
					<td>${appointment.id}</td>
					<td>${appointment.problem}</td>
					<td>${appointment.doctor_id}</td>
					<td>${appointment.doctor_fees}</td>
					<td>${appointment.doctor_type}</td>
					<td>${appointment.contact_number}</td>
					<td>${appointment.qualification}</td>
					<td><a href="viewReport.jsp?appointmentId=${appointment.id}"
						class="btn-view-report">View Report</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
