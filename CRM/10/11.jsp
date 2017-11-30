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
var action='159';
var pb_UrlId='159';
        var manageUrl=$pb.manageUrl;
 var djMap={"tableNo":"12","col":"rName","pk":"rId"};
function funNext(fun){
  $pb.select.get(["gender"],function(sdate){  
$pb.Data.loadArrayDes([djMap],function(){
      if(typeof fun =="function"){
          fun();
     }
     });
     });
 }

var qizhi=$pb.fun.get(function(obj){
     pb.manager.updateCell("validata", 1, obj);
     pb.saveAll();
},"true").strFun;
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"id",
        		getCols:function(d_){
                           pb.cols=[{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'pbOk',true);
},"align":"left","width":50,"name":"pbOk","display":getDes("pbOk"),frozen: true},{"isSort":"false","align":"left","width":100,"name":"id","display":getDes("id")},{"isSort":"false","align":"left","width":100,"name":"customer_id","display":getDes("customer_id")},{"isSort":"false","editor":{"type":"int"},"align":"left","width":100,"name":"tel","display":getDes("tel")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"person","display":getDes("person")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"qq","display":getDes("qq")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"wechat","display":getDes("wechat")},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("gender").data, valueField: 'sValue' },render: function (item){
                        return $pb.select.getObj("gender").map[$pb.isNull(item.sex,0)][0].text;
 },"align":"left","width":100,"name":"sex","display":getDes("sex")},{"isSort":"false",render:function(item){
   var imp="";
if(getRowEdit(item)){
    imp=$pb.edit.import_(function(){
         imp.title="选择角色";
         parmaMap={                    
              "showMap":{"showMax":false},
              "100":"rId != 1",checkbox:true,checkFun:function(row){
                  if(row.rId==item.rank)
                  return true;
                  return false;
              }
         };  
         return pb.manager;                  
 },item.__index,"xt/js1.jsp","rank","rId",false,null,item);
}
           return $pb.isNull($pb.Data.loadDes($pb.mergeNewMap(djMap,{"param":{"rId":item.rank}})),"")+imp;
},"align":"right","width":100,"name":"rank","display":getDes("rank")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"email","display":getDes("email")},{"isSort":"false","editor":{"type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, render:function(item){
                              return $pb.edit.date({item:item,filed:'birthday',gManage:pb.manager});
},type:"date","align":"left","width":160,"name":"birthday","display":getDes("birthday")},{"isSort":"false","editor":{"type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, render:function(item){
                              return $pb.edit.date({item:item,filed:'created_at',gManage:pb.manager});
},type:"date","align":"left","width":160,"name":"created_at","display":getDes("created_at")},{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'validata',true);
},"align":"left","width":30,"name":"validata","display":getDes("validata")}
,{"isSort":"false","editor":{"type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, render:function(item){
                              return $pb.edit.date({item:item,filed:'stack_flow',gManage:pb.manager});
},type:"date","align":"left","width":160,"name":"stack_flow","display":getDes("stack_flow")},{"render": function(item){
 return '<a href="javascript:void(0)" onclick="'+qizhi+'('+item.__index+')">强制失效</a>';
},"align":"left","width":100,"display":getDes("操作")}];
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
$pb.Data.gridSave(pb.manager,tiketMap,"159","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
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
$(["nextOk","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
      $pb.Data.load(parm,tiketMap,"159",$pb.grid.pbCol(pb.getCols()),function(data){
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
			fields : [{newline:false,name:"id",display:getDes("id"),type:"text"},{newline:false,name:"customer_id",display:getDes("customer_id"),type:"text"},{newline:false,name:"tel",display:getDes("tel"),type:"int"},{newline:false,name:"person",display:getDes("person"),type:"text"},{newline:false,name:"qq",display:getDes("qq"),type:"text"},{newline:false,name:"wechat",display:getDes("wechat"),type:"text"},{newline:false,name:"sex",display:getDes("sex"),type:"select",editor:{"data":[{"sNo":"gender","sValue":"0","text":"保密"},{"sNo":"gender","sValue":"1","text":"女"},{"sNo":"gender","sValue":"2","text":"男"}],"valueField":"sValue"}},{newline:false,name:"rank",display:getDes("rank"),type:"text"},{newline:false,name:"email",display:getDes("email"),type:"text"},{newline:false,name:"birthday",display:getDes("birthday"),type:"date",oldtype:"text"},{newline:false,name:"created_at",display:getDes("created_at"),type:"date",oldtype:"text"},{newline:false,name:"validata",display:getDes("validata"),type:"checkbox"},{newline:false,name:"stack_flow",display:getDes("stack_flow"),type:"date",oldtype:"text"}]
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
