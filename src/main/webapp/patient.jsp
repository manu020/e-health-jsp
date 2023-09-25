<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome To Patient Portal</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    .header {
        background-color: #2c3e50;
        color: white;
        text-align: center;
        padding: 20px;
        border-bottom: 2px solid #34495e;
    }

    .navbar {
        text-align: center;
        background-color: #34495e;
        overflow: hidden;
        padding: 10px 0;
    }

    .navbar a {
        display: inline-block;
        color: white;
        text-align: center;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        margin: 0 10px;
        transition: background-color 0.3s, color 0.3s;
        border: 2px solid white;
    }

    .navbar a.active, .navbar a:active {
        background-color: #1a252f;
        color: #fff;
    }

    .content-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }

    iframe {
        border: none;
        width: 100%;
        min-height: 500px;
    }
</style>
</head>
<body>
    <div class="header">
        <h2>Welcome to the Patient Portal</h2>
    </div>
    <div class="navbar">
        <a href="viewpatientprofile.jsp">View Profile</a>
        <a href="bookappointment.jsp" >Book Appointments</a>
        <a href="viewappointments.jsp" >View Appointments</a>
        <a href="patientfeedback.jsp">Give Feedback</a>
        <a href="logout">Log Out</a>
    </div>
</body>
</html>
