<#macro checkbox name checked=false>
	<#if checked>
  		<input type="checkbox" name="${name}" checked>
	<#else>
  		<input type="checkbox" name="${name}">
	</#if>  
</#macro>

<#macro text name value="">
    <input type="text" name="${name}" value="${value}">
</#macro>
