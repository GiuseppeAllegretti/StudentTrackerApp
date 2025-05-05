package com.luv2code.web.jdbc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;



/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
        	Context initContext = new InitialContext();
        	Context envContext = (Context) initContext.lookup("java:/comp/env");
        	dataSource = (DataSource) envContext.lookup("jdbc/web_student_tracker");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                request.getSession().setAttribute("user", email);
                request.getSession().setAttribute("role", role);
                response.sendRedirect("StudentControllerServlet?command=LIST");
            } else {
                response.sendRedirect("login.jsp?error=true");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

}
