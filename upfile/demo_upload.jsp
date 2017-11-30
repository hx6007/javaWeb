<%@ page contentType="text/html;charset=utf-8"%>
<%

//得到URL
String path = request.getContextPath();
String URL = (request.getRequestURL() + "").replace(request
			.getRequestURI(), "")
			+ path;
int fileSize=999999999;
String fileType="*.jpg";//"*.amr";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <link href="<%=URL%>/js/jqueryUpload/css/uploadify.css" rel="stylesheet" type="text/css" />
		<link href="<%=URL%>/js/jqueryUpload/css/default.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=URL%>/js/jquery-1.8.2.js"></script>
		<script type="text/javascript" src="<%=URL%>/js/jqueryUpload/scripts/swfobject.js"></script>
		<script type="text/javascript" src="<%=URL%>/js/jqueryUpload/scripts/jquery.uploadify.v2.1.0.min.js"></script>
		
		<script type="text/javascript" src="https://cdn.staticfile.org/Plupload/2.1.1/plupload.full.min.js"></script>
		<script type="text/javascript" src="<%=URL%>/js/md5.js"></script>
		<script type="text/javascript" src="<%=URL%>/js/qiniu.js"></script>
		<script type="text/javascript" src="<%=URL%>/js/qiniuscript.js"></script>
		<script type="text/javascript">
			var fileSize = <%=fileSize %>;
			var fileType = "<%=fileType %>";
			var path="<%=path%>";
			var zdr="";
			function ch(){
			   zdr=$("#zdr").val();
			}
		</script>
		<script type="text/javascript" src="<%=URL%>/js/jqueryUpload/upload_pb.js"></script>
	</head>
	<script type="text/javascript">
$(function() {
    uploader.browse_button = 'pickfiles';//上传按钮的ID
    uploader.container = 'btn-uploader';//上传按钮的上级元素ID
	var auploader = Qiniu.uploader(uploader);
});
</script>
	<body bgcolor="white">
	<div style="left: 20px;top: 20px;">
		<div style="height: 35px;font-size: 18px;font-weight: bold;line-height: 35px;vertical-align: middle;">
			附件上传
		</div>
		<div id="fileQueue" style="left: 0px;top: 35px;"></div>
		<p style="left: 0px;top: 255px;">
		    <div>上传人：<input type="text" value="" id="zdr" onChange="ch()"/></div><br />
			<input style="display: none;" type="file" name="fileupload" id="fileupload" />
			<button id="up" onclick="resetScriptDate();" style="text-align:center; height: 30px;font-weight: bold;color: white;line-height: 30px;width: 80px;vertical-align: top;font-weight: bold;background-image: url('<%=URL%>/images/upload_a.gif');cursor: pointer;">
			上传
			</button>
			<button onclick="jQuery('#fileupload').uploadifyClearQueue();" style="font-size:14px;font-weight: bold;color: white;margin-left:5px;text-align:center; height: 30px;line-height: 30px;width: 80px;vertical-align: top;font-weight: bold;background-image: url('<%=URL%>/images/upload_a.gif');cursor: pointer;">
			取消上传
			</button>
			<% // <a href="javascript:clearUploadInfo();">清除上传信息</a> %>
		<p />
		<div id="btn-uploader">
		    <a id="pickfiles" href="javascript:void 0;">Upload File</a>
		</div>
	</div>
	</body>
</html>