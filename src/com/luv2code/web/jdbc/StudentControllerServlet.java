package com.luv2code.web.jdbc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/StudentControllerServlet")
public class StudentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private StudentDbUtil studentDbUtil;
	
	@Resource (name="jdbc/web_student_tracker")
	private DataSource dataSource;

	@Override
	public void init() throws ServletException {
		super.init();
		
		try {
			studentDbUtil = new StudentDbUtil(dataSource);
		} catch (Exception exc) {
			throw new ServletException (exc);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        String theCommand = request.getParameter("command");

	        if (theCommand == null) {
	            theCommand = "LIST";
	        }

	        switch (theCommand) {
	            case "ADD":
	                addStudent(request, response);
	                break;
	            case "UPDATE":
	                updateStudent(request, response);
	                break;
	            case "DELETE":
					deleteStudent(request, response);
					break;
	            default:
	                doGet(request, response);
	        }

	    } catch (Exception exc) {
	        throw new ServletException(exc);
	    }
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			
			String theCommand = request.getParameter("command");
			if(theCommand == null) {
				theCommand = "LIST";
			}
			
			switch (theCommand) {
				case "LIST":
					listStudents(request, response);
					break;
				case "LOAD":
					loadStudent(request, response);
					break;
				case "SEARCH":
					searchStudent (request, response);
					break;
				default:
					listStudents(request, response);
			}
			
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	private void searchStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String term = request.getParameter("term");

	    if (term == null || term.trim().length() < 3) {
	        request.setAttribute("STUDENT_LIST", new ArrayList<Student>());
	        request.setAttribute("TERM_NON_VALIDO", true);
	        
	    } else {
	    	
	        List<Student> studentiTrovati = studentDbUtil.searchStudent(term);
	        
	        for (Student s : studentiTrovati) {
	        	s.setFirstName(formatName(s.getFirstName()));
	        	s.setLastName(formatName(s.getLastName()));
	        	s.setEmail(formatName(s.getEmail()));
	        }
	        
	        request.setAttribute("STUDENT_LIST", studentiTrovati);
	    }

	    RequestDispatcher dispatcher = request.getRequestDispatcher("/list-students.jsp");
	    dispatcher.forward(request, response);
		
	}

	private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String theStudentId = request.getParameter("studentId");
		studentDbUtil.deleteStudent(theStudentId);
		
		listStudents(request, response);
		
	}

	private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int id = Integer.parseInt(request.getParameter("studentId"));
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		
		Student theStudent = new Student (id, firstName, lastName, email);
		
		studentDbUtil.updateStudent(theStudent);
		
		listStudents(request, response);
	}

	private void loadStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String theStudentId = request.getParameter("studentId");
		
		Student theStudent = studentDbUtil.getStudent (theStudentId);
		
		request.setAttribute("THE_STUDENT", theStudent);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/update-student-form.jsp");
		dispatcher.forward(request, response);
		
	}

	private void addStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {

	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");
	    String email = request.getParameter("email");

	    if (firstName != null && !firstName.trim().isEmpty() &&
	        lastName != null && !lastName.trim().isEmpty() &&
	        email != null && !email.trim().isEmpty()) {

	        Student theStudent = new Student(firstName, lastName, email);

	        // Controllo duplicato
	        if (studentDbUtil.isDuplicate(theStudent)) {
	            response.sendRedirect("add-student-form.jsp?duplicate=true");
	            return;
	        }

	        // Non è duplicato -> salva
	        studentDbUtil.addStudent(theStudent);
	    }

	    response.sendRedirect("StudentControllerServlet?command=LIST");
	}



	private void listStudents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<Student> students = studentDbUtil.getStudents();
		
		for (Student s : students) {
			s.setFirstName(formatName(s.getFirstName()));
			s.setLastName(formatName(s.getLastName()));
			s.setEmail(s.getEmail().toLowerCase());
		}
		
		request.setAttribute("STUDENT_LIST", students);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/list-students.jsp");
		dispatcher.forward(request, response);
		
	}

	private String formatName(String name) {
		
		if (name == null || name.isEmpty()) return "";
		name = name.trim().toLowerCase();
		return Character.toUpperCase (name.charAt(0)) + name.substring(1);
	}

}
