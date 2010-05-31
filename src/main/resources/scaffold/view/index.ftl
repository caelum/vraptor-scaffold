<body>
	<table>
		<tr>
			<@generate_tds />
		</tr>
		${"<#list ${model}List as ${model}>"}
			<@generate_tds_value />
		${"</#list>"}
	</table>
</body>

<#macro generate_tds>
	<#list attributes as attribute>
		<td>${attribute.name}</td>
	</#list> 
</#macro>

<#macro generate_tds_value>
	<#list attributes as attribute>
		<td>${"$"}${"{"}${model}.${attribute.name}${"!\"\"}"}</td>
	</#list> 
</#macro>
