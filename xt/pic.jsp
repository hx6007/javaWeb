<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%
    String path = request.getContextPath();
    String basePath =ItemHelper.getItemUrl(); 
    String langNo=request.getParameter("langNo");
    if(langNo==null){
       langNo="1";
    }
    String langNoC=request.getParameter("langNoC");
    if(langNoC==null){
       langNoC="1";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<script src="<%=path%>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="<%=path%>/js_/manage.js" type="text/javascript"></script> 
<script src="<%=path%>/js/Source/lib/jquery.cookie.js"></script>
<script src="<%=path%>/js/Source/lib/json2.js"></script>
<script type="text/javascript" src="https://cdn.staticfile.org/Plupload/2.1.1/plupload.full.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/md5.js"></script>
<script type="text/javascript" src="<%=path%>/js/qiniu.js"></script>
<script type="text/javascript" src="<%=path%>/js_/qiniuscript.js"></script>
<script src="<%=path%>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<link href="<%=path%>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var path="<%=path %>";
</script>
<script type="text/javascript" src="<%=path%>/js_/pic.js"></script>
</head>
<body>	
<div id="btn-upload" style="text-align:center">
    <form method="post" onsubmit="return false" enctype="multipart/form-data" id="tx_fm">
   <button id="pickfile">上传图片或者修改<br/>
	<img width="200" height="50" title="上传图片或者修改" src="<%=path%>/images/upload.jpg"/>
   </button>&nbsp;<button id='btnDelPic'>删除图片<br/><img width="200" height="50" title="删除图片" src="<%=path%>/images/Xp-G5 006.png"/></button>
   <span id="picFile"></span>
   </form>
   <div id="show"></div><div id="hidpic" style="display: none"></div>
</div>
</body>


















