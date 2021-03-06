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
var action='148';
var pb_UrlId='148';
var reqNo="";
        var manageUrl=$pb.manageUrl;
function funNext(fun){
$pb.select.get("AskLeave",function(ask){
      if(typeof fun =="function"){
          fun();  
pb_Pan.setData({"reqUserId":user_id});        
     } 
});
 }

function tianshu(){
       var data =$pb.panel.getData(pb_Pan);
       var b=data.reqBeginDate;
       var e=data.reqEndDate;
      if(b&&e){
         var df=$pb.Date.diff(b,e);
         var t=df.day;
         var h=df.house;
         t+=(h>7)?1:(h>3)?0.5:0;
          if(t>0){
           $("[name=reqDateNum]").val(t);
        }else{
           $pb.showMess("结束时间必须大于开始时间！",1000);
           $("[name=reqEndDate]").val('');
           $("[name=reqDateNum]").val('');
        }
      }     
}
        pb={
        		manager:null,
  noCopy:"reqNo",
        		initValue:null,saveAll:function(){
var form = new liger.get("panFrom");
if(form.valid()){
$pb.Data.gridSave(pb.manager,tiketMap,"148","reqNo",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
}
        		},loadUrlData:function(data){
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(data){
	if(data.hasOwnProperty("pbCode")){
		if(pb.parentData){
			parmParent.panel.reLoad(data["pbCode"]);
		}else{
		   reqNo=data["pbCode"];
		}
	}
}
if(reqNo!=""){
parm["reqNo"]=reqNo;
}
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
if(count(parm)>2){
       $pb.Data.panLoad(parm,tiketMap,"148",$pb.grid.pbCol(pb_Pan.options.fields),function(data){
       	           if(data.code==0){
       				    pb_Pan.setData(data.data);                                   
                     }  
      });	
       }
$pb.panel.readOnly(pb_Pan,["reqNo"]);
},creat:function(){
	if(this.creatDo==null){
    pb_Pan=$("#panFrom").ligerForm({
		inputWidth : 170,
		labelWidth : 120,
		labelAlign:"right",
        validate: true,
		space : 2,
		fields :[{"newline":false,"name":"reqNo","display":getDes("reqNo")},{"newline":false,"name":"pbCode","display":getDes("pbCode"),"type":"text",edtior:{type:"text",disabled:true},disabled:true},{"newline":false,"name":"pbProccesNo","display":getDes("pbProccesNo"),"type":"text",disabled:true},{"newline":false,"name":"reqCreatDate","display":getDes("reqCreatDate"),"type":"date","editor":{"type":"date",showTime:true},dataAuto:true},{"newline":true,"name":"reqUserId","display":getDes("reqUserId"),"type":"text",validate:{required:true },disabled:true},{"newline":false,"name":"reqReason","display":getDes("reqReason"),type: 'select',options: { data: $pb.select.getObj("AskLeave").data,valueField:"sValue",valueFieldID:'text'},validate:{required:true }},{"newline":true,"name":"reqReasonMess","display":getDes("reqReasonMess"),"type":"textarea",width:752,validate:{required:true }},{"newline":true,"name":"reqBeginDate","display":getDes("reqBeginDate"),"editor":{"type":"date",showTime:true,onChangeDate: tianshu},type:"date",validate:{required:true }},{"newline":false,"name":"reqEndDate","display":getDes("reqEndDate"),"editor":{"type":"date",showTime:true,onChangeDate: tianshu},type:"date",validate:{required:true }},{"newline":false,"name":"reqDateNum","display":getDes("reqDateNum"),"type":"float",validate:{number:true }}]
});
this.parentData=parmParent.panel.getData();
pb_Pan.setData(this.parentData);
    this.creatDo=true;
	}
}
 }; 
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
loadDesNext(function(){
pb.creat();

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
