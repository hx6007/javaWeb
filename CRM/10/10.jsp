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
var action='158';
var pb_UrlId='158';
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
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"Item",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"Item","display":getDes("Item"),hide:"true"},{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'pbOk',true);
},"align":"left","width":50,"name":"pbOk","display":getDes("pbOk"),frozen: true}
,{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"CltCode","display":getDes("CltCode"),frozen: true},{ display:getDes('p_tou'), isSort: false, width: 90, render: function (item){   
      return $pb.Data.loadPic(item.Item,54,"kh_p_tou",1,'p_tou'+item.__index,item);
},frozen: true},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"CltName","display":getDes("CltName"),frozen: true,render: function (item){   
 var link=$pb.edit.import_(function(){
                                    imp.title="顾客公司信息" ;
                                    parmaMap={Item:item.Item};
                                    return pb.manager;
                                },"","CRM/10/9.jsp","","",false,item.CltName);
    return link;
}},{"isSort":"false",render: function (item){   
 var link=$pb.edit.import_(function(){
imp.title="联系人信息" ;
 var initMap={customer_id:item.Item};
                                   parmaMap={initValue:initMap,panelMap:initMap};
                                    return pb.manager;
                                },"","CRM/10/11.jsp","","",false,"更多");
    return link;
},"align":"right","width":100,"name":"Linkman","display":getDes("Linkman"),frozen: true},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"FixedNub","display":getDes("FixedNub")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":120,"name":"FAX","display":getDes("FAX")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"Email","display":getDes("Email")},{"isSort":"false",render:function(item){                           
     var rI=item.__index;
    var mes="";
     var spanId="Country"+rI;
var imp="";
   if($pb.isNull(item.Country,"")!=""){
      mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                  if(data){
                                     $("#"+spanId).html(data);
                                    }
                                }}),item.Country),""); 

  }
    if(getRowEdit(item)){
     imp=$pb.edit.import_(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:0,"region_name not like ?":"%地区",checkbox:true,urlParam:item.Country};
                                    return pb.manager;
                                },function(dataMap){
                                     var rowid=item.__index;
                                     var rowMap=pb.manager.getRow(rowid);
                                     if(rowMap.Country!=dataMap.Country){
                                         $pb.mergeMap(dataMap,{Province:"",City:"",District:"",Address:""});
                                         $pb.Data.setGrid(pb.manager,dataMap,rowid);
                                     }
                                },"dq/lb.jsp","Country","pRegionId",false,null,item);
}
                                return "<span id='"+spanId+"'>"+mes+"</span>"+imp;
},"align":"right","width":100,"name":"Country","display":getDes("Country")},{"isSort":"false",render:function(item){        
   var im="";
  var mes="";
     var rI=item.__index;
     var spanId="Province"+rI;
   if($pb.isNull(item.Country,"")!=""){
      if(getRowEdit(item)){
       im=$pb.edit.import_(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.Country,checkbox:true,urlParam:item.Province};
                                    return pb.manager;
                                },function(dataMap){
                                     var rowid=item.__index;
                                     var rowMap=pb.manager.getRow(rowid);
                                     if(rowMap.Province!=dataMap.Province){
                                         $pb.mergeMap(dataMap,{City:"",District:"",Address:""});
                                         $pb.Data.setGrid(pb.manager,dataMap,rowid);
                                     }
                                },"dq/lb.jsp","Province","pRegionId",false,null,item);
     }
     mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.Province),"");
   }
        return "<span id='"+spanId+"'>"+mes+"</span>"+im;
},"align":"right","width":100,"name":"Province","display":getDes("Province")},{"isSort":"false",render:function(item){    
var im="";
var rI=item.__index;
var spanId="City"+rI;
var mes="";
   if($pb.isNull(item.Province,"")!=""){
     if(getRowEdit(item)){
       im=$pb.edit.import_(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.Province,checkbox:true,urlParam:item.City};
                                    return pb.manager;
                                },function(dataMap){
                                     var rowid=item.__index;
                                     var rowMap=pb.manager.getRow(rowid);
                                     if(rowMap.City!=dataMap.City){
                                         $pb.mergeMap(dataMap,{District:"",Address:""});
                                         $pb.Data.setGrid(pb.manager,dataMap,rowid);
                                     }
                                },"dq/lb.jsp","City","pRegionId",false,null,item);
}
mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.City),"");
   } 
return "<span id='"+spanId+"'>"+mes+"</span>"+im;
},"align":"right","width":100,"name":"City","display":getDes("City")},{"isSort":"false",render:function(item){     
var im="";
var rI=item.__index;
var spanId="District"+rI;
var mes="";
   if($pb.isNull(item.City,"")!=""){
     if(getRowEdit(item)){
       im=$pb.edit.import_(function(){
                                    parmaMap={"showMap":{"showMax":false},parent_id:item.City,checkbox:true,urlParam:item.District};
                                    return pb.manager;
                                },function(dataMap){
                                     var rowid=item.__index;
                                     var rowMap=pb.manager.getRow(rowid);
                                     if(rowMap.District!=dataMap.District){
                                         $pb.mergeMap(dataMap,{Address:""});
                                         $pb.Data.setGrid(pb.manager,dataMap,rowid);
                                     }
                                },"dq/lb.jsp","District","pRegionId",false,null,item);
}
mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.District),"");
}
return "<span id='"+spanId+"'>"+mes+"</span>"+im;
},"align":"right","width":100,"name":"District","display":getDes("District")},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'Address',{edit:true,cols:26,rows:3}); 
 },"align":"left","width":240,"name":"Address","display":getDes("Address")}
