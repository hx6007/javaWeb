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
var action='161';
var pb_UrlId='161';
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
function lque(tUser,i,bc){
        pb.manager.updateCell("Salesman",tUser,i);        
        pb.manager.updateCell("Getdate",$pb.Date.formatDate(new Date()),i);
        if(bc){
           pb.saveAll();
        }
 }
 function lqueAll(tUser){
     var rows= pb.manager.getSelectedRows();
     $(rows).each(function(i,row){
         lque(tUser,row.__index,false);
     });
     pb.saveAll();
 }
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"Item",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"Item","display":getDes("Item"),hide:"true"},{ display:getDes('p_tou'), isSort: false, width: 90, render: function (item){   
      return $pb.Data.loadPic(item.Item,54,"kh_p_tou",1,'p_tou'+item.__index,{pbOk:1});
},frozen: true},{"isSort":"false","align":"left","width":100,"name":"CltCode","display":getDes("CltCode"),frozen:true},{"isSort":"false","align":"left","width":100,"name":"CltName","display":getDes("CltName")},{"isSort":"false",render: function (item){   
 var link=$pb.edit.import_(function(){
imp.title="联系人信息" ;
 var initMap={customer_id:item.Item};
                                   parmaMap={initValue:initMap,panelMap:initMap};
                                    return pb.manager;
                                },"","CRM/10/11.jsp","","",false,"更多");
    return link;
},"align":"right","width":60,"name":"Linkman","display":getDes("Linkman"),frozen: true},{"isSort":"false","align":"left","width":100,"name":"FixedNub","display":getDes("FixedNub")},{"isSort":"false","align":"left","width":100,"name":"FAX","display":getDes("FAX")},{"isSort":"false","align":"left","width":100,"name":"Email","display":getDes("Email")},{"isSort":"false",render:function(item){                           
     var rI=item.__index;
    var mes="";
     var spanId="Country"+rI;

   if($pb.isNull(item.Country,"")!=""){
      mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                  if(data){
                                     $("#"+spanId).html(data);
                                    }
                                }}),item.Country),""); 

  }
                                return "<span id='"+spanId+"'>"+mes+"</span>";
},"align":"right","width":100,"name":"Country","display":getDes("Country")},{"isSort":"false",render:function(item){        
  var mes="";
     var rI=item.__index;
     var spanId="Province"+rI;
   if($pb.isNull(item.Country,"")!=""){
     mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.Province),"");
   }
        return "<span id='"+spanId+"'>"+mes+"</span>";
},"align":"right","width":100,"name":"Province","display":getDes("Province")},{"isSort":"false",render:function(item){    
var rI=item.__index;
var spanId="City"+rI;
var mes="";
   if($pb.isNull(item.Province,"")!=""){
mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.City),"");
   } 
return "<span id='"+spanId+"'>"+mes+"</span>";
},"align":"right","width":100,"name":"City","display":getDes("City")},{"isSort":"false",render:function(item){     
var rI=item.__index;
var spanId="District"+rI;
var mes="";
   if($pb.isNull(item.City,"")!=""){
mes=$pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ssMap,{"endfun":function(data){
                                    if(data){
                                        $("#"+spanId).html(data);
                                      }
                                }}),item.District),"");
}
return "<span id='"+spanId+"'>"+mes+"</span>";
},"align":"right","width":100,"name":"District","display":getDes("District")},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'Address',{edit:false,cols:26,rows:3}); 
 },"align":"left","width":240,"name":"Address","display":getDes("Address")},{"isSort":"false","align":"left","width":600,"name":"CltSource","display":getDes('CltSource'),render:function(item){
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
},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("khlx").data, valueField: 'sValue' },render: function (item){
                 return $pb.select.getObj("khlx").map[$pb.isNull(item.CltType,0)][0].text;
 },"align":"left","width":100,"name":"CltType","display":getDes('CltType'),align:"center"},{"isSort":"false","align":"left","width":100,"name":"CltGroups","display":getDes("CltGroups")},{"isSort":"false","align":"left","width":100,"name":"CltRemark","display":getDes("CltRemark")},{"isSort":"false","editor":{"type":"int"},"align":"left","width":100,"name":"pbOk","display":getDes("pbOk"),hide:"true"},{"isSort":"false","align":"left","width":100,"name":"ctoId","display":getDes("ctoId")},{"isSort":"false","align":"left","width":100,"name":"Salesman","display":getDes("Salesman")},{"isSort":"false",
  render:function(item){
        return $pb.edit.date({item:item,filed:'Getdate',gManage:pb.manager});
  },type:"date","align":"left","width":150,"name":"Getdate","display":getDes('Getdate')}
