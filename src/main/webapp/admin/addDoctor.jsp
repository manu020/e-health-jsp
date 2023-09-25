<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Doctor</title>
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
        <h1>Add Doctor</h1>
        <form method="post">
            
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
             <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <input type="text" id="gender" name="gender" required>
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number:</label>
                <input type="text" id="contactNumber" name="contactNumber" required>
            </div>
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="text" id="age" name="age" required>
            </div>
            <div class="form-group">
                <label for="entryCharge">Entry Charge:</label>
                <input type="text" id="entryCharge" name="entry_fee" required>
            </div>
            <div class="form-group">
                <label for="qualification">Qualification:</label>
                <input type="text" id="qualification" name="qualification" required>
            </div>
            <div class="form-group">
                <label for="doctortype">Doctor Type:</label>
                <input type="text" id="doctortype" name="doctortype" required>
            </div>
            <div class="form-group">
                <label for="email">Email ID:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="username">UserName:</label>
                <input type="text"  name="username" required>
            </div>
            <div class="form-group">
                <label for="password">PassWord:</label>
                <input type="text"  name="password" required>
            </div>
            
            <div class="form-group">
                <input type="submit" value="Add Doctor">
            </div>
        </form>
        <%
        if (request.getMethod().equalsIgnoreCase("post")) {
           
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String contactNumber = request.getParameter("contactNumber");
            int age = Integer.parseInt(request.getParameter("age"));
            double entryCharge = Double.parseDouble(request.getParameter("entry_fee"));
            String qualification = request.getParameter("qualification");
            String doctortype=request.getParameter("doctortype");
            String email = request.getParameter("email");
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            String insert = "insert into users values(?, (select id from doctors where email = ?), 'Doctor', ?);";
            try(
            		Connection conn = ConnectionProvider.getCon();
            		PreparedStatement pst = conn.prepareStatement("INSERT INTO doctors (first_name, last_name, gender, contact_number, age, entry_fee, qualification, doctor_type, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            		PreparedStatement insertq = conn.prepareStatement(insert);
            ) {
              
                
                pst.setString(1, firstName);
                pst.setString(2, lastName);
                pst.setString(3, gender);
                pst.setString(4, contactNumber);
                pst.setInt(5, age);
                pst.setDouble(6, entryCharge);
                pst.setString(7, qualification);
                pst.setString(8,doctortype);
                pst.setString(9, email);

                int rowsAffected = pst.executeUpdate();
                
                
               
               
               insertq.setString(1, username);
               insertq.setString(2, email);
               insertq.setString(3, password);
               insertq.executeUpdate();
               
               
                if (rowsAffected > 0) {
                    out.println("<p class='success-msg'>Doctor Added Successfully!!</p>");
                } else {
                    out.println("<p class='error-msg'>Failed to add the doctor.</p>");
                }
            } catch (Exception e) {
            	
            	
            	out.println("PLEASE TRY WITH NEW DOCTOR_ID");
               out.println("<p class='error-msg'>EXCEPTION OCCURS: " + e.getMessage() + "</p>");
              e.printStackTrace();
            }
        }
        %>
        
        <p><a href="adminsPortal.jsp">Back to Admin Portal</a></p>
    </div>
</body>
</html>

