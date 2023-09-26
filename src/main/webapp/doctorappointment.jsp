<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Replace with your custom taglib URI -->

<!DOCTYPE html>
<html>
<head>
    <title>Appointment Details</title>
    <style>
       body {
            font-family: Arial, sans-serif;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
     
    </style>
</head>
<body>
    <jsp:include page="doctor.jsp"></jsp:include>
    <c:set var="userID" value="${sessionScope.userID}" />
    <!-- Replace with your database connection details -->
    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/ehms" user="root" password="939164" />
     

    <sql:query dataSource="${ds}" var="appointments">
        SELECT a.*, p.first_name, p.age, p.blood_group, p.address 
        FROM appointments a 
        INNER JOIN patients p ON a.patient_id = p.id 
        WHERE a.doctor_ID = ?
        <sql:param value="${userID}" />
    </sql:query>

    <table>
        <tr>
            <th>Appointment ID</th>
            <th>Problem</th>
            <th>Patient ID</th>
            <th>Patient Name</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Blood Group</th>
            <th>Address</th>
            <th>Action</th>
        </tr>
        <c:forEach var="appointment" items="${appointments.rows}">
          
            <tr>
                <td>${appointment.id}</td>
                <td>${appointment.problem}</td>
                <td>${appointment.patient_id}</td>
                <td>${appointment.first_name}</td>
                <td>${appointment.gender}</td>
                <td>${appointment.age}</td>
                <td>${appointment.blood_group}</td>
                <td>${appointment.address}</td>
                <td><a href="writeReport.jsp?appointmentId=${appointment.id}">Write Report</a></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
