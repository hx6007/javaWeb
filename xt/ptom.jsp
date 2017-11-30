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
        var tiketMap=<%=session.getAttribute("ticketMap")%>;
        var langNo="<%=langNo%>";
        var langNoC="1";
var langDesMap;
var action='18';
var pb_UrlId='18';
        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
        		getCols:function(d_){
                               pb.cols= [{"isSort":"false",type:"int","align":"left","width":100,"name":"id","display":getDes('id')},{"isSort":"false","align":"left","width":100,"name":"url","display":getDes('url')},{"isSort":"false","align":"left","width":100,"name":"text","display":getDes('text')},{"isSort":"false","align":"left","width":100,"name":"des","display":getDes('des')},{"isSort":"false","align":"left","width":100,"name":"sId","display":getDes('sId')},{"isSort":"false",render:function(item){                                return $pb.isNull(item.id,'');
                           },"align":"left","width":100,"name":"urlId","display":getDes('urlId'),hide:true}];
                              var userId=$("#user_id").val();
        	if(userId!=""){
        	pb.cols.push({"isSort":"false",render: function (item){
checkSeeUser(pb.manager,item,"notsee_userId");
return $pb.edit.checkEdit('pb.manager',item,'notsee_userId',true); },"align":"left","width":100,"name":"notsee_userId","display":getDes('notsee_userId')});
				pb.cols.push({"isSort":"false",render: function (item){
checkSeeUser(pb.manager,item,"see_userId");
return $pb.edit.checkEdit('pb.manager',item,'see_userId',true); },"align":"left","width":100,"name":"see_userId","display":getDes('see_userId')});
        	}else{
        	pb.cols.push({"isSort":"false",render: function (item){
if(typeof item.rId== "boolean"){
var rid=$("#rId").val();
if(item.rId==true&&rid!=""){
pb.manager.updateCell("rId",rid,item.__index);
}else{
pb.manager.updateCell("rId","p_"+rid,item.__index);
}}
return $pb.edit.checkEdit('pb.manager',item,'rId',true); },"align":"left","width":100,"name":"rId","display":getDes('rId')});
}
        		      pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
                               return pb.cols;
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    pb.manager.addRow(pb.initValue);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},theGridData:null
,f_initGrid:function(gridData,gridId){
   pb.theGridData=gridData;
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: [ 
                                       { text:$pb.lang.readDes(langDesMap,'高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'},{ line: true }
	        	                ]
        	                },
        	                enabledEdit: true,isScroll: false,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:26,rowHeight:24,headerRowHeight:40,
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
	       alert(data.messageTxt);
	    }
	});
    pb.loadUrlData();
},parm);
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
parm['pbCol']=$pb.grid.pbCol(pb.getCols());
        			if(frameElement!= null&&$pb.isNull(frameElement.dialog,'')!=''){
        			   $pb.mergeMap(parm,frameElement.dialog.get('opener').parmaMap);
        			}
parm['user_id']=$("#user_id").val();
parm['rid']=$('#rId').val();
      $pb.Data.load(parm,tiketMap,"xt/psee.do",$pb.grid.pbCol(pb.cols),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      });	
       } };  
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
         pb.loadUrlData();
        $pb.lang.load(langNo,tiketMap,loadMenu);        
    });           
}  
function checkSeeUser(gmanage,item,panId){
   var not="notsee_userId";
   if(panId==not){
      not="see_userId";
   }
	if(typeof item[panId]== "boolean"){
		var userId=$("#user_id").val();
		if(item[panId]==true&&userId!=""){
			gmanage.updateCell(not,"",item.__index);
			gmanage.updateCell(panId,userId,item.__index);
		}else{
			gmanage.updateCell(not,userId,item.__index);
			gmanage.updateCell(panId,"",item.__index);
		}
	}
}
function loadLang(){
  $("#spanrId").html($pb.lang.readDes(langDesMap,'角色'));
  $("#rIdValue").html($pb.edit.import_(getRid,function(dataMap){
        for(var key in dataMap){
              $("#"+key).val(dataMap[key]);
        }
        $("#user_id").val(''); yeLoad();
},"xt/js1.jsp","rId","rId",false));
  $("#spanUid").html($pb.lang.readDes(langDesMap,'userId'));
  $("#uIdValue").html($pb.edit.import_(changeRid,function(dataMap){
  for(var key in dataMap){
              $("#"+key).val(dataMap[key]);
 }
yeLoad();
},"xt/user.jsp","user_id","user_id",false));
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
    </script>
</head>
<body  style="padding:0px;margin:0px;overflow-y: hidden;">
<div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<span id="hidMenu" style="display: none"></span>
<div style="width: 100%; height: 90%; top:52px;overflow: auto;position: absolute;">
<span id="spanrId"></span>:<input type="text" value="5" id="rId" onchange="changeRid();yeLoad();"><span id="rIdValue"></span>
<span id="spanUid"></span>:<input type="text" value="" id="user_id" onchange="yeLoad();"><span id="uIdValue"></span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
<div id="target1" style="display:none;">
    <textarea id="tarValue" cols="100" rows="30" style="margin: 0px; width: 850px; height: 453px;"></textarea>
    <br />
    <div style="text-align: center;"><input type="button" onclick="" id="tarOk" value="确定"/></div>
 </div></div>
<br/>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
