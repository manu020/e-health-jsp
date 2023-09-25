<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="github.ehealth.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Login</title>
    <style>
     body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        .doctor-info {
            margin-top: 20px;
        }

        .doctor-info p {
            margin: 10px 0;
        }

        a {
            text-decoration: none;
            color: #007BFF;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <jsp:include page="doctor.jsp"></jsp:include>
    <div class="container">
        <h1>Doctor Information</h1>
        <div class="doctor-info">
        <% Object userIDObj = session.getAttribute("userID");
           Object userTypeObj = session.getAttribute("userType");

        if (userIDObj == null || userTypeObj == null) {
            out.println("<p>Session data not available. Please <a href='login.jsp'>log in</a> again.</p>");
        } else {
            int id = (Integer) userIDObj;
            String userType = (String) userTypeObj;            
            try (Connection con = ConnectionProvider.getCon();
                 PreparedStatement pst = con.prepareStatement("SELECT * FROM doctors where id = ?")) {
                pst.setInt(1, id);
                
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    int doctorId = rs.getInt("id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String gender = rs.getString("gender");
                    String contactNumber = rs.getString("contact_number");
                    int age = rs.getInt("age");
                    int entryFee = rs.getInt("entry_fee");
                    String qualification = rs.getString("qualification");
                    String doctorType = rs.getString("doctor_type");
                    String email = rs.getString("email");
                    
                    
                    out.println("<p>Doctor ID: " + doctorId + "</p>");
                    out.println("<p>First Name: " + firstName + "</p>");
                    out.println("<p>Last Name: " + lastName + "</p>");
                    out.println("<p>Gender: " + gender + "</p>");
                    out.println("<p>Contact Number: " + contactNumber + "</p>");
                    out.println("<p>Age: " + age + "</p>");
                    out.println("<p>Entry Fee: " + entryFee + "</p>");
                    out.println("<p>Qualification: " + qualification + "</p>");
                    out.println("<p>Doctor Type: " + doctorType + "</p>");
                    out.println("<p>Email: " + email + "</p>");
                } else {
                    out.println("<p>Doctor not found</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        %>
        </div>
        
        <p><a href="home.jsp">Back to Login</a></p>
    </div>
</body>
</html>

	
