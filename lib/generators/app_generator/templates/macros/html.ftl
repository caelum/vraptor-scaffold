<#macro checkbox name checked=false>
	<#if checked>
  		<input type="checkbox" name="${name}" checked/>
	<#else>
  		<input type="checkbox" name="${name}"/>
	</#if>  
</#macro>

<#macro text name value="">
    <input type="text" name="${name}" value="${value}"/>
</#macro>

<#macro css name>
	<link rel="stylesheet" type="text/css" href="${base}/stylesheets/${name}.css" />  
</#macro>

<#macro js name>
	<script type="text/javascript" src="${base}/javascripts/${name}.js"></script>  
</#macro>
