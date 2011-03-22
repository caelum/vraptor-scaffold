<head>
	<title>User [show]</title>
</head>
<body>
	<p>
		<b>Name:</b>
		${user.name}
	</p>
	<p>
		<b>Password:</b>
		${user.password}
	</p>
	<p>
		<b>Email:</b>
		${user.email}
	</p>

	<a href="${pageContext.request.contextPath}/users/${user.id}/edit">Edit</a>
	<a href="${pageContext.request.contextPath}/users">Back</a>
</body>