,{"isSort":"false","render": function(item){
imp.title="业务人员引入" ;
    return  $pb.edit.import_(function(){
        parmaMap={"CONCAT(',',roleIds,',')like ?":"%,36,%"};
        return pb.manager;
    },function(row){
        lque(row["Salesman"],item.__index);
    },"xt/user.jsp","Salesman","user_id",false,"分配")+'&nbsp;<a href="javascript:void(0)" onclick="lque('+user_id+','+item.__index+')">领取</a>';
},"align":"right","width":100,"display":getDes("com"),frozen:true}];
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
          ,{ line: true },{text:getDes('批量分配') , click: function(){
                                            var rows= pb.manager.getSelectedRows();
 if(rows.length>0){
          f_import(function(){
                parmaMap={"CONCAT(',',roleIds,',')like ?":"%,36,%"};
                 parmaMap["checkbox"]={
                   checkbox:true,isSingleCheck:true
                };                
       		return pb.manager;
               },function(row){
                lqueAll(row["Salesman"]);
   	},manageUrl+"xt/user.jsp","Salesman","user_id",false);
}else{
   	 $pb.showMess("请选择批量客户",1000);
}
                                         }, icon: 'add'},{text:getDes('批量领取') , click: function(){
 var rows= pb.manager.getSelectedRows();
 if(rows.length>0){
lqueAll(user_id);
}else{
   	 $pb.showMess("请选择批量客户",1000);
}
                                         }, icon: 'add'}];
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar},
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:60, checkbox:true,
        	                width: '98%',height:"96%"//isScroll: false,
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"161","Item",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
     var theMap=pb_Pan.getData();
     var parmMap={"ifnull(ctoId,'')":""};
     $.each( theMap, function(i,n){
if(i=="pbOk"&&n){
      parmMap["ifnull(pbOk,0)"]=1;
}
     if(!$.isEmptyObject(n)){
              if(i=="CltSource"){
                  parmMap["CONCAT(',',CltSource,',') like ?"]="%,"+n+",%"; 
            }else if(";CltCode;CltName;".indexOf(";"+i+";")!=-1){
parmMap[i+" like ?"]="%"+n+"%"; 
}else{
             parmMap[i]=n; 
         }    
     }
   });
     $pb.mergeMap(parm,parmMap);
$(["nextOk","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
      $pb.Data.load(parm,tiketMap,"161",$pb.grid.pbCol(pb.getCols()),function(data){
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
			fields : [{"newline":false,"name":"Item","display":getDes("Item")},{"newline":false,"name":"CltCode","display":getDes("CltCode"),"type":"text"},{"newline":false,"name":"CltName","display":getDes("CltName"),"type":"text"},{"newline":false,"name":"FixedNub","display":getDes("FixedNub"),"type":"text"},{"newline":false,"name":"FAX","display":getDes("FAX"),"type":"text"},{"newline":false,"name":"Email","display":getDes("Email"),"type":"text"},{"newline":false,"name":"CltGroups","display":getDes("CltGroups"),"type":"text"},{"newline":false,"name":"pbOk","display":getDes("pbOk"),"type":"checkbox"}]
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
