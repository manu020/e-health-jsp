<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Get the selected doctor type from the request parameter
    String selectedDoctorType = request.getParameter("doctorType");

	System.out.println(selectedDoctorType);
    // Initialize the database connection
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Set up the database connection
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost/ehms", "root", "939164");

        // Query to fetch doctor names based on selected doctor type
        String query = "SELECT first_name, id FROM doctors WHERE doctor_type = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, selectedDoctorType);
        resultSet = preparedStatement.executeQuery();

        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");
        boolean isFirst = true;

        // Populate JSON with doctor names
        while (resultSet.next()) {
            if (!isFirst) {
                jsonBuilder.append(",");
            }
            isFirst = false;
            String doctorName = resultSet.getString(1);
            String doctorId = resultSet.getString(2);
            jsonBuilder.append("{\"doctor_id\":\"").append(doctorId)
                       .append("\",\"doctor_name\":\"").append(doctorName).append("\"}");
        }

        jsonBuilder.append("]");
		System.out.println(jsonBuilder.toString());
        // Set the response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Write JSON response
        response.getWriter().write(jsonBuilder.toString());

    

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        if (resultSet != null) {
            resultSet.close();
        }
        if (preparedStatement != null) {
            preparedStatement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
