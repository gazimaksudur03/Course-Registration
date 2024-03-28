<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Mulish:wght@200..1000&display=swap"
     rel="stylesheet">
 
 <style>
     .font-inter {
         font-family: "Inter", sans-serif;
     }

     .font-mulish {
         font-family: "Mulish", sans-serif;
     }
     .role-container{
     	padding-bottom: 50px;
     }
     #select-role {
     	padding: 20px 10px;
     	display: inline;
     }
     #select-role button {
     	margin-top: 20px;
     	padding: 5px;
     	display: block;
     	border-radius: 5px;
     }
     .role-text{
     display: inline;
     }
 </style>
 
 
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
     integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
     crossorigin="anonymous" referrerpolicy="no-referrer" />

<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
	
	
	<!-- font  awesome -->
	 

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
</head>

<body class="font-mulish">

<input type = "hidden" id="status" value="<%= request.getAttribute("status") %>" >

	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
						
						
											
						<form method="post" action="register" class="register-form"
							id="register-form">
							
							<div class="role-container">
								<h3 class="role-text">Select your role --> </h3>
								<div id="select-role">
									<select name="role" id="role">
									  <option value="Admin">Admin</option>
									  <option value="Student">Student</option>
									  <option value="Teacher">Teacher</option>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="name" id="name" placeholder="Your Name" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="email" name="email" id="email" placeholder="Your Email" />
							</div>
							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="pass" id="pass" placeholder="Password" />
							</div>
							<div class="form-group">
								<label for="re-pass"></label>
								<input type="text" name="ureg" id="re_pass" 
									placeholder="Reg no. (if you are a student)" />
							</div>
							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="text" name="contact" id="contact"
									placeholder="Contact no" />
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="images/signup-image.jpg" alt="sing up image">
						</figure>
						<h3>I am already member as : </h3>
						<a style="padding: 5px" href="loginAdmin.jsp">Admin</a>
						<a style="padding: 5px" href="loginTeacher.jsp">Teacher</a>
						<a style="padding: 5px" href="loginStudent.jsp">Student</a>
					</div>
				</div>
			</div>
		</section>


	</div>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
		let status = document.getElementById("status").value;
		if(status === "success"){
			swal("Congrats" , "Account Created Successfully", "success");
		}
	</script>



</body>
</html>