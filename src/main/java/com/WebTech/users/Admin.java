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
 * Servlet implementation class admin
 */
@WebServlet("/admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String course_id = request.getParameter("cID");
		String course_title = request.getParameter("ctitle");
		String credit = request.getParameter("credit");
		String type = request.getParameter("type");
		String insID = request.getParameter("insID");
		
		int credits = Integer.parseInt(credit); 
		int instructor_ID = Integer.parseInt(insID);
		
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
			
			pst = con.prepareStatement("insert into courses(instructor_id, course_id, course_title, credits, type) VALUES (?,?,?,?,?)");
			
			pst.setInt(1, instructor_ID);
			pst.setInt(4, credits);
			pst.setString(2, course_id);
			pst.setString(3, course_title);
			pst.setString(5, type);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("admin.jsp");
			
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
