<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="com.util.ItemHelper"%>
<%@page import="com.util.SessionKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%
    String path = request.getContextPath();
    String basePath =ItemHelper.getItemUrl(); 
    response.setHeader("Set-Cookie","cookiename=cookievalue; path=/; Domain=domainvaule; Max- age=seconds; HttpOnly");
    String langNo=ItemHelper.javaScriptHtml(request.getParameter("langNo"));
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
    if(langNo==null){
       langNo=ItemHelper.isNull(userMap.get("lNo"), "1").toString();
    }
    String langNoC=ItemHelper.javaScriptHtml(request.getParameter("langNoC"));
    if(langNoC==null){
       langNoC=ItemHelper.isNull(userMap.get("lNoC"), "1").toString();
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<link href="<%=path%>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/js/Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="<%=path%>/js/Source/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" id="mylink"/>
<script src="<%=path%>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<script src="<%=path%>/js/manage.js" type="text/javascript"></script>  
<script src="<%=path%>/js/Source/lib/jquery.cookie.js"></script>
<script src="<%=path%>/js/Source/lib/json2.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.metadata.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/messages_cn.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/favicon.ico" />
<style type="text/css">
.back_{
  background-color:#EAF3FC;
}
</style>
<script type="text/javascript"> 
var is_super="<%=issuper%>";
var user_id="<%=userMap.get("user_id").toString()%>";
</script>
    <script type="text/javascript"> 
        var tiketMap=JSON2.parse($.cookie('ticketMap'));
        var langNo="<%=langNo%>";
        var langNoC="<%=langNoC%>";
var langDesMap;
var action='91';
var pb_UrlId='91';
var ReportID="";
        var manageUrl=$pb.manageUrl;
        <%
        String ReportID=ItemHelper.isNull(StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("ReportID"))),"").toString();
         %>
 var ReportID="<%=ReportID %>";
var printData=[{"name":"rtf"},{"name":"xls"},{"name":"pdf"},{"name":"html"},{"name":"flash"}];
        pb={
        		manager:null,
  noCopy:"ReportID",
        		initValue:null,saveAll:function(){
var form = new liger.get("panFrom");
if(form.valid()){
$pb.Data.gridSave(pb.manager,tiketMap,"91","ReportID",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
}
        		},loadUrlData:function(){
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(ReportID!=""){
parm["ReportID"]=ReportID;
}
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
if(count(parm)>2){
       $pb.Data.panLoad(parm,tiketMap,"91",$pb.grid.pbCol(pb_Pan.options.fields),function(data){
       	           if(data.code==0){
       				    pb_Pan.setData(data.data);                                   
                     }  
      });	
       }
pb_Pan.setEnabled("ReportID",false);
}
 }; 
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
       pb_Pan=$("#panFrom").ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
validate: true,
			space : 2,
			fields : [{"newline":false,"name":"ReportID","display":getDes('ReportID')},{"newline":false,"name":"urlId","display":getDes('urlId'),"type":"text"},{"newline":false,"name":"OriginalFleName","display":getDes('OriginalFleName'),"type":"text"},{"newline":false,"name":"PhysicalFileName","display":getDes('PhysicalFileName'),"type":"text"},{"newline":false,"name":"ParentReportID","display":getDes('ParentReportID'),"type":"text"},{"newline":false,"name":"OutFarmat","display":getDes('OutFarmat'),"type":"checkboxlist","editor":{"textField":"name","valueField":"name","data":printData}},{"newline":false,"name":"DefaultOutFarmat","display":getDes('DefaultOutFarmat'),"type":"radiolist","editor":{"textField":"name","valueField":"name","data":printData}},{"newline":false,"name":"Owner","display":getDes('Owner'),"type":"text"},{"newline":false,"name":"CreateTime","display":getDes('CreateTime'),"type":"text"},{"newline":false,"name":"ModifiedMan","display":getDes('ModifiedMan'),"type":"text"},{"newline":false,"name":"LastModified","display":getDes('LastModified'),"type":"text"},{"newline":false,"name":"CurVer","display":getDes('CurVer'),"type":"text",validate:{required:true }},{"newline":false,"name":"ReportName","display":getDes('ReportName'),"type":"text"},{"newline":false,"name":"ReportBinFile","display":getDes('ReportBinFile'),"type":"text"}]
	});
loadDesNext(function(){
         pb.loadUrlData();
        $pb.lang.load(langNo,tiketMap,loadMenu);     
});   
    });           
} 
function loadLang(){

}  
    </script>
</head>
<body  style="padding:0px;margin:0px;overflow-y: hidden;">
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<span id="hidMenu" style="display: none"></span>
<div style="width: 100%; height: 90%; top:52px;overflow: auto;position: absolute;">
<form id="panFrom"></form>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
