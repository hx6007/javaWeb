var tiMapCook=$.cookie('ticketMap');
var tEMapCook=$.cookie('ticketExit');
var ticketExit=null;
$.cookie('itemPath',window.location.href.replace("index.html",''));
if(tiMapCook==null||tiMapCook==""){
    window.location="login.html";
}
if(tEMapCook!=null&&tEMapCook!=""){
  window.location="login.html";
}
var tiketMap=JSON2.parse(tiMapCook);
var user_map=JSON2.parse($.cookie('user'));
var paramMap=$pb.getQueryMap();
var langNo=$pb.isNull(paramMap.langNo,user_map.lNo);
var langNoC=$pb.isNull(paramMap.langNoC,user_map.lNoC);
function loginDo(){
    tiketMap=JSON2.parse($.cookie('ticketMap'));
    $('#loginSpan').html(user_map.nick_name);
    $('#loginToSpan').show();
}
function showLogin(){
    loginMap={
       	title:"再次登录",
        width:380,
        height:360,
        opener:window,
       	url: 'login.html'
    };
    if(tiketMap==null){
       loginMap.allowClose=false;
    }
    $.ligerDialog.open(loginMap);
}
function showUppwd(){
    loginMap={
      	title:"修改密码",
          width:350,
          height:230,
          opener:window,
     	 url: 'uppwd.html'
  };
    if(tiketMap==null){
     loginMap.allowClose=false;
  }
   $.ligerDialog.open(loginMap);
}
var refBoo=true;
showUnload=false;
function exit(){
    refBoo=false;
    tiMapCook=$.cookie('ticketMap');
    if(tiMapCook!=null&&tiMapCook!=""){
      tiketMap=JSON2.parse(tiMapCook);
    }
    exitTo(tiketMap,"login.html");
}
function exitTo(tMap,reLoaction){
   $pb.exit(tMap,reLoaction);
}
var logout_=false;
var searObj;
$(function(){
    loginDo();
    searObj=$("#searchTree").ligerTextBox({ nullText: '输入【标题,页面编号】模糊查询' });
    searObj.bind('ChangeValue', function (value){ pb.tree.getData(); });
          
pb.tree.getData();	      
$(window).bind("beforeunload",function(){
  if(refBoo){
    tiMapCook=$.cookie('ticketMap');
    if(tiMapCook!=null&&tiMapCook!=""){
       return (logout_)?"刷新主窗口页面,未处理数据将丢失，\r\n用户退出！是否继续？":"刷新主窗口页面,未处理数据将丢失，\r\n是否继续？";
    }
 }
});
$(window).unload(function () {
       if(refBoo){
         tiMapCook=$.cookie('ticketMap');
         if(tiMapCook!=null&&tiMapCook!=""&&logout_){	           
            $.cookie('ticketExit',tiMapCook);
         }
       }
    });
 });
