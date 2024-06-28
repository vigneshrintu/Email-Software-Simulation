<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Software Simulation - Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #000000, #1a1a2e);
            color: #fff;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            overflow-x: hidden;
        }

        .container {
            max-width: 400px;
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            animation: fadeIn 1s ease-out, floatAnimation 6s ease-in-out infinite;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-align: center;
            color: #fff;
            animation: slideInDown 1s ease-out, glowAnimation 2s ease-in-out infinite alternate;
        }

        h2 {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
            color: #4da6ff;
            animation: slideInUp 1s ease-out 0.5s both;
        }

        .input-group {
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #fff;
            transition: all 0.3s ease;
            transform-origin: left;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: none;
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
            background: none;
            color: #fff;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            outline: none;
            border-bottom-color: #4da6ff;
        }

        .input-group input:focus + label,
        .input-group input:not(:placeholder-shown) + label {
            transform: translateY(-20px) scale(0.8);
            color: #4da6ff;
        }

        .button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: rgba(77, 166, 255, 0.2);
            color: #fff;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .button:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.6s ease;
        }

        .button:hover:before {
            width: 300px;
            height: 300px;
        }

        .button:hover {
            background-color: rgba(77, 166, 255, 0.4);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .error {
            color: #ff3333;
            margin-top: 20px;
            text-align: center;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideInDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes floatAnimation {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        @keyframes glowAnimation {
            from { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
            to { text-shadow: 0 0 20px rgba(255, 255, 255, 0.8), 0 0 30px rgba(255, 255, 255, 0.6); }
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Email Software Simulation</h1>
        <h2>Login</h2>
        <form action="login.jsp" method="post">
            <div class="input-group">
                <input type="email" id="email" name="email" required placeholder=" ">
                <label for="email">Email</label>
            </div>
            <div class="input-group">
                <input type="password" id="password" name="password" required placeholder=" ">
                <label for="password">Password</label>
            </div>
            <button type="submit" class="button">Login</button>
        </form>
        <%@ page import="java.sql.*" %>
        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email != null && password != null) {
                String jdbcURL = "jdbc:mysql://localhost:3306/emailSoftware";
                String dbUser = "root";
                String dbPassword = "vigneshrintu";

                Connection connection = null;
                PreparedStatement stmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String query = "SELECT * FROM users WHERE email = ? AND password = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, email);
                    stmt.setString(2, password);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("userEmail", email);
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        out.println("<p class='error'>User not found. Redirecting to register...</p>");
                        response.setHeader("Refresh", "3; URL=register.jsp");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='error'>An error occurred: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>