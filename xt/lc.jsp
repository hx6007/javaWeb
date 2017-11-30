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
var action='105';
var pb_UrlId='105';
        var manageUrl=$pb.manageUrl;
var lcMap={"tableNo":"24","col":"processName","pk":"id"};
var ljmcMap={"tableNo":"7","col":"text","pk":"id"};
var djMap={"tableNo":"12","col":"rName","pk":"rId"};
var bRo;
 function funNext(fun){
  $pb.Data.load({"isRols":1},tiketMap,"23","pName,pId",function(data){
		if(data.code==0){
		   bRo={"data":data.data,"map":$pb.findMap(data.data,'pId')};
		}
$pb.select.get("act",function(sdate){ 
 $pb.Data.loadArrayDes([lcMap,ljmcMap,djMap],function(){
$pb.lang.load(langNo,tiketMap,function(data){
            if(typeof fun =="function"){
   fun();
     }
   }); 
}); 
    });
     });
 }

        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                          noCopy:"pcId",
                        refField:{},
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":50,"name":"pcId","display":getDes("pcId")},{"isSort":"false",render:function(item){
                                return $pb.isNull($pb.Data.loadDes($pb.mergeNewMap(lcMap,{"param":{"id":item.pcNo}})),"")+$pb.edit.import_('pb.manager',item.__index,"xt/pro.jsp","pcNo","id",false);
},"align":"left","width":100,"name":"pcNo","display":getDes("pcNo")},{"isSort":"false",render:function(item){ 
     return $pb.isNull($pb.Data.loadDes($pb.mergeNewMap(ljmcMap,{"param":{"id":$pb.isNull(item.pcUrlId,'')}})),"")+$pb.edit.import_(function(){
parmaMap={"pageType !=?":0,showMap:{showMax:false}};
  return pb.manager;},item.__index,'xt/pOpenUrl.jsp','pcUrlId','id');
},"align":"right","width":200,"name":"pcUrlId","display":getDes("pcUrlId")},{"isSort":"false",editor:{"type":"text"},"align":"right","width":30,"name":"pcGid","display":getDes("pcGid"),type:"int"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":60,"name":"width","display":getDes("width")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":60,"name":"height","display":getDes("height")},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pcDes","display":getDes("pcDes")},{"isSort":"false",render:function(item){
        return $pb.Data.loadDes($pb.mergeNewMap(djMap,{"param":{"rId":item.ExeType}}))+$pb.edit.import_(function(){
         imp.title="选择角色";
         parmaMap={                    
              "showMap":{"showMax":false}
         };  
         return pb.manager;                  
 },item.__index,"xt/js1.jsp","ExeType","rId",false);
},"align":"right","width":100,"name":"ExeType","display":getDes('ExeType')},{"isSort":"false",render:function(item){ 
var the=$pb.isNull(item.ExeRoles,"");
var s=[];
$(the.split(",")).each(function(no,v){
   if(v){
      s.push(bRo.map[v][0].pName);
   }
});
var show=s.join(",");
     return "<table><tr><td>"+$pb.edit.import_(function(){
parmaMap={checkbox:true,urlParam:item.ExeRoles,or:{RoleID:item.ExeType,"ifnull(isRols,0) !=?":1}};
  return pb.manager;},item.__index,'xt/bm/b.jsp','ExeRoles','pId')+"</td><td>"+$pb.edit.textArea(function(){return pb.manager;},item,'ExeRoles',{edit:false,cols:10,rows:1,value:show})+"</td></tr></table>";
},"align":"right","width":150,"name":"ExeRoles","display":getDes("ExeRoles")},{"isSort":"false",render:function(item){ 
     return "<table><tr><td>"+$pb.edit.import_(function(){
parmaMap={urlParam:item.ExeNames};
var jj=item.ExeRoles.split(",");
var orMap=[];
for(var i in jj){
orMap[i]="roleIds like '%"+jj[i]+"%'";
}
parmaMap["0"]=orMap.join(" or ");
  return pb.manager;},item.__index,'xt/user.jsp','ExeNames','user_id')+"</td><td>"+$pb.edit.textArea(function(){return pb.manager;},item,'ExeNames',{edit:false,cols:26,rows:1})+"</td></tr></table>";
},"align":"left","width":230,"name":"ExeNames","display":getDes("ExeNames")},{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'Source',true);},"align":"left","width":30,"name":"Source","display":getDes("Source")},{"isSort":"false",render:function(item){
  return $pb.edit.textArea(function(){return pb.manager;},item,'Conditions',{edit:true,cols:26,rows:1});
},"align":"left","width":200,"name":"Conditions","display":getDes("Conditions")},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("act").data, valueField: 'sValue' },
    render: function (item){
                        return $pb.select.getObj("act").map[$pb.isNull(item.Flag,0)][0].text;
    },"align":"left","width":100,"name":"Flag","display":getDes('Flag')}];
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
        					 toolbar: { items:toolBar},
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,
        	                width: '98%',height:550
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"105","pcId",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
parm["add"]="order by pcGid";
      $pb.Data.load(parm,tiketMap,"105",$pb.grid.pbCol(pb.getCols()),function(data){
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
