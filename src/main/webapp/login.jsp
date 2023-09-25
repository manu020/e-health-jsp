<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        form {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px 44px ;
            border-radius: 5px;
            box-shadow: 0px 3px 8px 3px #e7cccc;
            width: 300px;
            border-radius: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
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

        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }

        .forgot-password a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <form method="post">
        <h3>Login form</h3>
        <label for="username">Username:</label>
        <input type="text" name="username" required><br>
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        
        <!-- Forgot Password link inside the form -->
        <div class="forgot-password">
            <a href="forget.jsp">Forgot Password?</a>
        </div>
        
        <input type="submit" value="Login">
    </form>
    
    <%
        String enteredUsername = request.getParameter("username");
        String enteredPassword = request.getParameter("password");
        if(enteredPassword != null && enteredUsername != null) {
            if(enteredUsername.equals("xyz") && enteredPassword.equals("123")){
                session.setAttribute("userID", 22);
                session.setAttribute("userType", "Admin");
                response.sendRedirect("admin/adminsPortal.jsp");
            }
            else {

                Connection con=ConnectionProvider.getCon();
                String query="select userType, userID from users where username=? and password=?;";
                PreparedStatement pst=con.prepareStatement(query);
                pst.setString(1, enteredUsername);
                pst.setString(2, enteredPassword);
                ResultSet set= pst.executeQuery();
                if(set.next()) {
                    switch(set.getString(1)) {
                    case "Doctor": 
                        session.setAttribute("userID", set.getInt(2));
                        session.setAttribute("userType", "Doctor");
                        response.sendRedirect("doctor.jsp");
                        break;
                        
                    case "Patient": 
                        session.setAttribute("userID", set.getInt(2));
                        session.setAttribute("userType", "Patient");
                        response.sendRedirect("patient.jsp");
                        break;
                    default: out.print("Unknown user type");
                    }
                }
            }
        }
    %>
</body>
</html>
