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
var action='4';
var pb_UrlId='4';
        var manageUrl=$pb.manageUrl;
var actData;
var actMap;
 function funNext(fun){
$pb.Data.select("act",function(sdate){
    if(sdate.code==0){
         actData=sdate.data;
        actMap=$pb.findMap(actData,'sValue');
   }
      if(typeof fun =="function"){
          fun();
     }
     });
 }
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"DocItem",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"DocItem","display":getDes('DocItem')},{"isSort":"false","editor":{ type: 'select', data: actData, valueColumnName: 'sValue' },render: function (item){
 if(item.ExeType==null){
  return "";
}
                        return actMap[item.ExeType][0].text;
                    },"align":"left","width":100,"name":"ExeType","display":getDes('ExeType'),value:"0"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ExeRoles","display":getDes('ExeRoles')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ExeNames","display":getDes('ExeNames')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"Conditions","display":getDes('Conditions')},{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'Source',true);},"align":"left","width":60,"name":"Source","display":getDes("Source")}];
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
$pb.Data.gridSave(pb.manager,tiketMap,action,"DocItem",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
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
      $pb.Data.load(parm,tiketMap,action,$pb.grid.pbCol(pb.getCols()),function(data){
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
			fields : [{"newline":false,"name":"DocItem","display":getDes('DocItem')},{"newline":false,"name":"ExeType","display":getDes('ExeType'),"type":"int"},{"newline":false,"name":"ExeRoles","display":getDes('ExeRoles'),"type":"text"},{"newline":false,"name":"ExeNames","display":getDes('ExeNames'),"type":"text"},{"newline":false,"name":"Conditions","display":getDes('Conditions'),"type":"text"},{"newline":false,"name":"Source","display":getDes('Source'),"type":"int"}]
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
