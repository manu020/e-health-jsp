<%@page import="java.sql.Connection"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Report</title>
<style>
    <style>
        /* Global styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 10px 0;
        }

        h1 {
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Add any additional styles specific to viewReport.jsp */
    </style>
</style>
</head>
<body>
<jsp:include page="patient.jsp" />
<div class="container">
    <div class="header">
        <h1>View Report</h1>
    </div>

    <c:set var="appointmentId" value="${param.appointmentId}" ></c:set>
    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/ehms" user="root" password="939164" />
    <sql:query dataSource="${ds}" var="reportData">
        SELECT * FROM reports WHERE appointmentid = ?
        <sql:param value="${appointmentId}" />
    </sql:query>

    <table>
        <tr>
            <th>Report ID</th>
            <th>Appointment ID</th>
            <th>MedicinePrescribed</th>
            <th>DoctorComment</th>
        </tr>

        <c:forEach items="${reportData.rows}" var="report">
            <tr>
                <td>${report.reportid}</td>
                <td>${report.appointmentid}</td>
                <td>${report.MedicinePrescribed}</td>
                <td>${report.DoctorComment}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
