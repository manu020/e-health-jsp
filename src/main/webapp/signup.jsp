<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Sign Up</title>
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
        .horizontal-radio {
         display: flex;
        gap: 15px; /* Adjust the spacing as needed */
   }

      .horizontal-radio label {
      margin-right: 15px;
       }
       <style>
    /* Your existing CSS */

    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
</style>
       
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="container">
        <h1>Patient Sign Up</h1>
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
    <label>Gender:</label>
    <div class="horizontal-radio">
        <label><input type="radio" name="gender" value="Male" required> Male</label>
        <label><input type="radio" name="gender" value="Female" required> Female</label>
        <label><input type="radio" name="gender" value="Others" required> Others</label>
    </div>
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
                <label for="email">Email ID:</label>
                <input type="email" id="email" name="email" required>
            </div>
           <div class="form-group">
         <label for="bloodGroup">Blood Group:</label>
         <select id="bloodGroup" name="bloodGroup" required>
        <option value="" disabled selected>Select a blood group</option>
        <option value="A+">A+</option>
        <option value="A-">A-</option>
        <option value="B+">B+</option>
        <option value="B-">B-</option>
        <option value="AB+">AB+</option>
        <option value="AB-">AB-</option>
        <option value="O+">O+</option>
        <option value="O-">O-</option>
    </select>
</div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
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
                <input type="submit" value="Sign Up">
            </div>
        </form>
        <% if (request.getMethod().equalsIgnoreCase("post")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String contactNumber = request.getParameter("contactNumber");
            int age = Integer.parseInt(request.getParameter("age"));
            String email = request.getParameter("email");
            String bloodGroup = request.getParameter("bloodGroup");
            String address = request.getParameter("address");
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            String insert = "insert into users values(?, (select id from patients where email = ?), 'Patient', ?);";
            
            try (Connection con = ConnectionProvider.getCon();
                 PreparedStatement pst = con.prepareStatement("INSERT INTO patients (first_name, last_name, gender, contact_number, age, email, blood_group, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            		PreparedStatement insertq = con.prepareStatement(insert);
            		) {
                pst.setString(1, firstName);
                pst.setString(2, lastName);
                pst.setString(3, gender);
                pst.setString(4, contactNumber);
                pst.setInt(5, age);
                pst.setString(6, email);
                pst.setString(7, bloodGroup);
                pst.setString(8, address);

                int rowsAffected = pst.executeUpdate();
                
                insertq.setString(1, username);
                insertq.setString(2, email);
                insertq.setString(3, password);
                insertq.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p class='success-msg'>Patient Sign Up Successful!</p>");
                } else {
                    out.println("<p class='error-msg'>Failed to sign up patient.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error-msg'>Exception: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
        %>
        <p><a href="home.jsp">Back to home page</a></p>
    </div>
</body>
</html>
