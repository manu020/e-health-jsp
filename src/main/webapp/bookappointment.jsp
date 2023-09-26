<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="UTF-8">
<title>Appointment Booking</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

#container2 {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h2 {
	margin-top: 0;
	color: #333333;
}

label {
	font-weight: bold;
}

select, textarea, input[type="text"] {
	width: 100%;
	padding: 10px;
	margin-top: 5px;
	border: 1px solid #ccc;
	border-radius: 3px;
	font-size: 16px;
	box-sizing: border-box;
}

select {
	height: 40px;
}

textarea {
	resize: vertical;
}

input[type="submit"] {
	background-color: #3498db;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	margin-top: 10px;
}

input[type="submit"]:hover {
	background-color: #2980b9;
}
</style>
</head>
</head>
<body>
	<%
	if (request.getMethod().equalsIgnoreCase("POST")) {
		// HttpSession session = request.getSession();
		String doctorType = request.getParameter("doctorType");
		String problem = request.getParameter("problem");
		String doctorId = request.getParameter("doctorName");
		String fee = request.getParameter("entryFee");
		int pid = (Integer) session.getAttribute("userID");
		String query = "insert into appointments(problem,doctor_ID,patient_ID,doctor_fees)values(?,?,?,?);";
		try (Connection con = ConnectionProvider.getCon();

		PreparedStatement pst = con.prepareStatement(query);) {

			pst.setString(1, problem);
			pst.setString(2, doctorId);
			pst.setInt(3, pid);
			pst.setString(4, fee);

			pst.executeUpdate();

			response.sendRedirect("patient.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>
	<jsp:include page="patient.jsp"></jsp:include>
	<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost/ehms" user="root" password="939164" />
	<sql:query dataSource="${db}" var="doctorTypesQuery">
        SELECT distinct doctor_type FROM doctors;
    </sql:query>
	<div id="container2">
		<h2>Appointment Booking</h2>
		<form method="post">
			<label for="problemDescription">Problem Description:</label>
			<textarea name="problem" id="problem" rows="4" cols="50"></textarea>
			<br> <label for="doctorType">Doctor Type:</label>
			<select name="doctorType" id="doctorType">
				<option>Select doctor type</option>
				<c:forEach var="row" items="${doctorTypesQuery.rows}">
					<option value="${row.doctor_type}">${row.doctor_type}</option>
				</c:forEach>
			</select>
			<br> <label for="doctorName">Doctor Name:</label>
			<select name="doctorName" id="doctorName">
				<!-- Doctor names will be populated dynamically using JavaScript -->
			</select>
			<br> <label for="entryFee">Entry Fee:</label> <input type="text"
				name="entryFee" id="entryFee" readonly> <br> <input
				type="submit" value="Book Appointment">
		</form>
	</div>
	<script>
        // JavaScript to populate the doctor names based on selected doctor type
        const doctorTypeSelect = document.getElementById('doctorType');
        const doctorNameSelect = document.getElementById('doctorName');
        const entryFeeInput = document.getElementById('entryFee');

        doctorNameSelect.addEventListener('change', function () {
            const selectedDoctorName = doctorNameSelect.value;

            // Clear previous entry fee value
            entryFeeInput.value = '';

            console.log(selectedDoctorName);

            // Fetch entry fee for the selected doctor name
            fetch("getEntryFee.jsp?doctorid="+encodeURIComponent(selectedDoctorName))
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    // Assuming the server returns the entry fee as a property named "entry_fee"
                    if (data && data.entry_fee !== undefined) {
                        entryFeeInput.value = data.entry_fee;
                    }
                })
                .catch(error => console.error('Error fetching entry fee:', error));
        });
        
        doctorTypeSelect.addEventListener('change', function () {
            const selectedDoctorType = doctorTypeSelect.value;
            // Clear previous options
            doctorNameSelect.innerHTML = '<option>Select</option>';
            entryFeeInput.value = '';
            
            console.log(selectedDoctorType);

            // Fetch doctor names and populate the options
            fetch("getDoctorNames.jsp?doctorType="+encodeURIComponent(selectedDoctorType))
                .then(response => {
                console.log(response);
                return response.json()}
                )
                .then(data => {
                	console.log(data);
                    data.forEach(doctor => {
                    	console.log(doctor);
                        const option = document.createElement('option');
                        option.value = doctor.doctor_id;
                        option.text = doctor.doctor_name;
                        doctorNameSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching doctor names:', error));
        });
    </script>
</body>
</html>
