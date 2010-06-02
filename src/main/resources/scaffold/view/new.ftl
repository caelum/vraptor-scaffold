<form action="${"$"}${"{base}"}/${modelPlural}" method="post">
	<@generate_text />
	<input type="submit" value="save">
</form>

<#macro generate_text>
	<#list attributes as attribute>
		<input type="text" name="${model}.${attribute.name}">
	</#list> 
</#macro>
	
