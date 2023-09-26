<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>
    <style>
        /* styles.css */
        .reports-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #ccc;
            margin-top: 20px;
        }

        .reports-table th, .reports-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .reports-table th {
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
    <jsp:include page="header.jsp"></jsp:include>

    <h1>Admin Reports</h1>
    <table class="reports-table">
        <tr>
            <th>Report ID</th>
            <th>Appointment ID</th>
            <th>Patient Name</th>
            <th>Doctor Name</th>
            <th>Medicine Prescribed</th>
            <th>Doctor Comment</th>
        </tr>

        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;
            try {
                conn = ConnectionProvider.getCon();
                String query = "SELECT r.reportid, a.id AS appointmentID, p.first_name AS patientFirstName, p.last_name AS patientLastName," +
                               "d.first_name AS doctorFirstName, d.last_name AS doctorLastName, r.MedicinePrescribed, r.DoctorComment " +
                               "FROM reports AS r JOIN appointments AS a ON r.appointmentid = a.id " +
                               "JOIN doctors AS d ON a.doctor_id = d.id JOIN patients AS p ON a.patient_id = p.id";
                pstmt = conn.prepareStatement(query);
                resultSet = pstmt.executeQuery();
                
                while (resultSet.next()) {
        %>
                <tr>
                    <td><%= resultSet.getInt(1) %></td>
                    <td><%= resultSet.getInt("appointmentID") %></td>
                    <td><%= resultSet.getString("patientFirstName") %> <%= resultSet.getString("patientLastName") %></td>
                    <td><%= resultSet.getString("doctorFirstName") %> <%= resultSet.getString("doctorLastName") %></td>
                    <td><%= resultSet.getString("MedicinePrescribed") %></td>
                    <td><%= resultSet.getString("DoctorComment") %></td>
                </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
