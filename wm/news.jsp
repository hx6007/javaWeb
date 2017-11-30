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
<script src="<%=path%>/js/Source/lib/jquery.cookie.js"></script>
<script src="<%=path%>/js/Source/lib/json2.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/jquery.metadata.js"></script>
<script src="<%=path%>/js/Source/lib/jquery-validation/messages_cn.js"></script>
<script src="<%=path%>/js_/manage.js" type="text/javascript"></script>  
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/favicon.ico" />
    <script type="text/javascript" charset="utf-8" src="<%=path%>/fwb/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/fwb/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=path%>/fwb/lang/zh-cn/zh-cn.js"></script>

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
var action='168';
var pb_UrlId='168';
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
  noCopy:"news_code",
        		getCols:function(d_){
                           pb.cols=[{"isSort":"false","align":"left","width":100,"name":"news_code","display":getDes("news_code")},{ display:getDes('picture'), isSort: false, width: 80, render: function (item){   
      return $pb.Data.loadPic(item.news_code,63,"picture",6,'news_code'+item.__index,item);
}},{"isSort":"false","editor":{"type":"text"},"align":"left","width":100,"name":"title","display":getDes("title")},{"isSort":"false",type:"date",render:function(item){                          
                              return  $pb.edit.date({item:item,filed:'publish_date',gManage:pb.manager});
                           },"align":"left","width":200,"name":"publish_date","display":getDes("publish_date")}

,{ display: getDes('操作'), isSort: false, width: 120, render: function (rowdata, rowindex, value)
                {
                   return "<a href='javascript:pb.show(" + rowdata.news_code+ ")'>详情</a> ";  
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
   var toolBar=[{ text:getDes('高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ line: true },{text:getDes("富文本【保存】"),click:function(){
              pb.save();
          }},{text:getDes("富文本【取消】"),click:function(){
              $('#target1').slideUp();
          }}];
     //$pb.mergeArray(toolBar,morenToobarList);
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: toolBar},
        	                enabledEdit: true,pageSize:20,pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,
        	                width: '98%',height:"96%"//isScroll: false,
        	            };
 if(parmParent.isHas()&&parmParent.checkbox){
        	               $pb.mergeMap(gridInfo,parmParent.checkbox);
        	            }
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"168","news_code",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
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
$(["nextOk","saveOk"]).each(function(i,v){												
    pb.toobar.removeItem(v);
});
      $pb.Data.load(parm,tiketMap,"168",$pb.grid.pbCol(pb.getCols()),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                    }
      });	
       },show:function(no){
             $("#target1").hide();
             var param={pbCol:"news_code,content",news_code:no};
             $pb.Data.load(param,tiketMap,"168",'',function(data){
       				if(data.code==0){
       				    UE.getEditor('editor').setContent(data.data.content, false);     
   			            $("#target1").slideDown();
   			            pb.theTem.temId=no;
       				}
            },"m=get&data=one");	        		
       },theTem:{        		
        	temId:null
       },save:function(){      		   
      			var param={news_code:this.theTem.temId,"content":UE.getEditor('editor').getContent()};
      			$pb.Data.load(param,tiketMap,"168",'',function(data){
      				if(data.code==0){
                          $pb.showMess("保存成功！",1000,function(){
                              $("#target1").slideUp();
                          });
      				}
                },"m=update&data=one");	
	   }
};  
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
			fields : [{"newline":false,"name":"news_code","display":getDes("news_code")},{"newline":false,"name":"picture","display":getDes("picture"),"type":"text"},{"newline":false,"name":"title","display":getDes("title"),"type":"text"},{"newline":false,"name":"publish_date","display":getDes("publish_date"),"type":"text"}]
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
var ue;
$(function(){
    ue= UE.getEditor('editor',{toolbars: [[
            'fullscreen', 'source', '|', 'undo', 'redo', '|',
            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', '|', 
            'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist','|',           
            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',            
            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',           
            'simpleupload', 'insertimage'
        ]]});
});
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
<span id="panFrom1"></span>
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</div>
<div id="target1" style="display:none;margin-top:200px;">
<script id="editor" type="text/plain" style="width:90%;height:400px;"></script>
</div>
</body>
</html>
<script src="<%=path%>/js_/menu_.js" type="text/javascript"></script>  
