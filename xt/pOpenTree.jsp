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
var action='/xt/pOpenTree.do';
var pb_UrlId='3';
        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
                        cols:null,
                        refField:{  "parentId":{
        			  data:null,
        			  gridData:null,
        			  setGridData:function(gd){
	                           var d=gd;        		        
        			     this.gridData=d;
        			     this.editor.grid.data=d;
        			  },
        			  setData:function(d_){
        			     var d=d_;        		            
        			     this.data=d;
        			  },
        			  editor:{
                            "type": "popup", "valueField": "id", "textField": "text", "grid":
                            {
                                "data":null,tree: { columnId: 'id1' },  "columns": [
                               { "name": "text","id":"id1", "width": 200, "display": "标题" },
                               { "name": "id", "width": 200, "display": "序号" }, 
                               { "name": "parentId", "width": 200, "display": "父节点" },{ "name": "theNode", "width": 200, "display": "节点树" }]
                            },
                            "onSelected":function (e) { 
				var grid =pb.manager;
				var selected = e.data[0]; 
                                if(pb.checkError(grid.lastEditRow,selected)){
					$.ligerDialog.waitting('您的选择有误，请重新选择！！！');
				        setTimeout(function () {
				              $.ligerDialog.closeWaitting();
				         }, 1000);
					 this.setValue(grid.lastEditRow.parentId);
					 return false;
				}
                                grid.lastEditRow.parentId=selected.id;
				grid.lastEditRow.theNode=selected.theNode+"-"+selected.id;  
  			   },
                            "searchClick": function (e){
                                alert("这里可以根据搜索规则来搜索（下面的代码已经本地搜索),搜索规则:" + liger.toJSON(e.rules));
                                e.grid.loadData($.ligerFilter.getFilterFunction(e.rules));
                            }
                        },render:function (item)
        	              {
        	                   d=pb.refField["parentId"].data;
        	                   for(var the in d){
        	                       if(d[the]["id"]==item.parentId){
        	                         return d[the]['text'];
        	                       }
        	                    } 
        	                    return '未知';               
        	              }
}},
        		getCols:function(d_){
                           pb.cols=[{"align":"left","editor":{"type":"text"},"width":200,"name":"text","display":getDes("text"),id:"id1",frozen: true },{"editor":{"type":"int"},type:"int","align":"left","width":80,"name":"porder","display":getDes('porder') },{"editor":{"type":"text"},"align":"left","width":150,"name":"url","display":getDes("url"),
render:function(item){   
    if(item.url==""){   
       item.url=null;
    }
   return ($pb.isNull(item.url,"")!="") ?'<a href="'+itemPath+item.url+'" target="_blank">'+item.url+'</a>':"";
}
},{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'isexpand',true);},"align":"left","width":60,"name":"isexpand","display":getDes('isexpand')},{ "render": function (item){return $pb.edit.checkEdit('pb.manager',item,'isNew',true); },
        "align":"left","width":60,"name":"isNew","display":getDes('isNew')},{"isSort":"false","editor":{ type: 'select', data: $pb.select.getObj("pageType").data, valueField: 'sValue' },render: function (item){
                        return $pb.select.getObj("pageType").map[$pb.isNull(item.pageType,0)][0].text;
                    },"align":"left","width":100,"name":"pageType","display":getDes('pageType')},{"align":"left","width":50,"name":"id","display":getDes("id")},{"name": "parentId", "display":getDes("parentId"), "width": 100, "align": "left","value":"0"},{"align":"left","width":100,"name":"theNode","display":getDes('theNode'),"value":"A-0"},{ display:getDes("模板"), isSort: false, width: 420, "align":"left",render: function (rowdata, rowindex, value){
                    var h = "";
 if(rowdata.url&&rowdata.url.indexOf('?')==-1&&rowdata.pageType!=3){
var urlId=rowdata.id;
var tem=getDes("模板");
                        h += "<a href='javascript:pb.show(" +urlId + ")'>"+tem+"</a> ";
tem=getDes("生成");
                        h += "<a href='javascript:pb.bulid(" +urlId + ")'>"+tem+"</a> "; 
 h +="&nbsp;"+$pb.edit.import_(function(){
   parmaMap={};  parmaMap.id= urlId ;
},"","xt/joinInfo_m.jsp","","",false);

tem=getDes("字段设置");
h+="&nbsp;"+$pb.edit.import_(function(){
imp.title=rowdata.id+":"+tem;
parmaMap={};
parmaMap["initValue"]={
"pPageNo":urlId
};
parmaMap["panelMap"]={
"pPageNo":urlId
};},'','xt/biao.jsp','','',false,tem);

tem=getDes("内模板");
h+="&nbsp;"+$pb.edit.import_(function(){
imp.title=rowdata.id+":"+tem;
parmaMap={};
parmaMap["ifnull((case urlId when '' then null else urlId end),'"+urlId+"')"]=urlId;
parmaMap["initValue"]={
"urlId":urlId
};},'','xt/pr.jsp','','',false,tem);

tem=getDes("流程控制");
h+="&nbsp;"+$pb.edit.import_(function(){
imp.title=rowdata.id+":"+tem;
 parmaMap={}; parmaMap.pcUrlId=urlId ;
parmaMap["initValue"]={
"pcUrlId":urlId
};},"","xt/lc.jsp","","",false,tem);
tem=getDes("语言描述");        
h+="&nbsp;"+$pb.edit.import_(function(){
imp.title=urlId+":"+tem;
 parmaMap={}; parmaMap.uId=urlId ;},"","xt/des.jsp","","",false,tem);                      
                    return h;
 }
}
},{"editor":{"type":"text"},"align":"left","width":400,"name":"des","display":getDes('des')}];
pb.cols=$pb.grid.repColConfig(pb.cols,d_,pb.refField);
return pb.cols;
        		},addNewRow:function(){
        		    var row = pb.manager.getSelectedRow();
        		    if(pb.initValue==null){
	        			pb.initValue=$pb.grid.initRow(pb.getCols());
        			}
        		    if(row){
        		        pb.initValue["parentId"]=row["id"];
        		        pb.initValue["theNode"]=row["theNode"]+"-"+pb.initValue["parentId"];
        			}
        		     if (pb.manager.isLeaf(row)){
		               row.children=[];
		            }
		            pb.manager.add($pb.clone(pb.initValue), null, true, row);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},theGridData:null
