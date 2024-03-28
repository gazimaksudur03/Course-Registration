package com.WebTech.registration;

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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String upwd = request.getParameter("pass");
		String umobile = request.getParameter("contact");
		String urole = request.getParameter("role");

		String ureg = request.getParameter("ureg");
		
		PrintWriter out = response.getWriter();
//		out.println(uname);
//		out.println(uemail);
//		out.println(upwd);
//		out.println(umobile);
//		out.println(urole);
//		out.println(ureg);
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_reg?useSSL=false","root","");
			
			PreparedStatement pst = null;
			
			if(urole.equals("Student")) {
				pst = con.prepareStatement("insert into students(reg_num, uname, upwd, uemail, umobile) values(?,?,?,?,?) ");
				
				pst.setString(1, ureg);
				pst.setString(2, uname);
				pst.setString(3, upwd);
				pst.setString(4, uemail);
				pst.setString(5, umobile);
				
//				out.println("at students");
			}else if(urole.equals("Admin")) {
				pst = con.prepareStatement("insert into admin(uname, upwd, uemail, umobile) values(?,?,?,?) ");
				out.println("at admin");

				pst.setString(1, uname);
				pst.setString(2, upwd);
				pst.setString(3, uemail);
				pst.setString(4, umobile);
			}else if(urole.equals("Teacher")) {
				pst = con.prepareStatement("insert into teachers(uname, upwd, uemail, umobile) values(?,?,?,?) ");
				
//				out.println("at teachers");

				pst.setString(1, uname);
				pst.setString(2, upwd);
				pst.setString(3, uemail);
				pst.setString(4, umobile);
			}else {
				out.println("invalid input detected");
			}
			
			
//			out.println("out without matching any condition"+urole);
//			pst.setString(1, uname);
//			pst.setString(2, upwd);
//			pst.setString(3, uemail);
//			pst.setString(4, umobile);
//			
			int rowCount = pst.executeUpdate();
////			ResultSet rs = pst.executeQuery();
			dispatcher = request.getRequestDispatcher("registration.jsp");
			
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
