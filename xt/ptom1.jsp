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
var action='/xt/psee.do';
var pb_UrlId='7';
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
                           pb.cols=[{"isSort":"false",id:"id1","align":"left","width":200,"name":"text","display":getDes("text")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"url","display":getDes("url")},{"isSort":"false","align":"left","width":100,"name":"id","display":getDes("id"),hide:"true"},{"isSort":"false","editor":{"type":"int"},"align":"left","width":100,"name":"parentId","display":getDes("parentId"),hide:"true"},{"isSort":"false","align":"left","width":100,"name":"sId","display":getDes("sId")},{"isSort":"false",render: function (item){
if(hasUser()){
return $pb.edit.checkEdit(function(){return pb.manager;},item,'notsee_userId',true,function(ck){
ckeckFun(!ck,item.__index);
});
}
},"align":"left","width":100,"name":"notsee_userId","display":getDes('notsee_userId')},{"isSort":"false",render: function (item){
if(hasUser()){return "";}
return $pb.edit.checkEdit('pb.manager',item,'rId',true,function(ck){
var rid=$("#rId").val();
if(rid!=""){
	if(ck){
	  $pb.tree.gridCheck(function(){  return pb.manager; }, "rId",rid,item.__index, ck,false);
	}else{
	  $pb.tree.gridCheck(function(){ return pb.manager; }, "rId","p_"+rid,item.__index,ck,true);
    }
}
});
 },"align":"left","width":100,"name":"rId","display":getDes('rId')
},{"isSort":"false",render: function (item){
if(hasUser()){
return $pb.edit.checkEdit(function(){return pb.manager;},item,'see_userId',true,function(ck){
ckeckFun(ck,item.__index);
});
}
},"align":"left","width":100,"name":"see_userId","display":getDes('see_userId')}];
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
          ,{ text:getDes('收缩全部'), click: function(){pb.manager.collapseAll();}, icon: 'refresh' }
          ,{ line: true }];
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar },
        	                enabledEdit: true,isScroll: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,headerRowHeight:40,
                                tree: { columnId: 'id1' },    
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
var parm=$pb.lang.getlangMap(langNo,langNoC);
parm['user_id']=$("#user_id").val();
parm['rid']=$('#rId').val();
$pb.Data.gridSave(pb.manager,tiketMap,"xt/psee.do","id",function(){
	$pb.DoUrl($pb.manageUrl+'xt/psee.do?red=del&user_id='+parm['user_id']+'&rid='+parm['rid'],'',tiketMap,function(data){
	    if(data.code!=0){
$pb.showMess(data.messageTxt,200);
	    }
	});
    pb.loadUrlData();
},parm);
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
	if(frameElement!= null&&$pb.isNull(frameElement.dialog,'')!=''){
        			   $pb.mergeMap(parm,frameElement.dialog.get('opener').parmaMap);
        			}
parm['user_id']=$("#user_id").val();
parm['rid']=$('#rId').val();

      $pb.Data.load(parm,tiketMap,"/xt/psee.do",$pb.grid.pbCol(pb.getCols()),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){        				  
        				gridData.Rows=$pb.findTreeMap(data.data,'id','parentId');
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
function ckeckFun(ck,i){
   var userId=$("#user_id").val();
   if(ck){
        $pb.tree.gridCheck(function(){  return pb.manager; },"notsee_userId" ,"",i,ck,true);  
        $pb.tree.gridCheck(function(){  return pb.manager; }, "see_userId" ,userId,i,ck,true);
   }else{
        $pb.tree.gridCheck(function(){ return pb.manager; },"notsee_userId" ,userId,i,ck,false);  
        $pb.tree.gridCheck(function(){ return pb.manager; }, "see_userId" ,"",i,ck,false);
   }
}
function loadLang(){
  $("#spanrId").html(getDes('角色'));
  $("#rIdValue").html($pb.edit.import_(getRid,function(dataMap){
        $("#rId").val(dataMap["rId"]);
         $("#rName_").html(dataMap["rName_"]);
        $("#user_id").val(''); yeLoad();
},"xt/js1.jsp","rId;rName_","rId;rName",false));
  $("#spanUid").html(getDes('userId'));
  $("#uIdValue").html($pb.edit.import_(changeRid,function(dataMap){
 $("#user_id").val(dataMap["user_id"]);
  $("#user_name").html(dataMap["user_name"]);
yeLoad();
},"xt/user.jsp","user_id;user_name","user_id;nick_name",false));
}
function getRid(){
  parmaMap={"showMap":{"showMax":false}};
}
function changeRid(){
    var rid=$("#rId").val();
parmaMap={};
   if(rid){
    parmaMap.user_rank=rid;  
   }
}
function hasUser(){
        var userId=$("#user_id").val();
         if(userId!=""){
           return true;
    }
return false;
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
<span id="spanrId"></span>:<input type="text" value="5" id="rId" readonly="true" style="background:#CCC;width:30" onchange="changeRid();yeLoad();"><span id="rIdValue"></span>
<span id="spanUid"></span>:<input type="text" value="" id="user_id" onchange="yeLoad();"><span id="uIdValue"></span>
现在设置的是：<span id="rName_">普通用户</span>-<span id="user_name"></span>
<div id="spanGrid">
</div>
<div id="spanGridHid" style="display:none"></div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
