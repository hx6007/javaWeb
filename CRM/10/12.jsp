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
<script src="<%=path%>/js_/manage.js" type="text/javascript"></script>  
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
var action='160';
var pb_UrlId='160';
        var manageUrl=$pb.manageUrl;
function funNext(fun){ 
  $pb.select.get(["lxfs","lxjg"],function(sdate){  
     $pb.Data.loadArrayDes([],function(){      
            if(typeof fun =="function"){ 
                fun(); 
           } 
     }); 
   }); 
 }

        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"id",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"id","display":getDes("id"),hide:"true"},{"isSort":"false","render": function(item){
imp.title="客服人员引入" ;
    return  $pb.isNull(item.user_id,"")+$pb.edit.import_(function(){
        parmaMap={"CONCAT(',',roleIds,',')like ?":"%,36,%"};
        return pb.manager;
    },item.__index,"xt/user.jsp","user_id","user_id",false,null,item);
},"align":"right","width":100,"name":"user_id","display":getDes("user_id")},{"isSort":"false","render": function(item){
imp.title="引入有权限的客户" ;
    return  $pb.isNull(item.customer_id,"")+$pb.edit.import_(function(){
    	 parmaMap={"Salesman":$pb.isNull(item.user_id,"")};
                return pb.manager;
    },item.__index,"CRM/10/10.jsp","customer_id","Item",false,null,item);
},"align":"right","width":100,"name":"customer_id","display":getDes("customer_id")},{"isSort":"false","render": function(item){
imp.title="查看联系人" ;
    return  $pb.isNull(item.contactId,"")+$pb.edit.import_(function(){
    	 parmaMap={"customer_id":$pb.isNull(item.customer_id,"")};
                return pb.manager;
    },item.__index,"CRM/10/11.jsp","contactId","id",false,null,item);
},"align":"right","width":100,"name":"contactId","display":getDes("contactId")},{"isSort":"false","editor":{ "type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, 
  render:function(item){
        return $pb.edit.date({item:item,filed:'contact_date',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"contact_date","display":getDes('contact_date')}
,{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("lxfs").data, valueField: 'sValue' },
    render: function (item){
                        return $pb.select.getObj("lxfs").map[$pb.isNull(item.contact_type,0)][0].text;
    },"align":"left","width":100,"name":"contact_type","display":getDes("contact_type")},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'remark',{edit:true,cols:26,rows:3}); 
 },"align":"left","width":230,"name":"remark","display":getDes("remark")}
,{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("lxjg").data, valueField: 'sValue' },
    render: function (item){
                        return $pb.select.getObj("lxjg").map[$pb.isNull(item.contact_type,0)][0].text;
    },"align":"left","width":100,"name":"result","display":getDes("result")},{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'is_stack',true);
},"align":"left","width":30,"name":"is_stack","display":getDes("is_stack")}
,{"isSort":"false","editor":{ "type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, 
  render:function(item){
        return $pb.edit.date({item:item,filed:'next_contact',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"next_contact","display":getDes('next_contact')},{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'pbOk',true);
},"align":"left","width":50,"name":"pbOk","display":getDes("pbOk"),frozen: true}];
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
$pb.Data.gridSave(pb.manager,tiketMap,"160","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
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
     if(!$.isEmptyObject(n)||n){
             parmMap[i]=n;       
     }
   });
     $pb.mergeMap(parm,parmMap);
      $pb.Data.load(parm,tiketMap,"160",$pb.grid.pbCol(pb.getCols()),function(data){
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
loadMenu(data);
if(load==0){
var saveFrom='panFrom_not';
$("#panFrom1").html('<span id="'+saveFrom+'"></span>');
       pb_Pan=$("#"+saveFrom).ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
			space : 7,
			fields : [{newline:false,name:"id",display:getDes("id"),type:"text"},{newline:false,name:"user_id",display:getDes("user_id"),type:"text"},{newline:false,name:"customer_id",display:getDes("customer_id"),type:"text"},{newline:false,name:"contactId",display:getDes("contactId"),type:"text"},{newline:false,name:"contact_date",display:getDes("contact_date"),type:"date",oldtype:"text"},{newline:false,name:"contact_type",display:getDes("contact_type"),type:"text"},{newline:false,name:"remark",display:getDes("remark"),type:"text"},{newline:false,name:"result",display:getDes("result"),type:"text"},{newline:false,name:"is_stack",display:getDes("is_stack"),type:"checkbox"},{newline:false,name:"next_contact",display:getDes("next_contact"),type:"date",oldtype:"text"}]
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


<span id="panFrom1"></span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>

</body>
</html>
<script src="<%=path%>/js_/menu_.js" type="text/javascript"></script>  
