<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sent Box</title>
    <style>
        body, html {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
            height: 100%;
        }
        .container {
            display: flex;
            flex-direction: column;
            height: 100vh;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }
        h2 {
            text-align: center;
            color: #ffffff;
            margin-bottom: 30px;
        }
        .table-container {
            flex-grow: 1;
            overflow-y: auto;
            background-color: #1e1e1e;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #2c2c2c;
        }
        th {
            background-color: #2c2c2c;
            color: #ffffff;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        tr:hover {
            background-color: #252525;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #ffffff;
            color: #121212;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 0.9em;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #e0e0e0;
        }
        .actions {
            margin-top: 20px;
            text-align: center;
        }
        .error {
            color: #ff6b6b;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Sent Messages</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Recipient</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String senderEmail = (String) session.getAttribute("userEmail");

                        if (senderEmail != null) {
                            String jdbcURL = "jdbc:mysql://localhost:3306/emailSoftware";
                            String dbUser = "root";
                            String dbPassword = "vigneshrintu";

                            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                                 PreparedStatement stmt = connection.prepareStatement("SELECT * FROM emails WHERE sender_email = ? AND deleted_by_sender = FALSE")) {
                                
                                stmt.setString(1, senderEmail);
                                ResultSet rs = stmt.executeQuery();

                                while (rs.next()) {
                                    int emailId = rs.getInt("email_id");
                                    String receiverEmail = rs.getString("receiver_email");
                                    String subject = rs.getString("subject");
                                    String body = rs.getString("body");
                    %>
                                    <tr>
                                        <td><%= receiverEmail %></td>
                                        <td><%= subject %></td>
                                        <td><%= body %></td>
                                        <td>
                                            <form action="deleteSentEmail.jsp" method="POST">
                                                <input type="hidden" name="emailId" value="<%= emailId %>">
                                                <input type="submit" value="Delete" class="button">
                                            </form>
                                        </td>
                                    </tr>
                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='4' class='error'>An error occurred: " + e.getMessage() + "</td></tr>");
                            }
                        } else {
                            out.println("<tr><td colspan='4' class='error'>User not logged in. Please <a href='login.jsp' style='color: #ffffff;'>login</a> first.</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="actions">
            <a href="dashboard.jsp" class="button">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>