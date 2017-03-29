<%-- 
    Document   : template
    Created on : Mar 26, 2017, 8:26:18 PM
    Author     : Tim Lansing

    Code was borrowed from "http://stackoverflow.com/questions/10529963/what-is-the-best-way-to-create-jsp-layout-template".
--%>

<%@tag description="Generic template for all but the login page." pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="message"%>

<%-- any content can be specified here e.g.: --%>
<h2>${message}</h2>

<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>JCrisis Hotline</title>
        <link rel="stylesheet" href="css/standard_style.css" />
        <link rel="stylesheet" href="css/normalize.css" />
        <script src="javascript/standard_script.js"></script>
        <script src="javascript/jquery-3.2.0.min.js"></script>
    </head>
    <body>
        <div id="pageheader">
            <jsp:include page="/includes/pagetop.html" />
            <jsp:include page="/includes/nav.html" />
        </div>
        <div id="body">
            <jsp:doBody/>
        </div>
        <div id="pagefooter">
            <jsp:include page="/includes/pagebottom.html" />
        </div>
    </body>
</html>