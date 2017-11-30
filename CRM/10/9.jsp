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
var action='164';
var pb_UrlId='164';
var Item="";
        var manageUrl=$pb.manageUrl;
var djMap={"tableNo":"12","col":"rName","pk":"rId"};
var ssMap={"tableNo":"9","col":"region_name","pk":"pRegionId","cache":true};
 function funNext(fun){
  $pb.select.get(["gender","khdj","khly","khlx"],function(sdate){  
$pb.Data.loadArrayDes([djMap],function(){
      if(typeof fun =="function"){
          fun();
     }
});
     });
 }
	function getRegionId(filed){
	    var okV="return false";
	     if(filed=="Country"){
	       okV=$pb.fun.get(function(){
	          var item=$pb.panel.getData(pb_Pan);
	          if(getRowEdit(item)){
                 f_import(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:0
                                    ,"region_name not like ?":"%地区",
                                      checkbox:true,urlParam:item[filed]
                                    };
                                    return pb.manager;
                                },function(dataMap){
                                     pb_Pan.setData(dataMap);
                                },$pb.manageUrl+"dq/lb.jsp",filed,"pRegionId",false);
               }
           }).str;
	     }else if(filed=="Province"){
	       okV=$pb.fun.get(function(){
	          var item=$pb.panel.getData(pb_Pan);
	          if(getRowEdit(item)){
                 f_import(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.Country
                                    ,checkbox:true,urlParam:item[filed]
                                    };
                                    return pb.manager;
                                },function(dataMap){
                                     pb_Pan.setData(dataMap);
                                },$pb.manageUrl+"dq/lb.jsp",filed,"pRegionId",false);
              }
            }).str;
	     }else if(filed=="City"){
	       okV=$pb.fun.get(function(){
	          var item=$pb.panel.getData(pb_Pan);
	          if(getRowEdit(item)){
                 f_import(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.Province
                                    ,checkbox:true,urlParam:item[filed]
                                    };
                                    return pb.manager;
                                },function(dataMap){
                                     pb_Pan.setData(dataMap);
                                },$pb.manageUrl+"dq/lb.jsp",filed,"pRegionId",false);
              }
            }).str;
	     }else if(filed=="District"){
	       okV=$pb.fun.get(function(){
	          var item=$pb.panel.getData(pb_Pan);
	          if(getRowEdit(item)){
                 f_import(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.City
                                    ,checkbox:true,urlParam:item[filed]
                                    };
                                    return pb.manager;
                                },function(dataMap){
                                     pb_Pan.setData(dataMap);
                                },$pb.manageUrl+"dq/lb.jsp",filed,"pRegionId",false);
              }
            }).str;
	     }
	     return '<input type="button" value="..." onclick= "'+okV+'"/>';
	}
        pb={
        		manager:null,
  noCopy:"Item",
        		initValue:null,saveAll:function(){
var form = new liger.get("panFrom");
if(form.valid()){
$pb.Data.gridSave(pb.manager,tiketMap,"164","Item",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
}
        		},loadUrlData:function(data){
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(data){
	if(data.hasOwnProperty("pbCode")){
		if(pb.parentData){
			parmParent.panel.reLoad(data["pbCode"]);
		}else{
		   Item=data["pbCode"];
		}
	}
}
if(Item!=""){
parm["Item"]=Item;
}
if(parmParent.isHas()){
   $pb.mergeMap(parm,parmParent.get());
}

$(['add','delete','copyRow','searche',"nextOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
if(count(parm)>2){
       $pb.Data.panLoad(parm,tiketMap,"164",$pb.grid.pbCol(pb_Pan.options.fields),function(data){
       	           if(data.code==0){
       					var isOk=(data.data&&data.data.hasOwnProperty("pbOk")&&data.data.pbOk!=null)?data.data.pbOk:"0";
       					if(isOk!=0){
$(["save","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
       						var l=[];
	       					for(var i=0,len=pb_Pan.options.fields.length;i< len;i++){
	       						l.push(pb_Pan.options.fields[i].name);
	       					}
	       					$pb.panel.readOnly(pb_Pan,l);
       					} 
       					
       				    pb_Pan.setData(data.data);    
       				    $('#photo1').html($pb.Data.loadPic(data.data['Item'],54,"kh_p_tou",1,'p_tou0',data.data));                               
                     }  
      });	
       }
$pb.panel.readOnly(pb_Pan,["Item"]);
},creat:function(){
	if(this.creatDo==null){
    pb_Pan=$("#panFrom").ligerForm({
		inputWidth : 170,
		labelWidth : 120,
		labelAlign:"right",
        validate: true,"fields":repDesJson(theFiled),
		space : 10
});
this.parentData=parmParent.panel.getData();
pb_Pan.setData(this.parentData);
    this.creatDo=true;
	}
}
 }; 
var theFiled;
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
loadDesNext(function(){
 theFiled=[
 {newline:false,name:"pbOk",display:getDes("pbOk"),type:"checkbox",oldtype:"int",disabled:"true",group:"客户信息",groupicon:"images/group/group.gif"},{newline:false,name:"Item",display:getDes("Item"),type:"text",disabled:"true",afterContent:'<span id="photo1" align="center"></span>'},
 {name:"CltName",display:getDes("CltName"),type:"text",validate:{"required":true}},
 {newline:false,name:"CltCode",display:getDes("CltCode"),type:"text",validate:{"required":true}},
 {name:"RTtime",display:getDes("RTtime"),type:"date",oldtype:"text",validate:{"date":true},newline:false},
 {name:"CltSource",display:getDes("CltSource"),type:"checkboxlist",editor:{data:$pb.select.getObj("khly").data,valueField:'sValue',rowSize:8,split:','},pbSelect:"khly",width:"600",newline:false},{name:"CltType",display:getDes("CltType"),type:"select",editor:{data:$pb.select.getObj("khlx").data,valueField:'sValue'},pbSelect:"khlx"},{newline:false,name:"CltGrade",display:getDes("CltGrade"),type:"select",editor:{data:$pb.select.getObj("khdj").data,valueField:'sValue'},pbSelect:"khdj"},{newline:false,name:"CltRemark",display:getDes("CltRemark"),type:"text"},{newline:false,name:"CltGroups",display:getDes("CltGroups"),type:"text"},{name:"Linkman",display:getDes("Linkman"),type:"text",group:"联系人信息",groupicon:"images/group/group.gif"},{newline:false,name:"Sex",display:getDes("Sex"),type:"select",oldtype:"text",editor:{data:$pb.select.getObj("gender").data,valueField:'sValue'},pbSelect:"gender"},{newline:false,name:"Birthday",display:getDes("Birthday"),type:"date",oldtype:"text"},{newline:false,name:"Position",display:getDes("Position"),type:"text"},{name:"PhoneNub",display:getDes("PhoneNub"),type:"text",group:"联系信息",groupicon:"images/group/group.gif",validate:{"required":true}},{newline:false,name:"FixedNub",display:getDes("FixedNub"),type:"text"},{newline:false,name:"FAX",display:getDes("FAX"),type:"text"},{newline:false,name:"Email",display:getDes("Email"),type:"text",validate:{"email":true,"required":true}},{newline:false,name:"QQ",display:getDes("QQ"),type:"text"},{newline:false,name:"WeChat",display:getDes("WeChat"),type:"text"},{name:"Country",display:getDes("Country"),type:"text",group:"地址信息",groupicon:"images/group/group.gif",disabled:"true",afterContent:getRegionId("Country"),hideSpace:true},{newline:false,name:"Province",display:getDes("Province"),type:"text",disabled:"true",afterContent:getRegionId("Province"),hideSpace:true},{newline:false,name:"City",display:getDes("City"),type:"text",disabled:"true",afterContent:getRegionId("City"),hideSpace:true},{newline:false,name:"District",display:getDes("District"),type:"text",disabled:"true",afterContent:getRegionId("District"),hideSpace:true},{newline:false,name:"Address",display:getDes("Address"),type:"text"}];
pb.creat();
$pb.lang.load(langNo, tiketMap,function(data){ 
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
<form id="panFrom"></form>
</div>
</body>
</html>
<script src="<%=path%>/js_/menu_.js" type="text/javascript"></script>  
