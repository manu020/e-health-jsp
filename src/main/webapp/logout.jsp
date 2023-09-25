<!DOCTYPE html>
<html>
<head>
    <title>Session Expired</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .logout-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .logout-title {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .logout-message {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .login-link {
            text-decoration: none;
            color: #880015;
            font-weight: bold;
        }

        .login-link:hover {
            color: #66000a;
        }
    </style>
</head>
<body>
    <div class="logout-box">
        <div class="logout-title">Session Expired</div>
        <div class="logout-message">
            Your session has expired. Please <a class="login-link" href="login.jsp">log in</a> again.
        </div>
    </div>
</body>
</html>
