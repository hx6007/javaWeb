<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="java.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<HTML>
<head>
<title>上传数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="jquery-2.1.4.min.js"></script>
</head>
<script language="javascript" type="text/javascript">
function tijiao(id){
  if(confirm("确认信息，是否提交？")){
  var fd = new FormData(document.getElementById("upFrame"));
  		$.ajax({
			type: "post",			
             headers: {         
                       "ticket":'e895482e-7662-4aa1-bdc7-a6fb3e806ccd'
                   },
  /*beforeSend: function(jqXHR, settings) {
            jqXHR.setRequestHeader("ticket",'780b18cd-19d2-4d63-a8f5-dcd4cd717ee4');              
        },*/
			url: "<%=path%>/item.do?m=up",
			async: false,  
          	cache: false,  
			data:fd,
			dataType:"text",
			 processData: false,  // 告诉jQuery不要去处理发送的数据
            contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
			success: function(data){
		    	alert(data);
			},error: function(data){
   				alert("错误"+data.message);
			}
		});
  }
}

function dd(){
$.ajax(
{ url: "<%=path%>/file/upload.jsp", 
context: document.getElementById('upFrame2'), 
success: function(data){
    $(data);
}});
}
</script>

<BODY BGCOLOR="white">
<div style="width:900px; height:600px;" align="center">
<h1>数据提交</h1>
<HR>
<FORM id="upFrame" name="upFrame" METHOD="POST"  ACTION="<%=path%>/item.do?m=up" ENCTYPE="multipart/form-data">
<table>
  <tr>
    <td width="120" height="24" align="right">上传文件：</td>
    <td valign="middle"><INPUT TYPE="FILE" NAME="FILE1" SIZE="20"></td>
  </tr>
  <tr>
    <td height="24" align="right"><input type="button" value="提交" onclick="tijiao('upFrame')"><input type="submit" value="直接提交表单"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</FORM>
直接提交
<FORM id="upFrame1" name="upFrame1" METHOD="POST"  ACTION="<%=path%>/item.do?m=up&php=php" ENCTYPE="multipart/form-data">
<table>
  <tr>
    <td width="120" height="24" align="right">上传文件：</td>
    <td valign="middle"><INPUT TYPE="FILE" NAME="FILE1" SIZE="20"></td>
  </tr>
  <tr>
    <td height="24" align="right"><input type="button" value="js提交" onclick="dd()"><input type="submit" value="直接提交表单"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</FORM>
dfdf
                <form id="upFrame2" name="upFrame2" action="upload.jsp" method="post" enctype="multipart/form-data">    
        <input type="file" name="upload" >    
       <input type="button" value="js提交" onclick="dd()">
                </form>   
</div>
</BODY>
</HTML>
