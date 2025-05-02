package com.luv2code.web.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;


public class StudentDbUtil {
	
	private DataSource dataSource;
	
	public StudentDbUtil (DataSource theDataSource) {
		dataSource = theDataSource;
	}
	
	public List<Student> getStudents() throws Exception {
		
		List<Student> students = new ArrayList<>();
		
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;

		try {
			myConn = dataSource.getConnection();
			
			String sql = "select * from student order by last_name";
			
			myStmt = myConn.createStatement();
			
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				int id = myRs.getInt("id");
				String firstName = myRs.getString("first_name");
				String lastName = myRs.getString("last_name");
				String email = myRs.getString("email");
				
				Student tempStudent = new Student (id, firstName, lastName, email);
				 
				students.add(tempStudent);
				
			}
			
			return students;
			
		}finally {
			close(myConn, myStmt, myRs);
		}

	}
	
	public List<Student> searchStudentBy(String term, String searchBy) throws Exception {
			
		List<Student> studentsRicerca = new ArrayList<>();
			
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
			
		String campoValido;
		switch (searchBy) {
			case "id":
				campoValido = "id";
			    break;
			case "firstName":
			    campoValido = "first_name";
			    break;
			case "lastName":
			    campoValido = "last_name";
			    break;
			case "email":
			    campoValido = "email";
			    break;
			default:
			    throw new IllegalArgumentException("Campo di ricerca non valido");
		}
	
		try {
			myConn = dataSource.getConnection();
				
			String sql;
			if (campoValido.equals("id")) {
				sql = "SELECT * FROM student WHERE id=?";
					
				myStmt = myConn.prepareStatement(sql);
				myStmt.setInt(1, Integer.parseInt(term));
			} else {
				sql = "SELECT * FROM student WHERE " + campoValido + " LIKE ?";
					
				myStmt = myConn.prepareStatement(sql);
				myStmt.setString (1, term + "%");
			}
				
			myRs = myStmt.executeQuery();
				
			while (myRs.next()) {
				int id = myRs.getInt("id");
				String firstName = myRs.getString("first_name");
				String lastName = myRs.getString("last_name");
				String email = myRs.getString("email");
					
				Student tempStudent = new Student (id, firstName, lastName, email);
					 
				studentsRicerca.add(tempStudent);
					
			}
				
			return studentsRicerca;
				
		}finally {
			close(myConn, myStmt, myRs);
		}
		
	}

	private void close(Connection myConn, Statement myStmt, ResultSet myRs) {
		
		try {
			if (myRs != null) {
				myRs.close();
			}
			
			if (myStmt != null) {
				myStmt.close();
			}
			
			if (myConn != null) {
				myConn.close(); 
			}
			
		} catch (Exception exc) {	
			exc.printStackTrace();
		}
	}

	public void addStudent(Student theStudent) throws Exception {
		
		Connection myConn = null;
		PreparedStatement myStmt = null;
		
		try {
			myConn = dataSource.getConnection();
			
			String sql = "insert into student"
					+ "(first_name, last_name, email)"
					+ "values (?, ?, ?)";
			
			myStmt = myConn.prepareStatement(sql);
			
			myStmt.setString (1, theStudent.getFirstName());
			myStmt.setString (2, theStudent.getLastName());
			myStmt.setString (3, theStudent.getEmail());
			
			myStmt.execute();
			
		} finally {
			close(myConn, myStmt, null);
		}
	}
	
	/*
	public boolean isDuplicate(Student student) throws Exception {
	    boolean isDuplicate = false;

	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        conn = dataSource.getConnection();

	        String sql = "SELECT COUNT(*) FROM student WHERE first_name=? AND last_name=? AND email=?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, student.getFirstName());
	        stmt.setString(2, student.getLastName());
	        stmt.setString(3, student.getEmail());

	        rs = stmt.executeQuery();

	        if (rs.next()) {
	            int count = rs.getInt(1);
	            isDuplicate = (count > 0);
	        }

	        return isDuplicate;

	    } finally {
	        close(conn, stmt, rs);
	    }
	}
	*/
	
	public boolean isEmailAlreadyUsed(String email) throws Exception {
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM student WHERE email=?")) {

	        stmt.setString(1, email);

	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt(1) > 0;
	            }
	        }
	    }

	    return false;
	}



	public Student getStudent(String theStudentId) throws Exception {
		
		Student theStudent = null;
		
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		int studentId;
		
		try {
			studentId = Integer.parseInt(theStudentId);
			
			myConn = dataSource.getConnection();
			
			String sql = "select * from student where id=?";
			myStmt = myConn.prepareStatement(sql);
			
			myStmt.setInt(1,  studentId);
			
			myRs = myStmt.executeQuery();
			
			if (myRs.next()) {
				String firstName = myRs.getString("first_name");
				String lastName = myRs.getString("last_name");
				String email = myRs.getString("email");
				
				theStudent = new Student (studentId, firstName, lastName, email);
			} else {
				throw new Exception("Could not find student id: " + studentId);
			}

			return theStudent;	
			
		} finally {
			close(myConn, myStmt, myRs);
		}
		

	}

	public void updateStudent(Student theStudent) throws Exception {
		
		Connection myConn = null;
		PreparedStatement myStmt = null; 
		
		try {
			myConn = dataSource.getConnection();
			
			String sql = "update student "
					+ "set first_name=?, last_name=?, email=? "
					+ "where id=?";
			myStmt = myConn.prepareStatement(sql);
			
			myStmt.setString (1,  theStudent.getFirstName());
			myStmt.setString (2,  theStudent.getLastName());
			myStmt.setString (3,  theStudent.getEmail());
			myStmt.setInt (4,  theStudent.getId());
			
			myStmt.execute();
			
		} finally {
			close (myConn, myStmt, null);
		}
	}

	public void deleteStudent(String theStudentId) throws Exception {
		
		Connection myConn = null;
		PreparedStatement myStmt = null; 
		
		try {
			int studentId = Integer.parseInt(theStudentId);
			
			myConn = dataSource.getConnection();
			
			String sql = "delete from student where id=?";
			myStmt = myConn.prepareStatement(sql);
			
			myStmt.setInt(1, studentId);
			
			myStmt.execute();
			
		} finally {
			close (myConn, myStmt, null);
		}
	}
}
