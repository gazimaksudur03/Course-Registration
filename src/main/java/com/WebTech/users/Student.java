package com.WebTech.users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class Student
 */
@WebServlet("/student")
public class Student extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Student() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String course_id = request.getParameter("cID");
		String course_title = request.getParameter("reg_no");
		
		
//		PrintWriter out = response.getWriter();
//		out.println(course_id);
//		out.println(course_title);
//		out.println(credits);
//		out.println(type);
//		out.println(instructor_ID);
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_reg?useSSL=false","root","");
			
			PreparedStatement pst = null;
			
			pst = con.prepareStatement("insert into takes(std_reg, course_id) VALUE (?,?)");
			
			pst.setString(2, course_id);
			pst.setString(1, course_title);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("student.jsp");
			
			if(rowCount > 0 ) {
				request.setAttribute("status", "success");
			}else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
