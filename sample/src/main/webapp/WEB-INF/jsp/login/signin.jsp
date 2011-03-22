<head>
	<title>Signin</title>
</head>
<body>
	<form action="/signin" method="post">
		<div class="field">
			E-mail: <br />
			<input type="text" name="user.email" value="${user.email}"/>
		</div>
		<div class="field">
			Password: <br />
			<input type="text" name="user.password" />
		</div>
    	<input type="submit" value="Sign In"/>
	</form>
</body>
