<head>
	<title>User [index]</title>
</head>
<body>
	<h1>Listing Users</h1>

	<table>
		<tr>
			<th>name</th>
			<th>password</th>
			<th>email</th>
			<th></th>
			<th></th>
			<th></th>
		</tr>

		<c:forEach items="${userList}" var="user">
			<tr>
				<td>${user.name}</td>
				<td>${user.password}</td>
				<td>${user.email}</td>
				<td><a href="${pageContext.request.contextPath}/users/${user.id}">show</a></td>
				<td><a href="${pageContext.request.contextPath}/users/${user.id}/edit">edit</a></td>
				<td>
					<form action="${pageContext.request.contextPath}/users/${user.id}" method="post">
						<input type="hidden" name="_method" value="delete"/>
						<button type="submit" onclick="return confirm('Are you sure?')">destroy</button>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>

	<br />
	<a href="${pageContext.request.contextPath}/users/new">New User</a> 
</body>