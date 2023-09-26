<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="github.ehealth.ConnectionProvider"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Records</title>
<style>

body {
        font-family: Arial, sans-serif;
    }
    
    h1 {
        text-align: center;
        margin-top: 20px;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    
    th {
        background-color: #f2f2f2;
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
<%
    Connection con = ConnectionProvider.getCon();
    String query = "SELECT a.id, a.Problem, p.first_name AS PatientFirstName, p.last_name AS PatientLastName, d.first_name AS DoctorFirstName, d.last_name AS DoctorLastName,d.Qualification as Qualification, d.doctor_type as specialist,  a.doctor_fees, a.payment_status, a.appointment_status " +
                   "FROM appointments a " +
                   "JOIN Patients p ON a.patient_Id = p.id " +
                   "JOIN Doctors d ON a.doctor_ID = d.id order by id;";
    PreparedStatement pst = con.prepareStatement(query);
    ResultSet resultSet = pst.executeQuery();
%>

<h1>Appointment Records</h1>

<table>
    <tr>
        <th>Appointment ID</th>
        <th>Problem</th>
        <th>Patient Name</th>
        <th>Doctor Name</th>
        <th>Doctor Type</th>
        <th>Qualification</th>
        <th>Doctor Fees</th>
     
    </tr>
    <% while (resultSet.next()) { %>
    <tr>
        <td><%= resultSet.getInt("id") %></td>
        <td><%= resultSet.getString("Problem") %></td>
        <td><%= resultSet.getString("PatientFirstName") %> <%= resultSet.getString("PatientLastName") %></td>
        <td><%= resultSet.getString("DoctorFirstName") %> <%= resultSet.getString("DoctorLastName") %></td>
        <td><%= resultSet.getString("specialist") %></td>
        <td><%= resultSet.getString("Qualification") %></td>
        <td><%= resultSet.getInt("doctor_fees") %></td>
     
    </tr>
    <% } %>
</table>

<%
    resultSet.close();
    pst.close();
    con.close();
%>

</body>
</html>
