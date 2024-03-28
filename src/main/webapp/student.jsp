<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("registration.jsp");
	}
%>

<%@page import="com.Db.*" %>
<%@page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>University Course Registration</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/index-styles.css" rel="stylesheet" />
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container space-between">
			<a class="navbar-brand" href="#page-top">Student panel</a>
			<button
				class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">Enrolled</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead bg-primary text-white text-center">
		<div class="container d-flex align-items-center flex-column">
			<!-- Masthead Avatar Image-->
			<img class="masthead-avatar mb-5" src="assets/img/avataaars.svg"
				alt="..." />
			<!-- Masthead Heading-->
			<h1 class="masthead-heading text-uppercase mb-0">Hello <%=session.getAttribute("name") %> !!!</h1>
			<h2 class="masthead-heading text-uppercase mb-0 pt-5"><%=session.getAttribute("reg_no") %></h2>
			<!-- Icon Divider-->
			<div class="divider-custom divider-light">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
		</div>
	</header>
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="portfolio">
		<div class="container">
			<!-- Portfolio Section Heading-->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">Your Courses</h2>
			<!-- Icon Divider-->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">#Enrolled Course</th>
			      <th scope="col">Title</th>
			      <th scope="col">Instructor</th>
			      <th scope="col">Instructor_contacts</th>
			      <th scope="col">Credits</th>
			    </tr>
			  </thead>
			  <tbody>
			    <% 
			    	String str = session.getAttribute("reg_no").toString();
		            try {
		                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_reg?useSSL=false","root","");
		                Statement stmt = conn.createStatement();
		                String sql = "SELECT c.course_id , course_title, t.uname AS instructor, t.umobile AS contacts, credits " +
		                        "FROM courses c " +
		                        "JOIN teachers t ON c.instructor_id = t.id " +
		                        "WHERE course_id IN (" +
		                        "    SELECT course_id " +
		                        "    FROM takes " +
		                        "    WHERE std_reg = '"+str+ "' "+
		                        ")";
		                ResultSet rs = stmt.executeQuery(sql);
		                while (rs.next()) {
		                    out.println("<tr>");
		                    out.println("<td>" + rs.getString("course_id") + "</td>");
		                    out.println("<td>" + rs.getString("course_title") + "</td>");
		                    out.println("<td>" + rs.getString("instructor") + "</td>");
		                    out.println("<td>" + rs.getString("contacts") + "</td>");
		                    out.println("<td>" + rs.getInt("credits") + "</td>");
		                    out.println("</tr>");
		                }
		                rs.close();
		                stmt.close();
		                conn.close();
		            } catch (SQLException e) {
		                out.println("Database error: " + e.getMessage());
		            }
		        %>
			  </tbody>
			</table>
		</div>
	</section>
	
	
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="portfolio">
		<div class="container">
			<!-- Portfolio Section Heading-->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">Available Courses Table</h2>
			<!-- Icon Divider-->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">#Course ID</th>
			      <th scope="col">Title</th>
			      <th scope="col">Credits</th>
			      <th scope="col">Type</th>
			      <th scope="col">Instructor ID</th>
			    </tr>
			  </thead>
			  <tbody>
			    <% 
		            try {
		                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_reg?useSSL=false","root","");
		                Statement stmt = conn.createStatement();
		                ResultSet rs = stmt.executeQuery("SELECT * FROM courses");
		                while (rs.next()) {
		                    out.println("<tr>");
		                    out.println("<td>" + rs.getString("course_id") + "</td>");
		                    out.println("<td>" + rs.getString("course_title") + "</td>");
		                    out.println("<td>" + rs.getInt("credits") + "</td>");
		                    out.println("<td>" + rs.getString("type") + "</td>");
		                    out.println("<td>" + rs.getInt("instructor_id") + "</td>");
		                    out.println("</tr>");
		                }
		                rs.close();
		                stmt.close();
		                conn.close();
		            } catch (SQLException e) {
		                out.println("Database error: " + e.getMessage());
		            }
		        %>
			  </tbody>
			</table>
		</div>
	</section>
	
	
	
	
	
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="contact">
		<div class="container">
			<!-- Portfolio Section Heading-->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">Enroll New Course</h2>
			<!-- Icon Divider-->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xl-7">
					<!-- * * * * * * * * * * * * * * *-->
					<!-- * * SB Forms Contact Form * *-->
					<!-- * * * * * * * * * * * * * * *-->
					<!-- This form is pre-integrated with SB Forms.-->
					<!-- To make this form functional, sign up at-->
					<!-- https://startbootstrap.com/solution/contact-forms-->
					<!-- to get an API token!-->
					<form id="contactForm" class="register-form" data-sb-form-api-token="API_TOKEN" action="student" method="post">
						<!-- Name input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="name" type="text" name="cID"
								placeholder="CSE-133" data-sb-validations="required" />
							<label for="name">Course ID</label>
							<div class="invalid-feedback" data-sb-feedback="name:required">A
								Course ID is required.</div>
						</div>
						<!-- Email address input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="email" type="text" name="reg_no"
								placeholder="Stuctured Programming"
								data-sb-validations="required" /> <label for="email">Reg No.</label>
							<div class="invalid-feedback" data-sb-feedback="email:required">Your Reg No is required.</div>
						
						<div class="form-group form-button mt-40">
								<input type="submit" name="enroll" id="register"
									class="form-submit" value="Enroll Course" />
							</div>
					</form>
				</div>
			</div>

		</div>
	</section>
	
	
	
	<!-- Footer-->
	<footer class="footer text-center">
		<div class="container">
			<div class="row">
				<!-- Footer Location-->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Location</h4>
					<p class="lead mb-0">
						Akhalia, Sylhet Sadar <br /> Bangladesh
					</p>
				</div>
				<!-- Footer Social Icons-->
				<div class="col-lg-4 mb-5 mb-lg-0">
					<h4 class="text-uppercase mb-4">Around the Web</h4>
					<a class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-facebook-f"></i></a> <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-twitter"></i></a> <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-linkedin-in"></i></a> <a
						class="btn btn-outline-light btn-social mx-1" href="#!"><i
						class="fab fa-fw fa-dribbble"></i></a>
				</div>
				<!-- Footer About Text-->
				<div class="col-lg-4">
					<h4 class="text-uppercase mb-4">About Course Registration</h4>
					<p class="lead mb-0">
						This is a computarized system to tract off the students registration</br> for their courses and teachers of their assigned courses.
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; My Website 2024</small>
		</div>
	</div>
	
	
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
