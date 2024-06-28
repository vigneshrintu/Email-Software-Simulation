<%@ page import="java.sql.*" %>
<%
    String emailId = request.getParameter("emailId");
    String userEmail = (String) session.getAttribute("userEmail");

    if (emailId != null && userEmail != null) {
        String jdbcURL = "jdbc:mysql://localhost:3306/emailSoftware";
        String dbUser = "root";
        String dbPassword = "vigneshrintu";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Set deleted_by_receiver to TRUE
            String query = "UPDATE emails SET deleted_by_receiver = TRUE WHERE email_id = ? AND receiver_email = ?";
            stmt = connection.prepareStatement(query);
            stmt.setString(1, emailId);
            stmt.setString(2, userEmail);
            stmt.executeUpdate();

            // Check if both deleted_by_sender and deleted_by_receiver are TRUE
            query = "DELETE FROM emails WHERE email_id = ? AND deleted_by_sender = TRUE AND deleted_by_receiver = TRUE";
            stmt = connection.prepareStatement(query);
            stmt.setString(1, emailId);
            stmt.executeUpdate();
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

    response.sendRedirect("inbox.jsp");
%>