,{"isSort":"false","editor":{"type":"checkboxlist",css:"back_",rowSize:7,"textField":"text","valueField":"sValue","data":$pb.select.getObj("khly").data,split:","},"align":"left","width":600,"name":"CltSource","display":getDes('CltSource'),render:function(item){
                             var v_=$pb.isNull(item["CltSource"],"0").split(",");
                             var r_="";
                             $(v_).each(function(i,v){
                                if(i>0){
                                   r_+=",";
                                }
                                r_+=$pb.select.getObj("khly").map[v][0].text;
                             }); 
                             return r_;
                            }
}

,{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("khlx").data, valueField: 'sValue' },render: function (item){
                 return $pb.select.getObj("khlx").map[$pb.isNull(item.CltType,0)][0].text;
 },"align":"left","width":100,"name":"CltType","display":getDes('CltType'),align:"center"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"CltGroups","display":getDes("CltGroups")},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("khdj").data, valueField: 'sValue' },render: function (item){
                        return ($pb.isNull(item.CltGrade,"")=="")?"":$pb.select.getObj("khdj").map[item.CltGrade][0].text;
 },"align":"left","width":100,"name":"CltGrade","display":getDes('CltGrade')},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'CltRemark',{edit:true,cols:26,rows:3}); 
 },"align":"left","width":240,"name":"CltRemark","display":getDes("CltRemark")}
,{"isSort":"false","editor":{"type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, render:function(item){
                              return $pb.edit.date({item:item,filed:'RTtime',gManage:pb.manager});
},type:"date","align":"left","width":150,"name":"RTtime","display":getDes("RTtime")},{"isSort":"false","align":"left","width":100,"name":"ctoId","display":getDes("ctoId")},{"isSort":"false","render": function(item){
imp.title="客服人员查看" ;
    return  $pb.edit.import_(function(){
        parmaMap={"CONCAT(',',roleIds,',')like ?":"%,36,%"};
        if(item.Salesman){
           parmaMap["user_id"]=item.Salesman;
       }
        return pb.manager;
    },item.__index,"xt/user.jsp","","",false,$pb.isNull(item.Salesman,"查看"),{pbOk:0});
},"align":"right","width":100,"name":"Salesman","display":getDes("Salesman")},{"isSort":"false",
  render:function(item){
        return $pb.edit.date({item:item,filed:'Getdate',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"Getdate","display":getDes('Getdate')},{"isSort":"false",
  render:function(item){
        return $pb.edit.date({item:item,filed:'Backdate',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"Backdate","display":getDes('Backdate')},{"render": function(item){
    return $pb.edit.checkEdit('pb.manager',item,'failure',false);
},"align":"left","width":30,"name":"failure","display":getDes("failure")}];
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
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar},
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:60,
        	                width: '98%',height:"96%",checkbox:true
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"158","Item",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
     var theMap=pb_Pan.getData();
     var parmMap={"ifnull(ctoId,'') != ?":""};
     $.each( theMap, function(i,n){
     if(!$.isEmptyObject(n)){
            if(i=="CltSource"){
      parmMap["CONCAT(',',CltSource,',') like ?"]="%,"+n+",%"; 
            }else if(i=="CltType"){
 parmMap["ifnull("+i+",0)"]=n; 
          }else{
             parmMap[i]=n; 
         } 
     }
   });
     $pb.mergeMap(parm,parmMap);
$(["nextOk","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
      $pb.Data.load(parm,tiketMap,"158",$pb.grid.pbCol(pb.getCols()),function(data){
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
			fields : [{name:"CltCode",display:getDes("CltCode"),type:"text",oldtype:"date"},{newline:false,name:"FAX",display:getDes("FAX"),type:"text"},{newline:false,name:"Email",display:getDes("Email"),type:"text"},{name:"CltName",display:getDes("CltName"),type:"text",newline:false},{name:"Linkman",display:getDes("Linkman"),type:"text",newline:false},{newline:false,name:"CltSource",display:getDes("CltSource"), type: "select",editor: {
                        data: $pb.select.getObj("khly").data,valueField :"sValue"
                    }
},{newline:false,name:"CltType",display:getDes("CltType"),type:"select",editor:{data: $pb.select.getObj("khlx").data, valueField: 'sValue' }},{newline:false,name:"CltGroups",display:getDes("CltGroups"),type:"text"},{newline:false,name:"CltGrade",display:getDes("CltGrade"), type: "select",editor: {
                        data: $pb.select.getObj("khdj").data,valueField :"sValue"
                    }
}]
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
