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

<#macro option value text="" selected=false>
    <option value="${value}"<#if selected>selected="true"</#if> >${text}</option>
</#macro>

<#macro select name values check>
    <select name="${name}">
	  	<#list values as obj>
	  		<#nested obj, check==obj.id>
	  	</#list>
    </select>
</#macro>

<#macro css name>
	<link rel="stylesheet" type="text/css" href="${base}/stylesheets/${name}.css" />  
</#macro>

<#macro js name>
	<script type="text/javascript" src="${base}/javascripts/${name}.js"></script>  
</#macro>
