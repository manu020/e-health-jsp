<!DOCTYPE html>
<html>
<head>
    <title>Doctor Details</title>
    <style>
        body {
            font-family: "Helvetica Neue", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff5e1; /* New background color */
        }

        #header {
            background-color: #2c3e50;
            color: #ffffff;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            text-decoration: none;
            color: #333;
            padding: 10px 20px;
            border: 2px solid #e74c3c;
            border-radius: 4px;
            background-color: #ffffff;
            transition: background-color 0.3s ease;
        }

        nav ul li a:hover {
            background-color: #e74c3c;
            color: #ffffff;
        }

        #content {
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
            margin: 20px;
        }
    </style>
</head>
<body>
    <div id="header">
        <h1>Welcome to Your Doctor Page</h1>
        <nav>
            <ul>
                <li><a href="doctorprofile.jsp">View Doctor Profile</a></li>
                <li><a href="doctorappointment.jsp">View Appointments</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>
    </div>
</body>
</html>
