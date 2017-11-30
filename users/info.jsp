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
var action='182';
var pb_UrlId='182';
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
                           pb.cols=[{isSort:"false",editor:{"type":"text"},type:"hidden",align:"left",width:"100",name:"id",display:getDes("id"),oldtype:"int"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"type",display:getDes("type"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"customer_no",display:getDes("customer_no"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"username",display:getDes("username"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"customer_type_id",display:getDes("customer_type_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"name",display:getDes("name"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"contact",display:getDes("contact"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"mobile",display:getDes("mobile"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"province",display:getDes("province"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"city",display:getDes("city"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"district",display:getDes("district"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"address",display:getDes("address"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"landline",display:getDes("landline"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"email",display:getDes("email"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"qq",display:getDes("qq"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"market",display:getDes("market"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"head",display:getDes("head"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"head_mobile",display:getDes("head_mobile"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"business_scope_ids",display:getDes("business_scope_ids"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"operation_type_id",display:getDes("operation_type_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"warehouse_id",display:getDes("warehouse_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"store_feature_id",display:getDes("store_feature_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"platform_id",display:getDes("platform_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"customer_classify_id",display:getDes("customer_classify_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"service_warehouse_id",display:getDes("service_warehouse_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"active",display:getDes("active"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"department_id",display:getDes("department_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"has_sso_account",display:getDes("has_sso_account"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"created_at",display:getDes("created_at"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"updated_at",display:getDes("updated_at"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"company",display:getDes("company"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"is_check",display:getDes("is_check"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"info_source",display:getDes("info_source"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"wechat",display:getDes("wechat"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"sex",display:getDes("sex"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"online_group_id",display:getDes("online_group_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"online_service_person_id",display:getDes("online_service_person_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"team_size",display:getDes("team_size"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_team",display:getDes("working_team"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_life",display:getDes("working_life"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_years",display:getDes("working_years"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_province",display:getDes("working_province"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_city",display:getDes("working_city"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_district",display:getDes("working_district"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_case",display:getDes("working_case"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"designer_level",display:getDes("designer_level"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"design_case",display:getDes("design_case"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"business_area",display:getDes("business_area"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"referrer",display:getDes("referrer"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"staff_id",display:getDes("staff_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"street",display:getDes("street"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"working_street",display:getDes("working_street"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"is_leader",display:getDes("is_leader"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"staff_category_id",display:getDes("staff_category_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"offline_group_id",display:getDes("offline_group_id"),type:"hidden",oldtype:"text"},{isSort:"false",editor:{"type":"text"},align:"left",width:"100",name:"offline_service_person_id",display:getDes("offline_service_person_id"),type:"hidden",oldtype:"text"}];
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
,f_initGrid:function(gridData,gridId,pageInfo){
	if(pageInfo==null){
	    pageInfo=$pb.gridToobar.pageInfo;
	}
   pb.theGridData=gridData;
   var toolBar=[{ text:getDes('高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ line: true }];
    // $pb.mergeArray(toolBar,morenToobarList);
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items:toolBar },
        	                enabledEdit: false,isScroll: false,pageSize:$pb.isNull(pageInfo.page_size,20),pageSizeOptions:[10,20,50,100,500],
        	                data: gridData,detailHeight:260,rowHeight:24,pagerRender:function(){
        	                  return $pb.gridToobar.initHtml(gridInfo);
        	                },
        	                width: '98%'
        	            };
$(["add","delete","copyRow","save","nextOk","saveOk"]).each(function(i,v){
    pb.toobar.removeItem(v);
});
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"182","id",pb.loadUrlData(),$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(m){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
if(parmParent.isHas()){
        $pb.mergeMap(parm,parmParent.get());
}
parm["page_size"]=20;
if(m!=null){
   $pb.mergeMap(parm,m);
}
$pb.gridToobar.pageInfo=$pb.clone(parm);
      $pb.Data.load(parm,tiketMap,"182",$pb.grid.pbCol(pb.getCols()),function(data){
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
        $pb.lang.load(langNo,tiketMap,function(data){
loadMenu(data);         pb.loadUrlData();
});
});
    });
}
function loadLang(){

}
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
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
</div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
