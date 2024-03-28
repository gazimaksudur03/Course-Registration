package com.WebTech.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class LoginStudent
 */
@WebServlet("/loginStudent")
public class LoginStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uname = request.getParameter("username");
		String upwd = request.getParameter("password");
		String ureg = request.getParameter("reg");
		
		Connection con = null;
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_reg?useSSL=false","root","");
			PreparedStatement pst = con.prepareStatement("select * from students where uname = ? and upwd = ?");
			
			pst.setString(1, uname);
			pst.setString(2, upwd);
			
			ResultSet rs = pst.executeQuery();
			
			if(rs.next()) {
				session.setAttribute("name", rs.getString("uname"));
				session.setAttribute("reg_no", rs.getString("reg_num"));
				dispatcher = request.getRequestDispatcher("student.jsp");
			}else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
