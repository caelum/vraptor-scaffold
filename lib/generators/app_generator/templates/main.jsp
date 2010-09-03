<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title><decorator:title default="Vraptor Scaffold"/></title>
        <link rel="stylesheet" type="text/css" href="<c:url value="/stylesheets/scaffold.css"/>" />  
        <decorator:head/>
    </head>
    <body>
        <decorator:body/>
        <script type="text/javascript" src="<c:url value="/javascripts/jquery-1.4.2.min.js"/>"></script>
    </body>
</html>
