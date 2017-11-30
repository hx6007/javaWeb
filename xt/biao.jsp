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
    <title>页面字段控制</title>
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
var action='20';
var pb_UrlId='20';
        var manageUrl=$pb.manageUrl;
 function funNext(fun){
      if(typeof fun =="function"){
          fun();
     } 
 }
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{},
  noCopy:"id",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"pFid","display":getDes('pFid'),hide:"true",render:function(item){
   return '<INPUT   TYPE= "text" style="width:100%;height:100%;"  disabled= "true"   value= "'+item.pFid+'">';
}},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pPageNo","display":getDes('pPageNo'),hide:"true"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"pTField","display":getDes('pTField')},{"isSort":"false","editor":{"type":"text"},"align":"left","width":120,"name":"des","display":getDes('pTFDes'),frozen:true},{"isSort":"false","editor":{"type":"int"},type:"int","align":"left","width":100,"name":"pTdOrder","display":getDes('pTdOrder'),isSort:true},{"isSort":"false", render: function (item){
   return $pb.edit.textArea('pb.manager',item,'pTDgrid',{edit:true,cols:26,rows:3}); 
 }
,"align":"left","width":200,"name":"pTDgrid","display":getDes('pTDgrid')},{"isSort":"true","editor":{"type":"int"},type:"int","align":"left","width":100,"name":"pFOrder","display":getDes('pFOrder'),isSort:true},{"isSort":"false",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'pFFrom',{edit:true,cols:26,rows:3}); 
 }
,"align":"left","width":200,"name":"pFFrom","display":getDes('pFFrom')},{"isSort":"false","align":"left","width":240,"name":"sKey","display":getDes('sKey'),hide:"true"},{"isSort":"false","editor":{"type":"text"},"align":"left","width":120,"name":"showCol","display":getDes('showCol')}];
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
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: [ 
                                       { text:$pb.lang.readDes(langDesMap,'高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'},{ line: true },{ text:$pb.lang.readDes(langDesMap,'导入控件') , click: function(){
$.ligerDialog.confirm('导入将修改当前设置，是否继续?', function (yes) {
                                        if(yes){daoru();}
});
}, icon: 'back' },

{ text:$pb.lang.readDes(langDesMap,'导出控件') , click: function(){
                                           var theMap=pb_Pan.getData();
	        	                   var saveing= $.ligerDialog.waitting($pb.lang.readDes(langDesMap,'正在导出...'));
	        	                   $pb.Data.load({},tiketMap,"xt/tb.do",'',function(data){
	        	                   setTimeout(function (){
                                      saveing.close();
                                   }, 1000);  
	        	                   if(data.code==0){
	        	                      $pb.showMess(getDes("导出成功"),200);	  
	        	                     }else{
	        	                       $pb.showMess(data.messageTxt,1000);	        	                       
	        	                     }
	        	                   },"m=export&urlId="+theMap.pPageNo);
 }, icon: 'prev' },
	        	                ]
        	                },
        	                enabledEdit: true,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                detailHeight:260,rowHeight:40,
        	                width: '98%' ,height:'96%', checkbox: true,where : f_getWhere(),data: $.extend(true,{},gridData)
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"20","pFid",function(){
$pb.showMess("保存成功",1000,function(){
  pb.loadUrlData();
});
},$pb.lang.getlangMap(langNo,langNoC));
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
             parmMap[i]=n;       
     }
   });
     $pb.mergeMap(parm,parmMap);
if(!parm.hasOwnProperty("add")){
  parm["add"]="order by pTdOrder";
}
      $pb.Data.load(parm,tiketMap,"20",$pb.grid.pbCol(pb.getCols()),function(data){
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
if(load==0){
var saveFrom='panFrom2';
$("#panFrom1").html('<span id="'+saveFrom+'"></span>');
       pb_Pan=$("#"+saveFrom).ligerForm({
			inputWidth : 170,
			labelWidth : 120,
			labelAlign:"right",
			space : 2,
			fields : [{"newline":false,name:"des","display":getDes('pTFDes'),"type":"text"},{"newline":false,"name":"pFFrom","display":getDes('pFFrom'),"type":"text",render: function (item){
   return $pb.edit.textArea(function(){return pb.manager;},item,'pFFrom',{edit:true,cols:26,rows:3}); 
 }
},{"newline":false,"name":"pFOrder","display":getDes('pFOrder'),"type":"int"},{"newline":false,"name":"pTDgrid","display":getDes('pTDgrid'),"type":"text"},{"newline":false,"name":"pTdOrder","display":getDes('pTdOrder'),"type":"int"},{"newline":false,"name":"pFid","display":getDes('pFid')},{"newline":false,"name":"pPageNo","display":getDes('pPageNo'),"type":"text"},{"newline":false,"name":"pTField","display":getDes('pTField'),"type":"text"}]
	});
	 var obj = {   pPageNo:20        
         };
	if(parmParent.isHas()){
	  parmParent.get();
          $pb.mergeMap(obj,parmParent.panelMap);
	}
         pb_Pan.setData(obj);
load=1;
}
         pb.loadUrlData();
        $pb.lang.load(langNo,tiketMap,loadMenu);        
    });           
}  
function loadLang(){
$(function(){
  $("#bg").html(getDes("bg")+"：");
  $("#mb").html(getDes("mb")+"：");
});
}  
function daoru(){
  
                                           var theMap=pb_Pan.getData();
	        	                   var saveing= $.ligerDialog.waitting($pb.lang.readDes(langDesMap,'正在导入...'));
	        	                   $pb.Data.load({},tiketMap,"xt/tb.do",'',function(data){
	        	                   setTimeout(function (){
                                      saveing.close();
                                   }, 1000);  
	        	                   if(data.code==0){
	        	                       location.reload();
	        	                     }else{
	        	                       $pb.showMess(data.messageTxt,1000);	        	                       
	        	                     }
	        	                   },"m=import&urlId="+theMap.pPageNo);
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
<span id="panFrom1"></span>
<span id="panFrom111" class="l-form" ligeruiid="panFrom211">
<div class="l-form-container">
	<ul>
		<li class="l-fieldcontainer l-fieldcontainer-first" fieldindex="0">
			<ul>
				<li style="width:120px;text-align:right;" id="bg"></li>
				<li style="width:170px;text-align:left;">
					<div style="width: 168px;"><input type="checkbox" id="max" onclick="f_search(this)" />
					</div>
				</li>
				<li style="width:120px;text-align:right;" id="mb"></li>
				<li  style="width:170px;text-align:left;">
					<div  style="width: 168px;"><input type="checkbox" id="min" onclick="f_search(this)"/>
					</div>
				</li>
				<li style="width:2px;"></li>
			</ul>
		</li>
	</ul>
</div>
<script>
var max,min;
function f_search(t)
        {    
            (t.id=="max")?max=t.checked:min=t.checked;           
            pb.manager.options.data = $.extend(true, {}, pb.theGridData);
            pb.manager.loadData(f_getWhere());
        }
        function f_getWhere()
        {
            if (!pb.manager) return null;
var show=function(o,t,p){
    return p?(o !=-1)&&($pb.isNull(t,'').indexOf("//{")!=0):true;
};
var clause = function (rowdata, rowindex){                     
    return show(rowdata.pTdOrder,rowdata.pTDgrid,max)&&show(rowdata.pFOrder ,rowdata.pFFrom,min);
};
 return clause; 
}
</script>
</span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
