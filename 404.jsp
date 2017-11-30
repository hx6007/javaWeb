<%@page import="java.util.Map"%>
<%@page import="com.util.SessionKey"%>
<%@page import="com.util.ItemHelper"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%
String path = request.getContextPath();
String basePath =ItemHelper.getItemUrl();
Map<String, Object> userMap=(Map)session.getAttribute(SessionKey.userData);
    if(userMap==null){//用户退出，重新登录
%>
<script type="text/javascript">
<!--
location.href="<%=path%>/exit.html";
//-->
</script>
<%
       return;
    }
   boolean issuper=(",1,".indexOf(","+ItemHelper.isNull(userMap.get("user_rank"), "ss")+",")!=-1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <script src="<%=path %>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
 <script src="<%=path %>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>  
 <link href="<%=path %>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<%=basePath %>/js/manage.js"></script>
<script src="<%=path %>/js/Source/lib/jquery.cookie.js"></script>
 <script src="<%=path %>/js/Source/lib/json2.js"></script>
<script>
var tiketMap=JSON2.parse($.cookie('ticketMap'));
var is_super="<%=issuper%>";
</script>
<title>404</title>
</head>
<body>
<h3>未找到相应功能页面！</h3>
</body>
</html>