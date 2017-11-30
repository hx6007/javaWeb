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
var action='96';
var pb_UrlId='96';
var DocCode="";
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
      if(typeof fun =="function"){
          fun();
     } 
 }
        pb={
        		manager:null,
  noCopy:"DocCode",
        		initValue:null,saveAll:function(){
var form = new liger.get("panFrom");
if(form.valid()){
$pb.Data.gridSave(pb.manager,tiketMap,"96","DocCode",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
}
        		},loadUrlData:function(){
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(DocCode!=""){
parm["DocCode"]=DocCode;
}
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
if(count(parm)>2){
       $pb.Data.panLoad(parm,tiketMap,"96",$pb.grid.pbCol(pb_Pan.options.fields),function(data){
       	           if(data.code==0){
       				    pb_Pan.setData(data.data);                                   
                     }  
      });	
       }
pb_Pan.setEnabled("DocCode",false);
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
			fields : [{"newline":false,"name":"DocCode","display":getDes('DocCode')},{"newline":false,"name":"FormID","display":getDes('FormID'),"type":"int"},{"newline":false,"name":"DocDate","display":getDes('DocDate'),"type":"text"},{"newline":false,"name":"PeriodID","display":getDes('PeriodID'),"type":"text"},{"newline":false,"name":"CreateCode","display":getDes('CreateCode'),"type":"text"},{"newline":false,"name":"CreateName","display":getDes('CreateName'),"type":"text"},{"newline":false,"name":"RefCode","display":getDes('RefCode'),"type":"text"},{"newline":false,"name":"ApplyJob","display":getDes('ApplyJob'),"type":"text"},{"newline":false,"name":"Aapplicant","display":getDes('Aapplicant'),"type":"text"},{"newline":false,"name":"Age","display":getDes('Age'),"type":"int"},{"newline":false,"name":"Gender","display":getDes('Gender'),"type":"text"},{"newline":false,"name":"Education","display":getDes('Education'),"type":"text"},{"newline":false,"name":"NativePlace","display":getDes('NativePlace'),"type":"text"},{"newline":false,"name":"TelPhone","display":getDes('TelPhone'),"type":"text"},{"newline":false,"name":"Source","display":getDes('Source'),"type":"text"},{"newline":false,"name":"InterviewTime","display":getDes('InterviewTime'),"type":"text"},{"newline":false,"name":"Remarks","display":getDes('Remarks'),"type":"text"},{"newline":false,"name":"DocType","display":getDes('DocType'),"type":"text"},{"newline":false,"name":"DocStatus","display":getDes('DocStatus'),"type":"int"},{"newline":false,"name":"DocStatusName","display":getDes('DocStatusName'),"type":"text"},{"newline":false,"name":"ComanyId","display":getDes('ComanyId'),"type":"text"},{"newline":false,"name":"ComanyName","display":getDes('ComanyName'),"type":"text"},{"newline":false,"name":"ModifyName","display":getDes('ModifyName'),"type":"text"},{"newline":false,"name":"ModifyDate","display":getDes('ModifyDate'),"type":"text"},{"newline":false,"name":"CheckerCode","display":getDes('CheckerCode'),"type":"text"},{"newline":false,"name":"CheckerName","display":getDes('CheckerName'),"type":"text"},{"newline":false,"name":"Blscrap","display":getDes('Blscrap'),"type":"text"},{"newline":false,"name":"PrintNum","display":getDes('PrintNum'),"type":"int"},{"newline":false,"name":"LastprintFormid","display":getDes('LastprintFormid'),"type":"int"},{"newline":false,"name":"LastprintDocstatus","display":getDes('LastprintDocstatus'),"type":"text"},{"newline":false,"name":"PostValues","display":getDes('PostValues'),"type":"text"},{"newline":false,"name":"PostName","display":getDes('PostName'),"type":"text"},{"newline":false,"name":"PostDate","display":getDes('PostDate'),"type":"text"}]
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
