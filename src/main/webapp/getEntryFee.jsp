<%@ page language="java" contentType="application/json; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%
// Get the selected doctor name from the request parameter
String selectedDoctorName = request.getParameter("doctorid");

// Initialize the database connection
Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

try {
	// Set up the database connection
	Class.forName("com.mysql.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost/ehms", "root", "939164");

	// Query to fetch entry fee for the selected doctor name
	String query = "SELECT entry_fee FROM doctors WHERE id = ?";
	preparedStatement = connection.prepareStatement(query);
	preparedStatement.setInt(1, Integer.parseInt(selectedDoctorName));
	resultSet = preparedStatement.executeQuery();
	String entryFeeJson = "{\"entry_fee\":\"";

	// Process the result if there's one entry
	if (resultSet.next()) {
		String entryFee = resultSet.getString("entry_fee");
		entryFeeJson += entryFee + "\"}";
	} else {
		entryFeeJson += "N/A\"}";
	}

	// Set the response content type to JSON
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");

	// Write JSON response
	response.getWriter().write(entryFeeJson);

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
