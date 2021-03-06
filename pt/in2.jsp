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
var action='168';
var pb_UrlId='168';
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
                           pb.cols=[{"isSort":"false","display":getDes("id"),"name":"id","width":30,"align":"left"},{"isSort":"false",render:function(item){
return item.platform_id+$pb.edit.import_(function(){
         imp.title="选择平台编号";
         parmaMap={ 
         };  
         return pb.manager;                  
 },item.__index,"pt/in1.jsp","platform_id;name;host_name;site_code","id;name;host_name;site_code",false);
},"align":"right","width":100,"name":"platform_id","display":getDes("platform_id")},{"isSort":"false","editor":{"type":"text"},"display":getDes("name"),"name":"name","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("host_name"),"name":"host_name","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("site_code"),"name":"site_code","width":100,"align":"left"},{ display:getDes('app_qrcode'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.id,60,"app_qrcode",1,'app_qrcode'+item.__index,item);
}},{ display:getDes('logo'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.id,60,"logo",1,'logo'+item.__index,item);
}},{"isSort":"false","editor":{"type":"text"},"display":getDes("tel"),"name":"tel","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("email"),"name":"email","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("hotline"),"name":"hotline","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("title"),"name":"title","width":100,"align":"left"},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'desc',{edit:true,cols:30,rows:3}); 
 },"align":"left","width":230,"name":"desc","display":getDes("desc")}

,{"isSort":"false","editor":{"type":"text"},"display":getDes("keywords"),"name":"keywords","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("organizers"),"name":"organizers","width":100,"align":"left"},{"isSort":"false","editor":{"type":"text"},"display":getDes("recordation"),"name":"recordation","width":100,"align":"left"},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'address',{edit:true,cols:40,rows:3}); 
 },"align":"left","width":280,"name":"address","display":getDes("address")}
,{"isSort":"false","editor":{ "type":"date",format:"yyyy-MM-dd",showTime:true}, 
  render:function(item){
        return $pb.edit.date({item:item,filed:'created_at',gManage:pb.manager,format:"yyyy-MM-dd"});
  },type:"date","align":"left","width":150,"name":"created_at","display":getDes('created_at')}




,{"isSort":"false","editor":{ "type":"date",format:"yyyy-MM-dd",showTime:true}, 
  render:function(item){
        return $pb.edit.date({item:item,filed:'updated_at',gManage:pb.manager,format:"yyyy-MM-dd"});
  },type:"date","align":"left","width":150,"name":"updated_at","display":getDes('updated_at')}
];
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
$pb.Data.gridSave(pb.manager,tiketMap,"168","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
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
      $pb.Data.load(parm,tiketMap,"168",$pb.grid.pbCol(pb.getCols()),function(data){
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
			fields : [{"newline":false,"display":getDes("platform_id"),"name":"platform_id","type":"text"},{"newline":false,"name":"created_at","display":getDes("created_at"),"editor":{"type":"date",showTime:true},type:"date",validate:{required:true }},{"newline":false,"name":"updated_at","display":getDes("updated_at"),"editor":{"type":"date",showTime:true},type:"date",validate:{required:true }},{"newline":false,"display":getDes("tel"),"name":"tel","type":"text"},{"newline":false,"display":getDes("email"),"name":"email","type":"text"},{"newline":false,"display":getDes("hotline"),"name":"hotline","type":"text"},{"newline":false,"display":getDes("title"),"name":"title","type":"text"},{"newline":false,"display":getDes("desc"),"name":"desc","type":"text"},{"newline":false,"display":getDes("keywords"),"name":"keywords","type":"text"},{"newline":false,"display":getDes("organizers"),"name":"organizers","type":"text"},{"newline":false,"display":getDes("recordation"),"name":"recordation","type":"text"},{"newline":false,"display":getDes("address"),"name":"address","type":"text"}]
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
