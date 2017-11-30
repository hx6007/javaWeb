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
var action='5';
var pb_UrlId='5';
        var manageUrl=$pb.manageUrl;
var liuNo="<%=ItemHelper.javaScriptHtml(ItemHelper.isNull(request.getParameter("no"),"").toString()) %>";
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
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"DocItem","display":getDes('DocItem')},{"isSort":"false","align":"left","width":100,"name":"processName","display":getDes("processName")},{"isSort":"false",render:function(item){   
   return item.DocCode?'<a href="'+itemPath+'Template/panel_page.jsp?no='+item.FlowNnumber+'&pbCode='+item.DocCode+'" target="_blank">'+item.DocCode+'</a>':"";
},"align":"left","width":100,"name":"DocCode","display":getDes('DocCode')},{"isSort":"false", render:function(item){
                              return $pb.edit.date({item:item,filed:'DocDate',gManage:pb.manager});
                           },type:"date","align":"left","width":150,"name":"DocDate","display":$pb.lang.readDes(langDesMap,'DocDate')},{"isSort":"false",render:function(item){
                              return $pb.edit.date({item:item,filed:'SubDate',gManage:pb.manager});
 },type:"date","align":"left","width":100,"name":"SubDate","display":getDes("SubDate")},{"isSort":"false","align":"left","width":100,"name":"FlowNnumber","display":getDes('FlowNnumber')},{"isSort":"false","align":"left","width":100,"name":"FlowStep","display":getDes('FlowStep')},{"isSort":"false","align":"left","width":100,"name":"PostName","display":getDes('PostName')},{"isSort":"false","align":"left","width":100,"name":"NextPostName","display":getDes('NextPostName')},{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'FlowOk',false);},"align":"left","width":30,"name":"FlowOk","display":getDes("FlowOk")},{"isSort":"false","align":"left","width":100,"name":"pcUrlId","display":getDes("pcUrlId")},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'okJson',{edit:false,cols:26,rows:3}); 
 },"align":"left","width":200,"name":"okJson","display":getDes("okJson")}];
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
$pb.Data.gridSave(pb.manager,tiketMap,"5","DocItem",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
     var theMap=$pb.panel.getData(pb_Pan);
     var parmMap={};
     $.each( theMap, function(i,n){
     if(n){
             if(i=="DocDate"){
              parmMap[i+" > ?"]=n+" 0";            
           }else{
             parmMap[i]=n;
           }    
     }
   });
     $pb.mergeMap(parm,parmMap);
      $pb.Data.load(parm,tiketMap,"5",$pb.grid.pbCol(pb.getCols()),function(data){
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
if(load==0){
var saveFrom='panFrom_not';
$("#panFrom1").html('<span id="'+saveFrom+'"></span>');
       pb_Pan=$("#"+saveFrom).ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
			space : 2,
			fields : [{"newline":false,"name":"DocItem","display":getDes('DocItem')},{"newline":false,"name":"DocCode","display":getDes('DocCode'),"type":"text"},{"newline":false,"name":"DocDate","display":getDes('DocDate'),"type":"date"},{"newline":false,"name":"SubDate","display":getDes('SubDate'),"type":"date"},{"newline":false,"name":"FlowNnumber","display":getDes('FlowNnumber'),"type":"text",disabled:true},{"newline":false,"name":"FlowStep","display":getDes('FlowStep'),"type":"text"},{"newline":false,"name":"PostName","display":getDes('PostName'),"type":"text"},{"newline":false,"name":"NextPostName","display":getDes('NextPostName'),"type":"text"},{"align":"left","width":30,"name":"FlowOk","display":getDes("FlowOk"),type:"checkbox"}]
	});
	var now=new Date();
	now.setDate(now.getDate()-7);
	 var obj = {   
FlowNnumber:liuNo,
DocDate:$pb.Date.formatDate(now,"yyyy-MM-dd")   
         };
	if(parmParent.isHas()){
	  parmParent.get();
          $pb.mergeMap(obj,parmParent.panelMap);
	}
         pb_Pan.setData(obj);
load=1;
}
loadDesNext(function(){
 $pb.lang.load(langNo,tiketMap,function(data){
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
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<span id="hidMenu" style="display: none"></span>
<div style="width: 100%; height: 90%; top:52px;overflow: auto;position: absolute;">
<span id="panFrom1"></span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
