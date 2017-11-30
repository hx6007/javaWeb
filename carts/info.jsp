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
var action='176';
var pb_UrlId='176';
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
      if(typeof fun =="function"){
          fun();
     } 
 }
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"id",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","display":getDes("id"),"name":"id","width":30,"align":"left"},{"isSort":"false","display":getDes("platform_id"),"name":"platform_id","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("user_id"),"name":"user_id","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("sku_id"),"name":"sku_id","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("warehouse"),"name":"warehouse","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("goods_name"),"name":"goods_name","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("goods_thumb"),"name":"goods_thumb","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("face_price"),"name":"face_price","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("price"),"name":"price","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("count"),"name":"count","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("created_at"),"name":"created_at","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("updated_at"),"name":"updated_at","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("grades"),"name":"grades","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("unit"),"name":"unit","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("order_id"),"name":"order_id","width":100,"align":"left"}];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    pb.manager.addRow($pb.clone(pb.initValue));
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},theGridData:null
,f_initGrid:function(gridData,gridId){
   pb.theGridData=gridData;
   var toolBar=[{ text:getDes('高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ line: true }];
     //$pb.mergeArray(toolBar,morenToobarList);
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar},
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,
        	                width: '98%',height:"96%"//isScroll: false,
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"176","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
     var theMap=pb_Pan.getData();
     var parmMap={};
     $.each( theMap, function(i,n){
     if(!$.isEmptyObject(n)){
             parmMap[i]=n;       
     }
   });
     $pb.mergeMap(parm,parmMap);
      $pb.Data.load(parm,tiketMap,"176",$pb.grid.pbCol(pb.getCols()),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      });	
       } };  
var load=0;
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;

loadDesNext(function(){
 $pb.lang.load(langNo,tiketMap,function(data){
if(load==0){
var saveFrom='panFrom_not';
$("#panFrom1").html('<span id="'+saveFrom+'"></span>');
       pb_Pan=$("#"+saveFrom).ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
			space : 2,
			fields : [{"newline":false,"display":getDes("platform_id"),"name":"platform_id","type":"text"},{"newline":false,"display":getDes("user_id"),"name":"user_id","type":"text"},{"newline":false,"display":getDes("sku_id"),"name":"sku_id","type":"text"},{"newline":false,"display":getDes("warehouse"),"name":"warehouse","type":"text"},{"newline":false,"display":getDes("goods_name"),"name":"goods_name","type":"text"},{"newline":false,"display":getDes("goods_thumb"),"name":"goods_thumb","type":"text"},{"newline":false,"display":getDes("face_price"),"name":"face_price","type":"text"},{"newline":false,"display":getDes("price"),"name":"price","type":"text"},{"newline":false,"display":getDes("count"),"name":"count","type":"text"},{"newline":false,"display":getDes("created_at"),"name":"created_at","type":"text"},{"newline":false,"display":getDes("updated_at"),"name":"updated_at","type":"text"},{"newline":false,"display":getDes("grades"),"name":"grades","type":"text"},{"newline":false,"display":getDes("unit"),"name":"unit","type":"text"},{"newline":false,"display":getDes("order_id"),"name":"order_id","type":"text"}]
	});
	 var obj = {           
         };
	if(parmParent.isHas()){
	  parmParent.get();
          $pb.mergeMap(obj,parmParent.panelMap);
	}
         pb_Pan.setData(obj);
load=1;
}
loadMenu(data);
pb.loadUrlData();
});
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
<span id="panFrom1"></span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