var the=localStorage.indexExpand;
if(the==null||the==""){
   localStorage.indexExpand=";";
}
function hasExPand(id){
	return (localStorage.indexExpand.indexOf(";"+id+";")!=-1);
}
pb={tree:{
    getData:function(fun){
		var url="xt/pOpenTree.do?m=get&data=list";
		var param={pbCol:"id,parentId,url,text,des,theNode,isNew"};
		var pz=searObj.getValue();
		if(pz!=""){
		  if(!isNaN(parseInt(pz))){
		     param["id like ?"]="%"+$("#searchTree").val()+"%";
		  }else{
			 param["text like ?"]="%"+$("#searchTree").val()+"%";
			//param["treeImport"]=true;
		 } 			
		}else{
			param["pageType"]=[0,3];//只看流程页与页面，其他单据填写与审判页不显示
		}
		param["add"]="order by porder";
		param=$pb.mergeMap($pb.lang.getlangMap(langNo,langNoC),param);
		$pb.DoUrl(url,param,tiketMap, function(data){
			var treeData = {};
			if(data.code==0){   
				treeData=$pb.findTreeMap(data.data,"id","parentId");
				if(typeof(fun) == 'function'){
				  fun(treeData);
				}else{
				  pb.tree.creatTree(treeData);
				}				
			}else if(data.code==8){
				exitTo(tiketMap,"login.html");
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
	           btnClickToToggleOnly:false,
	           attribute: ['nodename', 'url'],
	           render : function(a){
	           	   if (!a.isNew||a.url==null) return a.text;
	               return '<a href="'+a.url + '" target="_blank">' + a.text + '</a>';
	           },
	           onSelect: function (node){
	               var url=node.data.url;
	               var title=node.data.id+':'+node.data.text;
	               if(url){
	                var tabid = $(node.target).attr("tabid");
	                if (!tabid){
	                    tabid = new Date().getTime();
	                    $(node.target).attr("tabid", tabid);
	                } 
	                f_addTab(tabid, title, url);
	              }
	           },isExpand: function (e){
                     var data = e.data;
                     return  hasExPand(data.id)?true:false;
	           },onExpand:function(node){
	        	   hasExPand(node.data.id)?"":localStorage.indexExpand+=node.data.id+";";
	           },onCollapse:function(node){
	        	   localStorage.indexExpand=localStorage.indexExpand.replace(";"+node.data.id+";",";");
	           }
	       });
       }
    }
};

var tab = null;
var accordion = null;
var tree = null;
var tabItems = [];
$(function (){
$("#layout1").ligerLayout({
    leftWidth: 190,
    height: '100%',
    heightDiff: -34,
    space: 0,
    onHeightChanged: f_heightChanged,
    onLeftToggle: function (){
        tab && tab.trigger('sysWidthChange');
    },onRightToggle: function (){
        tab && tab.trigger('sysWidthChange');
    }
});

var height = $(".l-layout-center").height();

tab = $("#frame_p").ligerTab({
    height: height,
    heightDiff:25,
    showSwitchInTab : true,
    showSwitch: true,                   
    onAfterAddTabItem: function (tabdata){
        tabItems.push(tabdata);
        saveTabStatus();
    },onAfterSelectTabItem:function(tabid){
	    var json=[];
	    var m=null;
       for (var i = 0; i < tabItems.length; i++){
            var o = tabItems[i];
            if (o.tabid == tabid){
                m=$pb.clone(o);
            }else{
               json.push(o);
            }
        }
        if(m!=null){
         json.push(m);
        }
        if(json.length >0){
         saveTabStatus(json);
        }
    },onAfterRemoveTabItem: function (tabid){ 
        for (var i = 0; i < tabItems.length; i++){
            var o = tabItems[i];
            if (o.tabid == tabid){
                tabItems.splice(i, 1);
                saveTabStatus();
                break;
            }
        }                      
    },onReload: function (tabdata){
          var tabid = tabdata.tabid;
          addFrameSkinLink(tabid);
    }
});

//面板
accordion=$("#accordion1").ligerAccordion({
    height: height - 24, speed: null
});

$(".l-link").hover(function (){
    $(this).addClass("l-link-over");
}, function (){
    $(this).removeClass("l-link-over");
});
          

/*function openNew(url){ 
    var jform = $('#opennew_form');
    if (jform.length == 0)
    {
        jform = $('<form method="post" />').attr('id', 'opennew_form').hide().appendTo('body');
    } else
    {
        jform.empty();
    } 
    jform.attr('action', url);
    jform.attr('target', '_blank'); 
    jform.trigger('submit');
};*/


//tab = liger.get("frame_p");
//accordion = liger.get("accordion1");
//tree = liger.get("tree1");
$("#pageloading").hide();
$("#skinSelect").change(function (){ 
    css_init_to(this.value);                    
});
$("#skinSelect").val(cacheCss($pb.getQueryString("skin")));
pages_init();                
});
function f_heightChanged(options){  
    if (tab)
        tab.addHeight(options.diff);
    if (accordion && options.middleHeight - 24 > 0)
        accordion.setHeight(options.middleHeight - 24);
}
function f_addTab(tabid, text, url){
    tab.addTabItem({
        tabid: tabid,
        text: text,
        url: url,
        changeHeightOnResize:true,
        callback: function (){
            //addFrameSkinLink(tabid); 
        }
    });
}
function addFrameSkinLink(tabid){
    var prevHref = getLinkPrevHref(tabid) || "";
    var skin = $pb.getQueryString("skin");
    if (!skin) return;
    skin = skin.toLowerCase();
    attachLinkToFrame(tabid, prevHref + skin_links[skin]);
}
function pages_init(){
    var tabJson =$.cookie('home-p-tab'); 
    if (tabJson){ 
        var tabitems = JSON2.parse(tabJson);
        for (var i = 0; tabitems && tabitems[i];i++){ 
            f_addTab(tabitems[i].tabid, tabitems[i].text, tabitems[i].url);
        } 
    }
}
function saveTabStatus(json){ 
    if(json){
     $.cookie('home-p-tab', JSON2.stringify(json));
    }else{
       $.cookie('home-p-tab', JSON2.stringify(tabItems));
    }
}

function attachLinkToFrame(iframeId, filename){ 
    if(!window.frames[iframeId]) return;
    var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
    var fileref = window.frames[iframeId].document.createElement("link");
    if (!fileref) return;
    fileref.setAttribute("rel", "stylesheet");
    fileref.setAttribute("type", "text/css");
    fileref.setAttribute("href", filename);
    head.appendChild(fileref);
}
function getLinkPrevHref(iframeId){
    if (!window.frames[iframeId]) return;
    var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
    var links = $("link:first", head);
    for (var i = 0; links[i]; i++){
        var href = $(links[i]).attr("href");
        if (href && href.toLowerCase().indexOf("ligerui") > 0){
            return href.substring(0, href.toLowerCase().indexOf("lib") );
        }
    }
}