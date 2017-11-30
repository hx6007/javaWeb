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
var action='101';
var pb_UrlId='101';
 function funNext(fun){
$pb.select.get("reportType",function(sdate){  
      if(typeof fun =="function"){
          fun();
     }
     });
 }


        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
        		getCols:function(d_){
                          pb.cols=[{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ReportID","display":getDes('ReportID')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"urlId","display":$pb.lang.readDes(langDesMap,'urlId')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"OriginalFleName","display":$pb.lang.readDes(langDesMap,'OriginalFleName')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"PhysicalFileName","display":$pb.lang.readDes(langDesMap,'PhysicalFileName')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ParentReportID","display":$pb.lang.readDes(langDesMap,'ParentReportID')},{"isSort":"false","editor":{"type":"checkboxlist",css:"back_","textField":"text","valueField":"sValue","data":$pb.select.getObj("reportType").data,split:","},"align":"left","width":200,"name":"OutFarmat","display":getDes('OutFarmat'),render:function(item){
                        			  var v_=item["OutFarmat"].split(",");
                        			  var r_="";
                        			  for(var i in v_){
                        				  if(i>0){
                        					  r_+=",";
                        				  }
                        				  r_+=$pb.select.getObj("reportType").map[i][0].text;
                        			  }
                        			  return r_;
                        		  }
},{"isSort":"false","editor":{"type":"radiolist",css:"back_","textField":"text","valueField":"sValue","data":$pb.select.getObj("reportType").data},"align":"left","width":200,"name":"DefaultOutFarmat","display":$pb.lang.readDes(langDesMap,'DefaultOutFarmat'),render:function(item){  
                        			  return $pb.select.getObj("reportType").map[item["DefaultOutFarmat"]][0].text;
                        		  }},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"Owner","display":$pb.lang.readDes(langDesMap,'Owner')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"CreateTime","display":$pb.lang.readDes(langDesMap,'CreateTime')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ModifiedMan","display":$pb.lang.readDes(langDesMap,'ModifiedMan')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"LastModified","display":$pb.lang.readDes(langDesMap,'LastModified')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"CurVer","display":$pb.lang.readDes(langDesMap,'CurVer')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"ReportName","display":$pb.lang.readDes(langDesMap,'ReportName')}];
 if(parmParent.isHas()&&parmParent.parm.ReportID){
                             pb.cols=$pb.grid.showCol(pb.cols,parmParent.showFiled);
                             pb.cols.push({"isSort":"false",render: function (item){ return $pb.edit.textArea('pb.manager',item,'ReportBinFile',{edit:true,cols:26,rows:4}); },"align":"left","width":200,"name":"ReportBinFile","display":getDes('ReportBinFile')});
                          }else{
                             pb.cols.push({ display:getDes("详细") , isSort: false, width: 220,frozen: true, render: function (item){
                             return $pb.edit.import_(function(){
                             parmaMap={};
                             parmaMap.ReportID=item.ReportID; 
                             parmaMap.urlId=item.urlId; parmaMap.showFiled=["ReportID","urlId"];
                             },item.__index,"report/f.jsp","","",false)+$pb.report.getA(item.OutFarmat,{ReportID:item.ReportID,urlId:item.urlId});
 } });
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
                                         }, icon: 'search2'},{ line: true },
	        	                { text:$pb.lang.readDes(langDesMap,'增加') , click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: $pb.lang.readDes(langDesMap,'删除'), click: pb.deleteRow, img: '<%=basePath%>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
	        	                { line: true },
	        	                { text:$pb.lang.readDes(langDesMap,'保存') , click: pb.saveAll, icon: 'modify' }
	        	                ]
        	                },
        	                enabledEdit: true,isScroll: false,pageSize:5,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:260,rowHeight:60,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"101","ReportID",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
      $pb.Data.load(parm,tiketMap,"101",$pb.grid.pbCol(pb.cols),function(data){
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
