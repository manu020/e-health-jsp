<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        form {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            text-align: center;
        }

        h3 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        p {
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            color: #3498db;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%
    if(request.getMethod().equals("POST")) {
    	String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        int resetUserID = (Integer) session.getAttribute("resetUserID");
        String resetUserType = (String) session.getAttribute("resetUserType");

        // Verify that the new password and confirm password match
        if (newPassword.equals(confirmPassword)) {
            // Update the user's password in the database
            Connection con = ConnectionProvider.getCon();
            String updateQuery = "UPDATE users SET password=? WHERE userID=?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setInt(2, resetUserID);
                updateStmt.executeUpdate();

                // Password reset successful, display a success message
                out.println("<p>Password reset successful. You can now <a href='login.jsp'>login</a> with your new password.</p>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Passwords do not match, display an error message
            out.println("<p>Passwords do not match. Please try again.</p>");
        }

        // Clear the session attributes
        session.removeAttribute("resetUserID");
        session.removeAttribute("resetUserType");
    }
        
    %>

    <!-- HTML form for entering the new password -->
    <form method="post" action="reset_password_form.jsp">
        <h3>Reset Password</h3>
        <label for="newPassword">New Password:</label>
        <input type="password" name="newPassword" required><br>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" name="confirmPassword" required><br>
        <input type="submit" value="Reset Password">
    </form>
</body>
</html>
