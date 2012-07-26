<#if errors??>
	<#list errors as error>
		 ${error.category} - ${error.message}<br />
	</#list>
</#if>

<form action="${base}/products" method="post">
  
  <#if product.id??>
    <input type="hidden" name="product.id" value="${product.id}"/>
    <input type="hidden" name="_method" value="put"/>
  </#if>

  <div class="field">
    Name:<br />
	
    <@html.text "product.name" product.name/>
  </div>
  <div class="field">
    My flag:<br />
	
    <@html.checkbox "product.myFlag" product.myFlag/>
  </div>
  <div class="field">
    Price:<br />
	
    <@html.text "product.price" product.price/>
  </div>
  <div class="field">
    Category:<br />
    <select name="product.category.id">
	  	<#list categoryList as category>
				<option value="${category.id}" <#if product.category?? && product.category.id == category.id>selected="true"</#if> >${category.id}</option>
	  	</#list>
    </select>
  </div>
  <div class="actions">
    <button type="submit">send</button>
  </div>
</form>

<a href="${base}/products">Back</a>

