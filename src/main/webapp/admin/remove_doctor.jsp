<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.Statement" %>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <title>Remove Doctor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .container h1 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .success-msg, .error-msg {
            font-weight: bold;
            text-align: center;
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
    <div class="container">
        <h1>Remove Doctor</h1>
        <form method="post">
            <div class="form-group">
                <label for="doctorID">Doctor ID:</label>
                <input type="text" id="doctorID" name="doctorID" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Remove Doctor">
            </div>
        </form>
        <%
            String doctorID = request.getParameter("doctorID");
            if (doctorID != null && !doctorID.isEmpty()) {
                try {
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    int rowsAffected = st.executeUpdate("DELETE FROM Doctors WHERE id = " + doctorID);
                    if (rowsAffected > 0) {
                        out.println("<p class='success-msg'>Doctor Removed Successfully!!</p>");
                    } else {
                        out.println("<p class='error-msg'>Doctor with ID " + doctorID + " not found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error-msg'>EXCEPTION OCCURS: " + e.getMessage() + "</p>");
                }
            }
        %>
        <p><a href="adminsPortal.jsp">Back to Admin Portal</a></p>
    </div>
</body>
</html>