,f_initGrid:function(gridData,gridId){
   pb.theGridData=gridData;
   var toolBar=[{ text:$pb.lang.readDes(langDesMap,'高级自定义查询') , click: function(){
                                                pb.manager.options.data =  pb.theGridData;
                                                pb.manager.showFilter();
                                         }, icon: 'search2'}
          ,{ text:$pb.lang.readDes(langDesMap, '收缩全部'), click: function(){pb.manager.collapseAll();}, icon: 'refresh' }
          ,{ line: true },{text:getDes('生成所有'),click:function(){
        	   $pb.bulid("",tiketMap,function(){});
	        },icon:'right'}];
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items:toolBar},
        	                enabledEdit: true,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:260,rowHeight:24,
                                tree: { columnId: 'id1' },    
        	                width: '98%',height:'96%',isSingleCheck:true,checkbox:true,autoCheckChildren:false
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
if(gridData.length>0){
  pb.manager.select(0);
}
$('#spanGridHid').html($('#spanGrid').html());
$('#spanGridHid').hide();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,"/xt/pOpenTree.do","id",pb.loadUrlData,$pb.lang.getlangMap(langNo,langNoC));
        		},loadUrlData:function(){
$('#spanGridHid').show();
$('#spanGrid').html('<div id="maingrid" style="margin-top:5px"></div>');
var parm=$pb.lang.getlangMap(langNo,langNoC);
var title=$("#title").val();
if(title!=""){
parm["text like ?"]="%"+title+"%";
 parm["treeImport"]=true;
}
if(parmParent.isHas()&&typeof parm["text like ?"]=="undefined"){
        $pb.mergeMap(parm,parmParent.get());
}
parm["add"]="order by porder";
      $pb.Data.load(parm,tiketMap,"/xt/pOpenTree.do",$pb.grid.pbCol(pb.getCols()),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){        				  
        				gridData.Rows=$pb.findTreeMap(data.data,'id','parentId');
        				gridData.Total=gridData.Rows.length;	   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                       pb.f_initGrid('',"maingrid");
                                }
      });	
       },show:function(no){
        		   	var url=$pb.manageUrl+"/xt/pOpenTree.do?m=get&data=one";
        			var param={pbCol:"id,jspText",id:no};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        					pb.theTem.temId=no;
        				    $('#temT').val(data.data.jspText);
                                             pb.showTemButton();
        					pb.theTem.temDiv=$.ligerDialog.open({
		        			   width:880,
		        			   height:500,showToggle: true,
    		                     buttons:[        { text: '模板导入', onclick: function(item,dialog){
                                         $.ligerDialog.confirm('导入将先清除现有代码', function (yes) { 
    		                         if(yes){
    		                            pb.imporTem();
    		                         }
    		                        });
    		     	            } 
    		                 },
    		                 { text: '保存', onclick: function(item,dialog){
                                       pb.save();
    		     	            } 
    		                 }, { text: '生成', onclick: function(item,dialog){
                                       pb.bulid();
    		     	            } 
    		                 },
    		                 { text: '取消', onclick:function(item, dialog){ dialog.hide();}}
    		 ],
                                                  title:'节点'+no+'脚本查看',
				               target: $("#target1")	                
            				});
            			}
            		});
        		},bulid:function(no){
        			if(!no){
        			  no=pb.theTem.temId; 
        			}
        		    $pb.bulid(no,tiketMap,function(){});
        		},theTem:{
        		   temDiv:null,
        		   temId:null
        		},save:function(){
        		   	var url=$pb.manageUrl+"/xt/pOpenTree.do?m=update&data=one";
        			var param={id:this.theTem.temId,"jspText":$('#temT').val()};
                                param=$pb.mergeMap($pb.lang.getlangMap(langNo,langNoC),param);
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				  $.ligerDialog.waitting('保存成功！');
		                          setTimeout(function ()
		                          {
		                         $.ligerDialog.closeWaitting();
		                          }, 1000);
                                             pb.showTemButton();
        				}
                    });	
        		},gridData:null ,imporTem:function(){
                           $('#temT').val('');
        		    var url=$pb.manageUrl+"/xt/pOpenTree.do?m=imp&id="+this.theTem.temId;
        			var param={};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				    $('#temT').val(data.data.jspText);
                            pb.showTemButton();
        				}else{
                                       $.ligerDialog.warn("对应设置写清楚：连表控制");
                                    }
                    });	
        		},showTemButton:function(){
       				var temText=$('#temT').val();
     				if(temText==""){
     				    $("#imTem").show();
     				}else{
     				    $("#imTem").hide();
     				}
        		},
        		checkError:function(parent,nodeRow){
		       		var bool = false;
		       		if(parent.id==nodeRow.id){
		       			return true;
		       		}
		       		if(parent.children){
			       		for(var par in parent.children){	       			
			       			bool = pb.checkError(parent.children[par],nodeRow);
			       			if(bool){
			       				return bool;
			       			}
			       		}
		       		}
		       		return false;
     		  } }; 
