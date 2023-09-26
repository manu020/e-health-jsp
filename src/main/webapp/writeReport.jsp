<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<title>Write Report</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
}

.container {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: white;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	background-color: #007bff;
	color: white;
	padding: 10px 0;
	margin: 0;
}

form {
	margin-top: 20px;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	resize: vertical;
}

input[type="submit"] {
	display: block;
	margin-top: 10px;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Write Report</h1>
		<br>
		<c:set var="appointmentId" value="${param.appointmentId}" />
		<sql:setDataSource var="dataSource" driver="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/ehms" user="root" password="939164" />
		<sql:query dataSource="${dataSource}" var="reportQueryResult">
            SELECT * FROM Reports WHERE appointmentID = ?
            <sql:param value="${appointmentId}" />
		</sql:query>
		<c:choose>
			<c:when test="${reportQueryResult.rowCount > 0}">
				<!-- Report exists, display existing report -->
				<c:forEach var="row" items="${reportQueryResult.rows}">
					<label for="medicinePrescribed">Medicine Prescribed:</label>
					<textarea name="medicinePrescribed" rows="4" cols="50" readonly>${row.MedicinePrescribed}</textarea>
					<br>
					<label for="doctorComment">Doctor Comment:</label>
					<textarea name="doctorComment" rows="4" cols="50" readonly>${row.DoctorComment}</textarea>
					<br>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- Report doesn't exist, display the form -->
				<form method="post">
					<input type="hidden" name="appointmentId" value="${appointmentId}" />
					<label for="medicinePrescribed">Medicine Prescribed:</label>
					<textarea name="medicinePrescribed" rows="4" cols="50" required></textarea>
					<br> <label for="doctorComment">Doctor Comment:</label>
					<textarea name="doctorComment" rows="4" cols="50" required></textarea>
					<br> <input type="submit" value="Submit Report">
				</form>
			</c:otherwise>
		</c:choose>
		<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

			String medicinePrescribed = request.getParameter("medicinePrescribed");
			String doctorComment = request.getParameter("doctorComment");

			try {
				Connection conn = ConnectionProvider.getCon(); // Get your database connection

				String insertQuery = "INSERT INTO Reports (appointmentID, MedicinePrescribed, DoctorComment) VALUES (?, ?, ?)";

				try (PreparedStatement stmt = conn.prepareStatement(insertQuery);) {
			stmt.setInt(1, appointmentId);
			stmt.setString(2, medicinePrescribed);
			stmt.setString(3, doctorComment);

			int rowsAffected = stmt.executeUpdate();
			if (rowsAffected > 0) {
				out.println("Report submitted successfully.");
			} else {
				out.println("Report submission failed.");
			}
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.println(e.getMessage());
			}
		}
		%>
	</div>
</body>
</html>
