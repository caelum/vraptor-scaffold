<#macro checkbox name checked=false>
	<#if checked>
  		<input id="${name}" type="checkbox" name="${name}" checked/>
	<#else>
  		<input id="${name}" type="checkbox" name="${name}"/>
	</#if>  
</#macro>

<#macro text name value="">
    <input type="text" id="${name}" name="${name}" value="${value}"/>
</#macro>

<#macro textarea name value="">
    <textarea id="${name}" name="${name}" cols="40" rows="20">${value}</textarea>
</#macro>

<#macro css name>
	<link rel="stylesheet" type="text/css" href="${base}/stylesheets/${name}.css" />  
</#macro>

<#macro js name>
	<script type="text/javascript" src="${base}/javascripts/${name}.js"></script>  
</#macro>
