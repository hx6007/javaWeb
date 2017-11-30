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
var action='135';
var pb_UrlId='135';
var category_id="";
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
      if(typeof fun =="function"){
          fun();
     } 
 }
        pb={
        		manager:null,
  noCopy:"category_id",
        		initValue:null,saveAll:function(){
var form = new liger.get("panFrom");
if(form.valid()){
$pb.Data.gridSave(pb.manager,tiketMap,"135","category_id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
}
        		},loadUrlData:function(data){
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(data){
	if(data.hasOwnProperty("pbCode")){
		if(pb.parentData){
			parmParent.panel.reLoad(data["pbCode"]);
		}else{
		   category_id=data["pbCode"];
		}
	}
}
if(category_id!=""){
parm["category_id"]=category_id;
}
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
if(count(parm)>2){
       $pb.Data.panLoad(parm,tiketMap,"135",$pb.grid.pbCol(pb_Pan.options.fields),function(data){
       	           if(data.code==0){
       				    pb_Pan.setData(data.data);                                   
                     }  
      });	
       }
$pb.panel.readOnly(pb_Pan,["category_id"]);
},creat:function(){
	if(this.creatDo==null){
    pb_Pan=$("#panFrom").ligerForm({
		inputWidth : 170,
		labelWidth : 120,
		labelAlign:"right",
        validate: true,
		space : 2
});
this.parentData=parmParent.panel.getData();
pb_Pan.setData(this.parentData);
    this.creatDo=true;
	}
   pb_Pan.set({fields :repDesJson(theFiled)});
}
 }; 
var theFiled;
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
 theFiled=[{name:"category_name",display:getDes("category_name"),type:"checkboxlist",editor:{"data":[{"id":1,"name":"李三","sex":"男"},{"id":2,"name":"李四","sex":"女"},{"id":3,"name":"赵武","sex":"女"},{"id":4,"name":"陈留","sex":"女"},{"id":5,"name":"陈留2","sex":"女"},{"id":7,"name":"陈留3","sex":"女"},{"id":6,"name":"陈留4","sex":"女"}],"textField":"name"},group:"复选框控件",groupicon:"images/group/group.gif"},{name:"category_desc",display:getDes("category_desc"),type:"text",newline:false},{name:"category_image",display:getDes("category_image"),type:"text",newline:false},{name:"category_id",display:getDes("category_id"),type:"int",group:"只读",groupicon:"images/group/group.gif"},{name:"sort_order",display:getDes("sort_order"),type:"text",newline:false},{name:"is_show",display:getDes("is_show"),type:"checkbox",newline:false},{name:"row_id",display:getDes("row_id"),type:"text",oldtype:"int"},{name:"parent_row_id",display:getDes("parent_row_id"),type:"checkbox",newline:false,group:"第一组",groupicon:"images/group/group.gif",oldtype:"text"},{name:"tree_row_id",display:getDes("tree_row_id"),type:"text",newline:false},{name:"add_time",display:getDes("add_time"),type:"text",newline:false},{name:"measure_unit",display:getDes("measure_unit"),type:"text",newline:false}];
pb.creat();
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
<div style="z-index: 1; top:0px; right:0px;position: absolute;width: 100%;">
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<span id="hidMenu" style="display: none"></span>
</div>
<div style="width: 100%; height: 90%; top:52px;overflow: auto;position: absolute;">
<form id="panFrom"></form>
</div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
