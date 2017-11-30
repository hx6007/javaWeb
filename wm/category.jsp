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
<script src="<%=path%>/js/Source/lib/jquery.cookie.js"></script>
<script src="<%=path%>/js/Source/lib/json2.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.metadata.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/messages_cn.js"></script>
<script src="<%=path%>/js_/manage.js" type="text/javascript"></script>  
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
var action='171';
var pb_UrlId='171';
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
  noCopy:"category_code",
                        refField:{},
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"category_code","display":getDes("category_code"),hide:"true"},{"isSort":"false",id:"id1","editor":{"type":"text"},"align":"left","width":200,"name":"name","display":getDes("name")},{ display:getDes('picture'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.category_code,64,"picture_code",6,'category_code'+item.__index,item);
}},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"parent_code","display":getDes("parent_code")}];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
var row = pb.manager.getSelectedRow();
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    if(row){
        		        pb.initValue["parent_code"]=row["category_code"];        		     
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
   //  $pb.mergeArray(toolBar,morenToobarList);
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar },
        	                enabledEdit: true,isScroll: false,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,
                                tree: { columnId: 'id1' },    
        	                width: '98%' 
        	            };
 if(parmParent.isHas()&&parmParent.checkbox){
        	               $pb.mergeMap(gridInfo,parmParent.checkbox);
        	            }
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"171","category_code",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
$(["nextOk","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
      $pb.Data.load(parm,tiketMap,"171",$pb.grid.pbCol(pb.getCols()),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){        				  
        				gridData.Rows=$pb.findTreeMap(data.data,'category_code','parent_code');
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
<div style="z-index: 1; top:0px; right:0px;position: absolute;width: 100%;">
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<span id="hidMenu" style="display: none"></span>
</div>
<div style="width: 100%; height: 90%; top:52px;overflow: auto;position: absolute;">
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</div>
</body>
</html>
<script src="<%=path%>/js_/menu_.js" type="text/javascript"></script>  
