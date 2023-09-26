<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Details</title>
    <style>
    
       /* styles.css */
.feedback-table {
    width: 100%;
    border-collapse: collapse;
    border: 1px solid black;
    margin-top: 20px;
}

.feedback-table th, .feedback-table td {
    border: 1px solid black;
    padding: 8px;
    text-align: center;
}

.feedback-table th {
    background-color: #f2f2f2;
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
<jsp:include page="header.jsp"></jsp:include>
    <h1>Feedback Details</h1>
    <table class="feedback-table">
        <tr>
            <th>ID</th>
            <th>Patient ID</th>
            <th>Rating</th>
            <th>Address</th>
            <th>Comment</th>
        </tr>

        <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/ehms" user="root" password="939164"/>
        <sql:query dataSource="${db}" var="result">
            SELECT * FROM Feedback
        </sql:query>

        <c:forEach var="row" items="${result.rows}">
            <tr>
                <td>${row.id}</td>
                <td>${row.patient_ID}</td>
                <td>${row.rating}</td>
                <td>${row.address}</td>
                <td>${row.comment}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
