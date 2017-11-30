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
var action='/xt/man.do';
var pb_UrlId='2';
        var manageUrl=$pb.manageUrl;
var bRo;
 function funNext(fun){
  $pb.Data.load({"isRols":1},tiketMap,"23","pName,pId",function(data){
		if(data.code==0){
		   bRo={"data":data.data,"map":$pb.findMap(data.data,'pId')};
		}
$pb.select.get("gender",function(sdate){  
      if(typeof fun =="function"){
          fun();
     }
     });
});
 }
function f_isChecked(rowdata){
   var paraObj=",";
    if(parmParent.isHas()&&parmParent.urlParam){
        paraObj=","+parmParent.urlParam+",";
    }
            if (paraObj.indexOf(","+rowdata.user_id+",") == -1)
                return false;
            return true;
}

        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                          noCopy:"id",
                        refField:{},
        		getCols:function(d_){
                           pb.cols=[{ display:getDes('p_tou'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.user_id,19,"user_p_tou",1,'p_tou'+item.__index,item);
}},{"isSort":"false","align":"left","width":100,"name":"user_id","display":getDes('user_id')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"user_name","display":getDes('user_name')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"nick_name","display":getDes('nick_name')},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("gender").data, valueField: 'sValue' },render: function (item){
                        return $pb.select.getObj("gender").map[item.sex][0].text;
                    },"align":"left","width":100,"name":"sex","display":getDes('sex')},{"isSort":"false","align":"left","width":100,"name":"user_rank","display":$pb.lang.readDes(langDesMap,'user_rank'),hide:"true"},{"isSort":"false",render:function(item){var the=$pb.isNull(item.roleIds,"");
var s=[];
$(the.split(",")).each(function(no,v){
   if(v){
      s.push(bRo.map[v][0].pName);
   }
});
var show=s.join(",");
return "<table><tr><td>"+$pb.edit.import_(function(){
         imp.title="选择部门角色";
         parmaMap={     urlParam:item.roleIds,               
              "showMap":{"showMax":false}
         };  
         return pb.manager;                  
 },item.__index,"xt/bm/b.jsp","roleIds","pId",false)+"</td><td>"+$pb.edit.textArea(function(){return pb.manager;},item,'roleIds',{edit:false,cols:10,rows:1,value:show})+"</td></tr></table>";
},"align":"right","width":140,"name":"roleIds","display":getDes("roleIds")},{"isSort":"false",render:function(item){
return item.rName+$pb.edit.import_(function(){
         imp.title="选择角色";
         parmaMap={               checkbox:{checkbox:true,isChecked:function(rowdata){
                    if (item.user_rank!=rowdata.rId)
                          return false;
                  return true;                 
              }},                    
              "showMap":{"showMax":false}
         };  
         return pb.manager;                  
 },item.__index,"xt/js1.jsp","user_rank;rName","rId;rName",false);
},"align":"right","width":100,"name":"rName","display":getDes('rName')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"msn","display":getDes('msn')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"qq","display":getDes('qq')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"home_phone","display":getDes('home_phone')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"mobile_phone","display":getDes('mobile_phone')},{"isSort":"false","editor":{"type":"date",format:"yyyy-MM-dd hh:mm:ss",showTime:true}, render:function(item){
                              return $pb.edit.date({item:item,filed:'sr',gManage:pb.manager});
                           },type:"date","align":"left","width":150,"name":"sr","display":$pb.lang.readDes(langDesMap,'sr')},{ display:getDes('photo'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.user_id,19,"user_photo",1,'photo'+item.__index);
}}];
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
        			var gridInfo={
        	                columns:pb.getCols(true),
        	                enabledEdit: true,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:260,rowHeight:60,pagerRender:function(){
        	                  return $pb.gridToobar.initHtml(gridInfo);
        	                },rownumbers:true,checkbox:true,selectRowButtonOnly:false,
        	                width: '98%' ,height:"96%",checkbox:true,isChecked: f_isChecked
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"/xt/man.do","user_id",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(m){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
if(m!=null){ 
   $pb.mergeMap(parm,m);
}
$pb.gridToobar.pageInfo=$pb.clone(parm);
      $pb.Data.load(parm,tiketMap,pb_UrlId,$pb.grid.pbCol(pb.getCols()),function(data){
       				if(data.code==0){
       				        $pb.gridToobar.render(data.data);       				
       				        gridData=$pb.Data.toGrid(data.data.list);    				   
       					pb.f_initGrid(gridData,"maingrid",m);
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      },'m=get&data=page');	
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
