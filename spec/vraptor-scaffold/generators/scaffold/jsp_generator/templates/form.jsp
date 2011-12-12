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
	
	<div class="field">
		Price:<br />
	
		<input type="text" name="product.price" value="${product.price}"/>
	</div>
	
	<div class="field">
		Category:<br />
		<select name="product.category.id">
		  <c:forEach var="category" items="${categoryList}">
		    <option value="${category.id}" <c:if test = "${product.category.id == category.id}">selected="true"</c:if>>
		      ${category.id}
			</option>
		  </c:forEach>
		</select>
	</div>
	
  <div class="actions">
	  <button type="submit">send</button>
	</div>
</form>

<a href="${pageContext.request.contextPath}/products">Back</a>
