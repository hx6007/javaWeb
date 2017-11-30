<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="com.pb.xml.MessageXml"%>
<%@page import="com.pb.factory.FactoryBean"%>
<%@page import="com.pb.service.TableService"%>
<%@page import="com.util.SessionKey"%>
<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
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
    response.setHeader("Set-Cookie","cookiename=cookievalue; path=/; Domain=domainvaule; Max- age=seconds; HttpOnly");
     boolean issuper=(",1,".indexOf(","+ItemHelper.isNull(userMap.get("user_rank"), "ss")+",")!=-1);
String liuNo=StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("no")));//流程编号
if(ItemHelper.isEmpty(liuNo)){
    out.write("不确定的流程编号");
    return;
}
TableService table_Ser=(TableService)FactoryBean.getBean("table_Ser");
Map<String,Object> liuParm=new HashMap<String,Object>();
liuParm.put(MessageXml.table_pb, "pProcessMark");
liuParm.put("id", liuNo);
Map<String,Object> liuInfo=table_Ser.findRow(liuParm);
String doccode=ItemHelper.isNull(StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("pbCode"))),"").toString();//单号
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link href="<%=path%>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/js/Source//lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="<%=path%>/js/Source//lib/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="<%=path%>/js/Source//lib/ligerUI/js/plugins/ligerDrag.js"></script>
<script src="<%=path%>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<script src="<%=path%>/js_/manage.js"></script>
<script src="<%=path%>/js/Source/lib/jquery.cookie.js"></script>
<script src="<%=path%>/js/Source/lib/json2.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/favicon.ico" />
<title><%=liuInfo.get("processName") %></title>
<script type="text/javascript">
var is_super="<%=issuper%>"; <% //是否超级管理员%>
var user_id="<%=userMap.get("user_id").toString()%>";<% // 当前用户的编号 %>
var roleIds="<%=userMap.get("roleIds").toString()%>";<% // 当前用户的部门角色编号 %>
var liuNo="<%=liuNo%>";<% // 流程编号 %>
var doccode="<%=doccode%>"; <% //单号 暂 与 pbCode 等同 %>
var path="<%=path%>/";<% // 项目相对路径 %>
</script>
<script src="<%=path%>/js_/process.js"></script>
</head>
<body style="padding:0px">
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<div style="width:98%;" id="portalMain"></div>
</body>
</html>