<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Compose Email</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
        
        body, html {
            font-family: 'Poppins', sans-serif;
            background-color: #000000;
            margin: 0;
            padding: 0;
            height: 100%;
            color: #ffffff;
            overflow-x: hidden;
        }
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            box-sizing: border-box;
            position: relative;
            z-index: 1;
        }
        .compose-form {
            width: 100%;
            max-width: 600px;
            background: rgba(255, 255, 255, 0.05);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            animation: formAppear 1.5s ease-out forwards;
        }
        h2 {
            font-size: 3em;
            margin-bottom: 30px;
            font-weight: 600;
            text-align: center;
            color: #ffffff;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            animation: titleGlow 2s ease-in-out infinite alternate;
        }
        .input-field, .textarea-field {
            width: 100%;
            padding: 15px;
            margin: 15px 0;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-size: 1em;
            transition: all 0.3s ease;
        }
        .input-field:focus, .textarea-field:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
            transform: scale(1.02);
        }
        .textarea-field {
            height: 150px;
            resize: vertical;
        }
        .button {
            display: block;
            width: 100%;
            padding: 15px;
            margin-top: 20px;
            font-size: 1.2em;
            text-decoration: none;
            background-color: #ffffff;
            color: #000000;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            animation: buttonPulse 2s infinite;
        }
        .button:hover {
            background-color: #0056b3;
            color: #ffffff;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 86, 179, 0.3);
        }
        .success {
            color: #4CAF50;
            font-weight: bold;
            animation: fadeInOut 2s ease-in-out;
        }
        .error {
            color: #ff3860;
            font-weight: bold;
            animation: fadeInOut 2s ease-in-out;
        }
        @keyframes formAppear {
            0% { opacity: 0; transform: translateY(50px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        @keyframes titleGlow {
            0% { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
            100% { text-shadow: 0 0 20px rgba(255, 255, 255, 0.8), 0 0 30px rgba(255, 255, 255, 0.6); }
        }
        @keyframes buttonPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        @keyframes fadeInOut {
            0%, 100% { opacity: 0; }
            50% { opacity: 1; }
        }
        .background-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            opacity: 0.5;
            background: linear-gradient(45deg, #000000, #0a0a0a, #1a1a1a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
    </style>
</head>
<body>
    <div class="background-animation"></div>
    <div class="container">
        <div class="compose-form">
            <h2>Compose Email</h2>
            <form action="composeEmail.jsp" method="post">
                <input type="hidden" name="senderEmail" value="<%= session.getAttribute("userEmail") %>" required>
                <input type="email" name="receiverEmail" placeholder="Recipient's Email" class="input-field" required>
                <input type="text" name="subject" placeholder="Subject" class="input-field" required>
                <textarea name="body" placeholder="Message" class="textarea-field" required></textarea>
                <input type="submit" value="Send Email" class="button">
            </form>
            <%
                String senderEmail = (String) session.getAttribute("userEmail");
                String receiverEmail = request.getParameter("receiverEmail");
                String subject = request.getParameter("subject");
                String body = request.getParameter("body");

                if (senderEmail != null && receiverEmail != null && subject != null && body != null) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/emailSoftware";
                    String dbUser = "root";
                    String dbPassword = "vigneshrintu";

                    Connection connection = null;
                    PreparedStatement stmt = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        String query = "INSERT INTO emails (sender_email, receiver_email, subject, body) VALUES (?, ?, ?, ?)";
                        stmt = connection.prepareStatement(query);
                        stmt.setString(1, senderEmail);
                        stmt.setString(2, receiverEmail);
                        stmt.setString(3, subject);
                        stmt.setString(4, body);
                        int row = stmt.executeUpdate();

                        if (row > 0) {
                            out.println("<p class='success'>Email sent successfully!</p>");
                        } else {
                            out.println("<p class='error'>Failed to send email. Please try again.</p>");
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
    </div>
</body>
</html>