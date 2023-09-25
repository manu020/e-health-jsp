<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        header {
            background-color: #880015;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin: 0; /* Remove top margin */
            width: 100%;
            z-index: 1000;
        }

        h1 {
            margin: 0;
        }

       .nav-list {
            list-style-type: none;
    padding: 0;
    display: flex;
    justify-content: center;
    background-color: #f0f0f0;
    margin: 0;
    flex-wrap: wrap;
    align-content: center;
    flex-direction: row;
        }

        .nav-list a {
            margin: 0;
        }

        .nav-list a {
            text-decoration: none;
            color: #007BFF;
            padding: 10px 15px; /* Adjust padding as needed */
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            margin: 5px;
        }

        .nav-list a:hover {
            background-color: #007BFF;
            color: #fff;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-msg {
            color: #FF0000;
            font-weight: bold;
        }

        .nav-list {
            margin-top: 20px; /* Add margin to create gap between buttons and record messages */
        }
    </style>
</head>
<body>

    <header>
        <h1>Welcome to Admin Portal</h1>
    </header>
    <div class="nav-list">
    <a href="viewDoctors.jsp">View Doctors List</a>
       <a href="viewPatients.jsp">View Patients List</a>
       <a href="addDoctor.jsp">Add Doctor</a>
       <a href="remove_doctor.jsp">Remove Doctor</a>
       <a href="appointmentdetails.jsp">Appointment Details</a>
       <a href="adminFeedbacks.jsp">View Feedbacks</a>
       <a href="adminReports.jsp">View Reports</a>
       <a href="<%= request.getContextPath() %>/logout" class="logout-link">Logout</a>
    </div>
    
</body>
</html>
