<c:if test="${not empty errors}">
	<c:forEach items="${errors}" var="error">
		${error.category} - ${error.message}<br />
	</c:forEach>
</c:if>

<form action="${pageContext.request.contextPath}/products" method="post">
  
	<c:if test="${not empty product.id}">
		<input type="hidden" name="product.id" value="${product.id}"/>
		<input type="hidden" name="_method" value="put"/>
	</c:if>

	<div class="field">
		Name:<br />
		<input type="text" name="product.name" value="${product.name}"/>
	</div>
	<div class="field">
		My flag:<br />
		<input type="text" name="product.myFlag" value="${product.myFlag}"/>
	</div>

<div class="actions">
	<button type="submit">send</button>
	</div>
</form>

<a href="${pageContext.request.contextPath}/products">Back</a>
