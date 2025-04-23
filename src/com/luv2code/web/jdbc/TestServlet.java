package com.luv2code.web.jdbc;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/TestServlet") // quando l'utente va sul link viene eseguito questo Servlet
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	@Resource(name="jdbc/web_student_tracker") 
	private DataSource dataSource;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		Connection myConn = null; // connessione al database
		Statement myStmt = null; // oggetto per eseguire comandi SQL
		ResultSet myRs = null; // conterrà i risultati delle query
		
		try {
			myConn = dataSource.getConnection();
 			String sql = "select * from student";
			myStmt = myConn.createStatement();
			
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				String firstName = myRs.getString("first_name");
				String lastname = myRs.getString("last_name");
				String email = myRs.getString("email");
				out.println(firstName + " " + lastname + " " + email);
			}
			
		} catch (Exception exc) {
			exc.printStackTrace();
		}
		// 3. 
	}
}
