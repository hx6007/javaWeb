<%@page import="com.pb.factory.FactoryBean"%>
<%@page import="com.pb.service.TableService"%>
<%@page import="com.pb.xml.TName"%>
<%@page import="com.pb.xml.MessageXml"%>
<%@page import="com.util.ItemHelper"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String neiId=StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("neiId")));
String pb_UrlId=StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("urlid")));
if(ItemHelper.isEmpty(neiId)||ItemHelper.isEmpty(pb_UrlId)){
  out.write("没传参数，则没有显示数据");
}else{
    String langNo=StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("langNo")));
    if(langNo==null){
       langNo="1";
    }
    String langNoC=StringEscapeUtils.escapeJavaScript(StringEscapeUtils.escapeHtml(request.getParameter("langNoC")));
    if(langNoC==null){
       langNoC="1";
    }
    TableService table_Ser=(TableService)FactoryBean.getBean("table_Ser");
    Map<String,Object> wMap=new HashMap<String,Object>();
    wMap.put(MessageXml.table_pb, TName.pRepTem);
    wMap.put("pbCol", "repText");
    wMap.put("urlId",pb_UrlId);
    wMap.put("temText","${jsHead}");
     Map<String,Object> vMap=table_Ser.findRow(wMap);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>表单设计器</title>
    <link href="../js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../js/Source/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" /> 
    <link href="../js/Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" />
    <script src="../js/Source/lib/jquery/jquery-1.9.0.min.js"></script>
    <script src="../js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script> 
    <script src="../js/Source/lib/json2.js" type="text/javascript"></script>
    <link href="../js/Source/lab/formdesign/style.css" rel="stylesheet" />
    <script src="../js_/manage.js" type="text/javascript"></script> 
    <script src="../js/Source/lib/json2.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="<%=path%>/favicon.ico" />
     <style type="text/css">
        .middle input {
            display: block;width:30px; margin:2px;
        }
    </style>
    <script type="text/javascript">
var neiId="<%=neiId%>";
var tiketMap=<%=session.getAttribute("ticketMap")%>;
var langNo="<%=langNo%>";
var pb_UrlId="<%=pb_UrlId %>";
var langNoC="1";
var langDesMap;
<%=ItemHelper.isNotEmpty(vMap, "repText")?vMap.get("repText"):""%>
function loadDesNext(fun){
    if(typeof funNext!="function"){
        funNext=function(fun){
           if(typeof fun =="function"){
              fun();
           }
        };
     }
    funNext(fun);
}
    </script>
</head>
<body style="padding:0px;">   
  <div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
        <div position="center"  title="设计表单" id="designPanel" style="overflow: auto"> 
            <div id="btnSelectFields" style="margin:5px; float:left;"></div>
            <div id="btnSaveToFile" style="margin:5px; float:left;"></div><br/><br/>
            <hr/>
            <div id="formDesign" style="clear:both;"></div>
        </div>
        <div position="bottom" id="framecenter" title="属性设置" style="overflow: auto">  
                <div id="formProperty">
                </div>
            <div id="btnSaveProperty" style="margin:5px;"></div>
        </div>  
    </div> 

    <div id="fieldsSelector" style="display:none;">
        <div style="margin:4px;float:left;">
             <div id="listbox1"></div>  
         </div>
         <div style="margin:4px;float:left;" class="middle"> 
              <input type="button" onclick="moveToRight()" value="&gt;" /> 
             <input type="button" onclick="moveAllToRight()" value="&gt;&gt;" />
              <input type="button" onclick="moveToLeft()" value="&lt;" />
              <input type="button" onclick="moveAllToLeft()" value="&lt;&lt;" />
         </div>
        <div style="margin:4px;float:left;">
            <div id="listbox2"></div> 
        </div>  
    </div>
</body>
</html>
<script src="../js_/panDrag.js" type="text/javascript" ></script> 
<%
}
%>