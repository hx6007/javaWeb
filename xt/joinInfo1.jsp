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
        var tiketMap=<%=session.getAttribute("ticketMap")%>;
        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
                        cols:[{"isSort":"false","align":"left","width":100,"name":"id","display":"序号"},{"isSort":"false","align":"left","width":100,"name":"urlId","display":"访问路径对应id"},{"isSort":"false","align":"left","width":100,"name":"urlJoinTable","display":"连接表信息[暂时没用]"},{"isSort":"false","align":"left","width":290,"name":"tableAlias","display":"字段对应别名信息"},{"isSort":"false","align":"left","width":100,"name":"actionDo","display":"do请求",editor: { type: 'text'}},{"isSort":"false","align":"left","width":100,"name":"actionTable","display":"请求表"},{"isSort":"false","align":"left","width":100,"name":"temId","display":"模板页Id"}],
refField:{   urlId:{editor:{type:"text"}},
   tableAlias:{
render:function(item){
return $pb.edit.textArea('pb.manager',item,'tableAlias',{edit:true,cols:40,rows:5});
}
},
   actionTable:{editor:{type:"text"}},
   temId:{editor:{type:"text"}}
//,actionDo:{value:"/xt/man.do",editor: { type: 'select', data: [{text:"/xt/man.do"},{text:"/xt/pOpen.do"},{text:"/lang.do"}], valueColumnName: 'text' }}
},
        		getCols:function(d_){
        		   if(d_){
        		      for(var r_ in pb.refField){        		      
        		       for(var c_ in pb.cols){
        		           if(pb.cols[c_]['name']==r_){
        		              pb.cols[c_]['render']=pb.refField[r_]['render'];
        		              pb.cols[c_]['editor']=pb.refField[r_]['editor'];
                                      pb.cols[c_]['value']=pb.refField[r_]['value'];
        		              break;
        		           }
        		       } 
        		      }     		    
        			}
return pb.cols;
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    pb.manager.addRow(pb.initValue);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},f_initGrid:function(gridData,gridId){
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: [
	        	                { text: '增加', click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: '删除', click: pb.deleteRow, img: '<%=basePath%>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
	        	                { line: true },
	        	                { text: '保存', click: pb.saveAll, icon: 'modify' }
	        	                ]
        	                },
        	                enabledEdit: true,isScroll: false,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:60,rowHeight:80,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,14,"id",'');
        		},loadUrlData:function(){
      $pb.Data.load({},tiketMap,14,$pb.grid.pbCol(pb.cols),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}
      });	
       } };
        $(function(){
        	pb.loadUrlData();
       });
    </script>
</head>
<body  style="padding:0px">
    <div id="maingrid" style="margin-top:5px"></div>
</body>
</html>
