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
var action='11';
var pb_UrlId='11';
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
      if(typeof fun =="function"){
          fun();
     } 
 }

function f_isChecked(rowdata){
   var paraObj=",";
    if(parmParent.isHas()&&parmParent.urlParam){
        paraObj=","+parmParent.urlParam+",";
    }
            if (paraObj.indexOf(","+rowdata.id+",") == -1)
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
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"id","display":getDes('id')},{"isSort":"false","align":"left","width":100,"name":"type","display":getDes('type'),value:"页面"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"temName","display":getDes('temName')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":200,"name":"temDes","display":getDes('temDes')},{ display: '操作', isSort: false, width: 120, render: function (rowdata, rowindex, value)
                {
                   return "<a href='javascript:pb.show(" + rowdata.id + ")'>查看</a> ";  
}},{ display:$pb.lang.readDes(langDesMap,'picTem'), isSort: false, width: 300, render: function (item){   
      return $pb.Data.loadPic(item.id,16,"pageTemPic2",2,'pageTemPic'+item.__index);
}},{"isSort":"false","align":"left","width":100,"name":"picId","display":$pb.lang.readDes(langDesMap,'picId'),hide:"true"},{"isSort":"false","align":"left","width":100,"name":"filepath","display":getDes('filepath'),hide:"true"},{"isSort":"false","align":"left","width":100,"name":"ptKey","display":getDes('ptKey'),hide:"true"},{"isSort":"false","align":"left","width":100,"name":"tabFiled","display":getDes('tabFiled')}];
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
   var toolBar=[{ text:$pb.lang.readDes(langDesMap,'高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}         
          ,{ line: true }];
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items:toolBar},
        	              enabledEdit: true, pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:260,rowHeight:60,
        	                width: '98%',height:550,checkbox:true,isSingleCheck:true,isChecked: f_isChecked
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"11","id",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
parm.type="页面";
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
      $pb.Data.load(parm,tiketMap,"11",$pb.grid.pbCol(pb.getCols()),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      });	
       } ,show:function(no){
	        		var url=manageUrl+"/xt/pTemJsp.do?m=get&data=one";
	        		var param={pbCol:"id,temText",id:no};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        					pb.theTem.temId=no;
        				    $('#temT').val(data.data.temText);
        					pb.theTem.temDiv=$.ligerDialog.open({
		        			   width:880,
		        			   height:500,showToggle: true,
    		                     buttons:[
    		                 { text: '保存', onclick: function(item,dialog){
                                       pb.save();	        
    		     	               dialog.hide();
    		     	            } 
    		                 },
    		                 { text: '取消', onclick:function(item, dialog){ dialog.hide();}}
    		 ],
				               target: $("#target1")	                
            				});
        				}
                    });
        		},theTem:{
        		   temDiv:null,
        		   temId:null
        		},save:function(){
        		   	var url=$pb.manageUrl+"/xt/pTemJsp.do?m=update&data=one";
        			var param={id:this.theTem.temId,"temText":$('#temT').val()};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
$pb.showMess("保存成功！",1000);
        				}
                    });	
}  }; 
function yeLoad(){
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
$pb.lang.load(langNo,tiketMap,function(data){
         loadMenu(data);
         pb.loadUrlData();     
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
<div id="target1" style="display:none;">
    <textarea id="temT" cols="100" rows="30" style="margin: 0px; width: 850px; height:423px;"></textarea>  
 </div></div>
<br/>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
