<%@page import="com.pb.multiData.SpObserver"%>
<%
    String pt_db= SpObserver.getDbCongfig();
    List<String> doIn = new ArrayList<String>();
    doIn.add("");
    doIn.add("cong1");
    if(!doIn.contains(pt_db)){
       out.write("无此路径");
       return ;
    }
 %>
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
        var langNoC="1";
var langDesMap;
var action='/pturl.do';
var pb_UrlId='1';
        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
                       noCopy:"id",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","editor":{"type":"text"},"align":"left","width":30,"name":"id","display":getDes('id')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":250,"name":"pt_url","display":getDes('pt_url')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pt_des","display":getDes('pt_des')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pt_alias","display":getDes('pt_alias')},{"isSort":"false",render: function (item){ return $pb.edit.textArea('pb.manager',item,'user',{edit:true,cols:24,rows:3}); },"align":"left","width":240,"name":"user","display":getDes("user")},{"isSort":"false",render: function (item){ return $pb.edit.textArea('pb.manager',item,'password',{edit:true,cols:24,rows:3}); },"align":"left","width":240,"name":"password","display":getDes("password")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"dbIp","display":getDes("dbIp")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"dbPort","display":getDes("dbPort")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"dbName","display":getDes("dbName")},{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'use_ssh',true);},"align":"left","width":80,"name":"use_ssh","display":getDes("use_ssh")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"host","display":getDes("host")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"port","display":getDes("port")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ppk","display":getDes("ppk")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"lport","display":getDes("lport")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"fport","display":getDes("fport")},{ display:getDes("操作"), isSort: false, width: 100, "align":"left",render: function (item){
  var  okV=$pb.fun.get(function(){
var saveing= $.ligerDialog.waitting(getDes('正在处理...'));
$pb.Data.load({},tiketMap,"/item.do",'',function(data){
	setTimeout(function (){saveing.close();}, 1000);  
	     if(data.code==0){
	         $pb.showMess(getDes("成功处理！"),1000);
	     }else{
	         $pb.showMess(data.messageTxt,1000);	        	                       
	     }
},"db=ref&cacheId="+item.pt_alias);
      }).str;
  return '<a href="javascript:void(0);" onclick="'+okV+'">'+getDes('生效')+'</a>';
}}];
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
                                         }, icon: 'search2'},{ line: true },
	        	                { text:$pb.lang.readDes(langDesMap,'增加') , click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: $pb.lang.readDes(langDesMap,'删除'), click: pb.deleteRow, img: '<%=basePath%>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
	        	                { line: true },
	        	                { text:$pb.lang.readDes(langDesMap,'保存') , click: pb.saveAll, icon: 'modify' }
	        	                ]
        	                },
        	                enabledEdit: true,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:260,rowHeight:24,
        	                width: '98%',height:"96%"
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"/pturl.do","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
      $pb.Data.load(parm,tiketMap,"/pturl.do",$pb.grid.pbCol(pb.cols),function(data){
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
