<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement"%>
<%@ page import="github.ehealth.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Give Feedback</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h1 {
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .message {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
     <jsp:include page="patient.jsp" />
    <div class="container">
        <h1>Give Feedback</h1>
        <form method="post">
            <label for="rating">Rating:</label>
            <input type="number" name="rating" min="1" max="5" required><br>

            <label for="address">Address:</label>
            <textarea name="address" rows="4" cols="50" required></textarea><br>

            <label for="comment">Comment:</label>
            <textarea name="comment" rows="4" cols="50" required></textarea><br>

            <input type="submit" name="submitFeedback" value="Submit Feedback">
        </form>
        <div class="message">
            <%
        if ("POST".equals(request.getMethod()) && request.getParameter("submitFeedback") != null) {
            int patientID = (int) session.getAttribute("userID");
            int rating = Integer.parseInt(request.getParameter("rating"));
            String address = request.getParameter("address");
            String comment = request.getParameter("comment");

            try {
                Connection conn = ConnectionProvider.getCon();
                String insertQuery = "INSERT INTO Feedback (patient_ID, rating, address, comment) VALUES (?, ?, ?, ?)";

                try (
                    PreparedStatement stmt = conn.prepareStatement(insertQuery);
                ) {
                    stmt.setInt(1, patientID);
                    stmt.setInt(2, rating);
                    stmt.setString(3, address);
                    stmt.setString(4, comment);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("Feedback submitted successfully.");
                    } else {
                        out.println("Feedback submission failed.");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("An error occurred while submitting the feedback.");
            }
        }
    %>
        </div>
    </div>
</body>
</html>

