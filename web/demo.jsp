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
var action='157';
var pb_UrlId='157';
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
 $pb.select.get(["mblx","mbsd","mbbq"],function(sdate){
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
  noCopy:"DemoID",
        		getCols:function(d_){
                           pb.cols=[{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'pbOk',true);
},"align":"left","width":50,"name":"pbOk","display":getDes("pbOk"),frozen: true},{ display:getDes('PreviewImage'), isSort: false, width: 60, render: function (item){   
      return $pb.Data.loadPic(item.DemoID,54,"PreviewImage",1,'PreviewImage'+item.__index,item);
},frozen: true},{"isSort":"false","align":"left","width":100,"name":"DemoID","display":getDes("DemoID"),hide:"true"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":200,"name":"DemoLink","display":getDes("DemoLink")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"DemoName","display":getDes("DemoName"),render:function(item){
   var u=$pb.isNull(item.DemoLink,"");
   if(u!=""){
     return '<a href="http://119.29.140.160/demo/'+u+'" target="_blank">'+$pb.isNull(item.DemoName,"请修改")+'</a>';
  }
   return item.DemoName;
}},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("mbsd").data, valueField: 'sValue' },
    render: function (item){
                        return $pb.select.getObj("mbsd").map[$pb.isNull(item.DemoColour,0)][0].text;
},"align":"left","width":100,"name":"DemoColour","display":getDes('DemoColour')},{"isSort":"false","editor":{"type":"radiolist",css:"back_",rowSize:3,"textField":"text","valueField":"sValue","data":$pb.select.getObj("mblx").data,split:","},"align":"left","width":200,"name":"DemoType","display":getDes('DemoType'),render:function(item){
                             var v_=$pb.isNull(item["DemoType"],"0").split(",");
                             var r_="";
                             $(v_).each(function(i,v){
                                if(i>0){
                                   r_+=",";
                                }
                                r_+=$pb.isNull($pb.select.getObj("mblx").map[v],[{text:"无"}])[0].text;
                             }); 
                             return r_;
                            }
},{"isSort":"false","editor":{"type":"checkboxlist",css:"back_",rowSize:9,"textField":"text","valueField":"sValue","data":$pb.select.getObj("mbbq").data,split:","},"align":"left","width":400,"name":"DemoLabel","display":getDes('DemoLabel'),render:function(item){
                             var v_=$pb.isNull(item["DemoLabel"],"0").split(",");
                             var r_="";
                             $(v_).each(function(i,v){
                                if(i>0){
                                   r_+=",";
                                }
                                r_+=$pb.select.getObj("mbbq").map[v][0].text;
                             }); 
                             return r_;
                            }
},{"isSort":"false","editor":{ "type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, 
  render:function(item){
        return $pb.edit.date({item:item,filed:'AddTime',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"AddTime","display":getDes('AddTime')}];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
                            pb.initValue["AddTime"]=$pb.Date.formatDate(new Date());
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
$pb.Data.gridSave(pb.manager,tiketMap,"157","DemoID",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
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
             parmMap[i+" like ?"]="%"+n+"%";       
     }
   });
     $pb.mergeMap(parm,parmMap);
      $pb.Data.load(parm,tiketMap,"157",$pb.grid.pbCol(pb.getCols()),function(data){
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
if(load==0){
var saveFrom='panFrom_not';
$("#panFrom1").html('<span id="'+saveFrom+'"></span>');
       pb_Pan=$("#"+saveFrom).ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
			space : 7,
			fields : [{"newline":false,"name":"DemoID","display":getDes("DemoID")},{"newline":false,"name":"DemoLink","display":getDes("DemoLink"),"type":"text"},{"newline":false,"name":"DemoName","display":getDes("DemoName"),"type":"text"},{newline:false,name:"DemoType",display:getDes("DemoType"), type: "select",editor: {
                        data: $pb.select.getObj("mblx").data,valueField :"sValue"
                    },pbSelect:"mblx"
},{newline:false,name:"DemoColour",display:getDes("DemoColour"), type: "select",editor: {
                        data: $pb.select.getObj("mbsd").data,valueField :"sValue"
                    },pbSelect:"mbsd"
},{newline:false,name:"DemoLabel",display:getDes("DemoLabel"), type: "select",editor: {
                        data: $pb.select.getObj("mbbq").data,valueField :"sValue"
                    },pbSelect:"mbbq"
}]
	});
	 var obj = {   
                    DemoLink:""   
         };
	if(parmParent.isHas()){
	  parmParent.get();
          $pb.mergeMap(obj,parmParent.panelMap);
	}
         pb_Pan.setData(obj);
load=1;
}
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
