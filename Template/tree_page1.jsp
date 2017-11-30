<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
        <link href="<%=basePath%>js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        </style>
        <script src="<%=basePath%>js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>   
<script src="<%=basePath%>js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>  
 <script src="<%=basePath%>js/Source/lib/jquery.cookie.js"></script>
         <script src="<%=basePath%>js/Source/lib/json2.js"></script>
          <script src="<%=basePath%>js/manage.js"></script>
            <script type="text/javascript">
          //  alert(ni)
             var tiketMap=JSON2.parse($.cookie('ticketMap'));
        var paramMap=$pb.getQueryMap();
        var langNo=$pb.isNull(paramMap.langNo,1);
        var langNoC=$pb.isNull(paramMap.langNoC,1);
                $(function (){
                    parmaMap={"id":""};
                    $pb.dialog.init();
					pb.tree.getData();
                    $("#layout1").ligerLayout({ height: '600',leftWidth: 200});
                });   
                 pb={tree:{
             getData:function(fun){
                var url=$pb.Data.loadUrl('xt/pOpenTree.do','m=get&data=list');
      			var param={pbCol:"id,parentId,text,isexpand"};
      			param=$pb.mergeMap($pb.lang.getlangMap(langNo,langNoC),param);
      			//param["add"]="order by porder";     	     			
      			$pb.DoUrl(url,param,tiketMap, function(data){
      				var treeData = {};
      				if(data.code==0){
      					treeData=$pb.findTreeMap(data.data,"id","parentId",{"isexpand":{"0":"false","1":true}});
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
                },creatTree:function(data){ //树
	               $("#tree1").ligerTree({
	                   data : data,
	                   checkbox: false,
	                   slide: false,
	                   nodeWidth: 100,
	                   render : function(a){
	                       return a.id+':'+a.text;	                       
	                   },
	                   onSelect: function (node){
	                      parmaMap={"or":{"parentId":node.data.id},"treeImport":true};
	                     rightFrame.$("#title").val('');
	                      $pb.dialog.init();
	                      rightFrame.pb.loadUrlData();
	                       parent.g.getPanels()[0].panel.frame.aa();
	                   }
	               });
	                $("#accordion1").each(function () {
                       $(this).height($(this).parent().height() - $(this).prev().height());
                    });
	               
                }
               }
            };
            function aa(){
               alert(1);
            }
         </script> 
        <style type="text/css">
            body{ padding:5px; margin:0; padding-bottom:15px;}
            #layout1{  width:100%;margin:0; padding:0;height:300  }  
            .l-page-top{ height:80px; background:#f8f8f8; margin-bottom:3px;}
                </style>
    </head>
    <body style="padding:10px">  
      <div id="layout1">
            <div position="left" id="accordion1" style="overflow: auto"><ul id="tree1" style="margin-top:3px;"></ul></div>
            <div position="center" >
<iframe width="100%" height="100%"  name="rightFrame" id="rightFrame" src="<%=basePath%>xt/pOpenTree.jsp"></iframe>
            </div>  
        </div> 
    </body>
    </html>