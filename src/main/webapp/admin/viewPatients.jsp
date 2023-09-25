<%@page import="java.util.PrimitiveIterator"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Records</title>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    th {
        background-color: #4CAF50;
        color: white;
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
    String query = "SELECT id,first_name, last_name, gender, contact_number, age, blood_group, address FROM patients;";
    PreparedStatement pst = con.prepareStatement(query);
    ResultSet resultSet = pst.executeQuery();
%>

<h1>Patient Records</h1>

<table>
    <tr>
        <th>PatientID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Gender</th>
        <th>Contact Number</th>
        <th>Age</th>
        <th>Blood Group</th>
        <th>Address</th>
    </tr>
    <% int rowNumber = 0;
    while (resultSet.next()) { 
        rowNumber++;
    %>
    <tr class="<%= rowNumber % 2 == 0 ? "even" : "odd" %>">
        <td><%= resultSet.getInt("id") %></td>
        <td><%= resultSet.getString("first_name") %></td>
        <td><%= resultSet.getString("last_name") %></td>
        <td><%= resultSet.getString("gender") %></td>
        <td><%= resultSet.getString("contact_number") %></td>
        <td><%= resultSet.getInt("age") %></td>
        <td><%= resultSet.getString("blood_group") %></td>
        <td><%= resultSet.getString("address") %></td>
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
