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
var action='23';
var pb_UrlId='23';
        var manageUrl=$pb.manageUrl;
var djMap={"tableNo":"12","col":"rName","pk":"rId"};
function funNext(fun){
$pb.select.get("isRols",function(dd){
$pb.Data.loadDes($pb.mergeNewMap(djMap,{"endfun":function(){
      if(typeof fun =="function"){
          fun();
     }
}})); 
});
 }
function save_end(data){
$pb.Data.load({},tiketMap,"xt/tb.do",'',function(data){	        	           
    	                   if(data.code==0){
    	                      $pb.showMess(getDes("已经缓存！"),100);	  
    	                     }else{
    	                       $pb.showMess(data.messageTxt,1000);	        	                       
    	                     }
},"m=cacheRoles");
pb.loadUrlData();
}
function f_isChecked(rowdata){
   var paraObj=",";
    if(parmParent.isHas()&&parmParent.urlParam){
        paraObj=","+parmParent.urlParam+",";
    }
            if (paraObj.indexOf(","+rowdata.pId+",") == -1)
                return false;
            return true;
}

        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
  noCopy:"pId",
                        refField:{},
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"pId","display":getDes('pId')},{"isSort":"false","align":"left","width":100,"name":"parentId","display":getDes('parentId'),render:function(item){
                                return $pb.isNull(item.parentId,"")+$pb.edit.import_('pb.manager',item.__index,"xt/bm/b.jsp","parentId","pId",false);
                           }},{"isSort":"false","align":"left","width":100,"name":"companyId","display":getDes('companyId'),render:function(item){
                                return $pb.isNull(item.companyId,"")+$pb.edit.import_('pb.manager',item.__index,"xt/pt/gs.jsp","companyId","pComId",false);
                           }},{"isSort":"false","editor":{"type":"int"},"align":"left","width":100,"name":"pUserNum","display":getDes('pUserNum')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pName","display":getDes('pName'),id:"id1",frozen: true},{ display:$pb.lang.readDes(langDesMap,'bmPic'), isSort: false, width: 80, render: function (item){       
      return ($pb.isNull(item.isRols,"0")=="0")?$pb.Data.loadPic(item.pId,4,"bmPic",4,'bmPic2'+item.__index):"";
}},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("isRols").data, valueField: 'sValue' },render: function (item){
                        return $pb.select.getObj("isRols").map[$pb.isNull(item.isRols,0)][0].text;
                    },"align":"left","width":100,"name":"isRols","display":getDes('isRols')},{"isSort":"false",render:function(item){
if(item.isRols!=1){
   return "";
}
return $pb.isNull($pb.Data.loadDes($pb.mergeNewMap(djMap,{"param":{"rId":item.RoleID}})),"")+$pb.edit.import_(function(){
         imp.title="选择部门角色";
         parmaMap={     urlParam:item.RoleID,               
              "showMap":{"showMax":false}
         };  
         return pb.manager;                  
 },item.__index,"xt/js.jsp","RoleID","rId",false);
},"align":"right","width":100,"name":"RoleID","display":getDes("RoleID")}
];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
var row = pb.manager.getSelectedRow();
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    if(row){
        		        pb.initValue["parentId"]=row["pId"];
                                pb.initValue["companyId"]=row["companyId"];        		     
        		   }
        		     if (pb.manager.isLeaf(row)){
		               row.children=[];
		            }
		            pb.manager.add($pb.clone(pb.initValue), null, true, row);        	
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},theGridData:null
,f_initGrid:function(gridData,gridId){
   pb.theGridData=gridData;
   var toolBar=[{ text:getDes('高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ text:getDes('收缩全部'), click: function(){pb.manager.collapseAll();}, icon: 'refresh' }
          ,{ line: true }];
pb.toobar.removeItem("delete");
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar },
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:60,fixedCellHeight:false,
                                tree: { columnId: 'id1' },  width: '98%',height:"96%",checkbox:true,autoCheckChildren:false,isChecked: f_isChecked
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"23","pId",save_end,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
      $pb.Data.load(parm,tiketMap,"23",$pb.grid.pbCol(pb.getCols()),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){        				  
        				gridData.Rows=$pb.findTreeMap(data.data,'pId','parentId');
        				gridData.Total=gridData.Rows.length;
                                        pb.gridData=gridData;		   
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
        $pb.lang.load(langNo,tiketMap,function(data){loadMenu(data);
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
