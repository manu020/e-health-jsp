<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
    <!-- Add your CSS styles here -->
</head>
<body>
    <%
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String userType = request.getParameter("userType");
        
        var query = 
        		"select u.userID, u.userType from users as u where " +
        		"u.userId in (select d.id"+
        		"    FROM doctors as d"+
        		"    WHERE d.first_name = ? AND d.last_name = ? AND d.contact_number = ? AND d.email = ?"+
        		") or u.userid in (SELECT p.id"+
        		"    FROM patients as p"+
        		"    WHERE p.first_name = ? AND p.last_name = ? AND p.contact_number = ? AND p.email = ?);";

        // Verify user details against the database
        Connection con = ConnectionProvider.getCon();
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, email);
            stmt.setString(5, firstName);
            stmt.setString(6, lastName);
            stmt.setString(7, phoneNumber);
            stmt.setString(8, email);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
            	String tyStringpe = resultSet.getString("userType");
            	session.setAttribute("resetUserID", resultSet.getInt("userID"));
                session.setAttribute("resetUserType", resultSet.getString("userType"));
                response.sendRedirect("reset_password_form.jsp");
            } else {
                // User details did not match, display an error message
            	out.println("<p>User details do not match our records. Please try again.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
