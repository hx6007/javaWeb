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
        <link href="<%=basePath%>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        </style>
        <script src="<%=basePath%>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>   
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>  
 <script src="<%=basePath%>/js/Source/lib/jquery.cookie.js"></script>
         <script src="<%=basePath%>/js/Source/lib/json2.js"></script>
          <script src="<%=basePath%>/js_/manage.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="<%=path%>/favicon.ico" />
            <script type="text/javascript">
             var tiketMap=<%=session.getAttribute("ticketMap")%>;
        var paramMap=$pb.getQueryMap();
 var user_map=JSON2.parse($.cookie('user'));
var is_super="<%=issuper%>";
var tree;
        var langNo=$pb.isNull(paramMap.langNo,user_map.lNo);
        var langNoC=$pb.isNull(paramMap.langNoC,user_map.lNoC);
                $(function (){
                    parmaMap={"id":""};
                    $pb.dialog.init();
					pb.tree.getData();
                    $("#layout1").ligerLayout({ leftWidth: 200,allowLeftCollapse:false});
                });
                 pb={tree:{
             getData:function(fun){
      			var param={};
      			param=$pb.mergeMap($pb.lang.getlangMap(langNo,langNoC),param);
      			//param["add"]="order by porder";     	     			
      			$pb.Data.load(param,tiketMap,"8","id,parentId,text",function(data){
      				var treeData = {};
      				if(data.code==0){   
      					treeData=$pb.findTreeMap(data.data,"id","parentId");
      					if(typeof(fun) == 'function'){
      					  fun(treeData);
      					}else{
      					  pb.tree.creatTree(treeData);
      					}				
      				}else{
      				    pb.tree.creatTree({});
      				    $.ligerDialog.warn(data.messageTxt);
      				}
                  });		
                },creatTree:function(data){//树                    
	               tree=$("#tree1").ligerTree({
	                   data : data,
	                   checkbox: false,
	                   slide: false,
	                   nodeWidth: 100,	                 
	                   render : function(a){
	                       return a.id+':'+a.text;	                       
	                   },onSelect: function (node){
	                   parmaMap={"100":"(parentId='"+node.data.id+"' or id='"+node.data.id+"')"};
	                     rightFrame.$("#title").val('');
	                      $pb.dialog.init();	                    
	                       rightFrame.pb.loadUrlData();            
	                   },isExpand: function (e){
	                	   var the=localStorage.treedExpand;
		  	        	   if(the==null||the==""){
		  	        		   localStorage.treedExpand=";";
		  	        	   }
	                       var data = e.data;
	                       return  localStorage.treedExpand.indexOf(";"+data.id+";")!=-1?true:false;
		  	    },onExpand:function(node){
		  	        	   var id=node.data.id;
		  	        	   localStorage.treedExpand.indexOf(";"+id+";")!=-1?"":localStorage.treedExpand+=id+";";
		  	           },onCollapse:function(node){
		  	        	   localStorage.treedExpand=localStorage.treedExpand.replace(";"+node.data.id+";",";");
		  	           }
	               });
                    $("#accordion1").each(function () {
                       $(this).height($(this).parent().height() - $(this).prev().height());
                    });
                }
               }
            };
 $(function(){
			   $("#topmenu").ligerMenuBar({ items: [
			        {text:'新页卡',click:function(item){
			        	window.open(location.href);
			        }}
			    ]
		   	   });
            });
         </script> 
        <style type="text/css">        
            #layout1{  width:98%;margin:0; padding:0;  }  
            .l-page-top{ height:80px; background:#f8f8f8; margin-bottom:3px;}       
        </style>
    </head>
    <body style="padding:0px">  
      <div id="layout1">
            <div position="left" id="accordion1" style="overflow: auto"><ul id="tree1" style="margin-top:3px;"></ul></div>
            <div position="center" ><div id="showMenu">
<div id="topmenu"></div>
<div id="toptoolbar"></div>
</div>
<iframe width="100%" height="100%"  name="rightFrame" id="rightFrame" src="<%=basePath%>/xt/pOpenTree.jsp" onload="tree.selectNode(function (data){return data.treedataindex==0;});"></iframe>
            </div>  
        </div> 
    </body>
    </html>