function yeLoad(){
$pb.select.get("pageType",function(sdate){  
    $pb.lang.loadDes(langNo,tiketMap,pb_UrlId,function(data){
        langDesMap=data;
         $pb.lang.load(langNo,tiketMap,function(data){
             loadMenu(data);   $pb.Data.load($pb.lang.getlangMap(langNo,langNoC),tiketMap,"/xt/pOpenTree.do",$pb.grid.pbCol(pb.refField['parentId'].editor.grid.columns),function(data){
        			var gridData = {Rows:[],Total:0};
        			if(data.code==0){  
                                       data.data.push({"id":0,"text":"起点","parentId":"A0","theNode":"A"});      				  
        				gridData.Rows=$pb.findTreeMap(data.data,'id','parentId'); 
       				    gridData.Total=gridData.Rows.length;
       				    pb.refField['parentId'].setGridData(gridData);
       				    pb.refField['parentId'].setData(data.data);	
				        pb.loadUrlData();				      
       				}
      }); 
 });
    });  
});         
} 
function loadLang(){
 $('#titleDes').html($pb.lang.readDes(langDesMap, 'title'));
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
<span id="titleDes"></span>：<input type="text" value="" id="title" />
<div id="spanGrid"></div>
<div id="spanGridHid" style="display:none"></div>
<div id="target1" style="display:none;">
    <textarea id="temT" cols="100" rows="30" style="margin: 0px; width: 850px; height: 423px;"></textarea>
    <br />
    <div style="text-align: center;display:none;"><input type="button" id="imTem" onclick="pb.imporTem()" value="模板导入"/>&nbsp;<input type="button" onclick="pb.save()" value="保存"/>&nbsp;<input type="button" onclick="pb.bulid()" value="生成" /></div>
 </div>
</div>
</body>
</html>
<script src="<%=path%>/js/menu_.js" type="text/javascript"></script>  
