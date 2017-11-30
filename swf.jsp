<%@page import="com.util.ItemHelper"%>
<%@page import="com.pb.servlet.BuildFormat"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
Map<String,Object> paramMap1=BuildFormat.getParam(request, response);
 StringBuffer parmBuffer=new StringBuffer();
 StringBuffer addBuffer=new StringBuffer();
parmBuffer.append("allParam=format_pb").append(request.getParameter("format"));//
addBuffer.append("printformat=").append(request.getParameter("format"));
String notInKey="format;";
Map<String,Object> paramMap=null;
if(paramMap1.containsKey("mapParm")){
   paramMap=(Map<String,Object>)paramMap1.get("mapParm");
}
for(String key:paramMap.keySet()){
   if(key.indexOf(".")!=-1){
     continue;
   }
   if(notInKey.indexOf(key+";")==-1){
      parmBuffer.append("_fen").append(key).append("_pb").append(paramMap.get(key));
      addBuffer.append("_fen").append(key).append("_pb").append(paramMap.get(key));
   }
}
  String _print= String.valueOf(ItemHelper.isNull(request.getParameter("print"),"0"));
  String Formats=request.getParameter("Formats");
  Formats=(Formats!=null&&!Formats.equals("null"))?Formats.replaceAll(",",";"):"html";//测试使用
  String FlashVars="jrpxml="+ItemHelper.getItemUrl()+"/XmlServlet?"+parmBuffer.toString()+"&fetchSize=3";//;+"&printNum=setPrintNum.do?"+addBuffer.toString() 
   out.write(FlashVars);
	//jrpxml 为获得报表路径   fetchSize 应该为查询页面大小比如一次查3页(但第一次总是为查询一页)
	//printNum=控制打印次数调用  printLoad=1 即加载就直接打印
	//添加了xAdd参数 为控制报表宽度追加数，发现很多报表内容大于设置纸张宽度，那报表不至于显示滚动条加这参数，叫报表重设计改动麻烦 也就是为了显示一下，虽设置出错还是可以打印完整
	//如果不当当是显示问题，则必须改报表的还是请改报表，这参数只为显示需要
%>
<html>
<head>
<title>
pengbei：flash打印
</title>
</head>
<body bgcolor="white" topmargin="0" leftmargin="0">
<object width="100%" height="98%">
  <param name="movie" value="<%=FlashVars %>"/>
  <embed src="jasperreports-flash-4.0.0.swf"  FlashVars="<%=FlashVars %>" width="100%" height="98%"></embed>
</object>
</body>
</html>
