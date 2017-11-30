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
var action='10';
var pb_UrlId='10';
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
  noCopy:"id",
                        refField:{},
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"comName","display":getDes('comName')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pName","display":getDes('pName'),id:"id1"},{"isSort":"false","align":"left","width":100,"name":"parentId","display":getDes('parentId'),render:function(item){
                                return $pb.isNull(item.pName,"")+$pb.edit.import_('pb.manager',item.__index,"xt/bm/b.jsp","parentId","pId",false);
                           }},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pUserNum","display":getDes('pUserNum'),totalSummary: { type: 'sum,max'}},{"isSort":"false","align":"left","width":100,"name":"companyId","display":getDes('companyId'),render:function(item){
                                return item.companyId+$pb.edit.import_('pb.manager',item.__index,"xt/pt/gs.jsp","companyId;num;comName;pComId","pComId;num;comName;pComId",false);
                           }},{"isSort":"false","align":"left","width":100,"name":"pId","display":getDes('pId')},{"isSort":"false","align":"left","width":100,"name":"num","display":getDes('num')},{ display:$pb.lang.readDes(langDesMap,'bmPic'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.pId,4,"bmPic",4,'bmPic2'+item.__index);
}}];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
var row = pb.manager.getSelectedRow();
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    if(row){
        		        pb.initValue["parentId"]=row["pId"];        		     
        		   }
        		     if (pb.manager.isLeaf(row)){
		               row.children=[];
		            }
		            pb.manager.add($pb.clone(pb.initValue), null, true, row);        	
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},theGridData:null
,f_initGrid:function(gridData,gridId){
   pb.theGridData=gridData;
   var toolBar=[{ text:getDes('高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ text:getDes('收缩全部'), click: function(){pb.manager.collapseAll();}, icon: 'refresh' }
          ,{ line: true }];
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar },
        	                enabledEdit: true,isScroll: false,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:60,
                                tree: { columnId: 'id1' },    
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"10","id",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
      $pb.Data.load(parm,tiketMap,"10",$pb.grid.pbCol(pb.getCols()),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){        				  
        				gridData.Rows=$pb.findTreeMap(data.data,'pId','parentId');
        				gridData.Total=gridData.Rows.length;
                                        pb.gridData=gridData;		   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      });	
       } }; 
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
loadDesNext(function(){
        $pb.lang.load(langNo,tiketMap,function(data){loadMenu(data);
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
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
