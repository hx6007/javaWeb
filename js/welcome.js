var LINKWIDTH = 120, LINKHEIGHT = 130, TASKBARHEIGHT = 43;
var winlinksul =  $("#winlinks ul");
function f_open(url, title, icon) {
    parmaMap={showToParent:1};
    var win = $.ligerDialog.open(
    {opener:window, height: 500, url: itemPath+url, width: 600, showMax: true, showToggle: true, showMin: true, isResize: true, modal: false, title: title, slide: false, buttons: [
        { text: '确定', onclick: function (item, Dialog, index) {
            win.hide();
        }
        }
    ]
    });
    var task = jQuery.ligerui.win.tasks[win.id];
    if (task) {
        $(".l-taskbar-task-icon:first", task).html('<img src="' + icon + '" />');
    }
    return win;
}
var links = [];

function onResize() {
    var linksHeight = $(window).height() - TASKBARHEIGHT;
    var winlinks = $("#winlinks");
    winlinks.height(linksHeight);
    var colMaxNumber = parseInt(linksHeight / LINKHEIGHT);//一列最多显示几个快捷方式
    for (var i = 0, l = links.length; i < l; i++) {
        var link = links[i];
        var jlink = $("li[linkindex=" + i + "]", winlinks);
        var top = (i % colMaxNumber) * LINKHEIGHT+5, left = parseInt(i / colMaxNumber) * LINKWIDTH;
        if (isNaN(top) || isNaN(left)) continue;
        jlink.css({ top: top, left: left });
    }

}
function click_li() {
  if(not_ti){
	   var linkindex = $(this).attr("linkindex");
	   var link = links[linkindex];              
	   load(link.id,linkindex,function(data){
	      if(data.code!=0&&not_ti){
	         click_ti(linkindex);
	      }
	      not_ti=true;
	   });
   }else{
      not_ti=true;
   }
}
var not_ti=true;
function click_ti(linkindex){
    not_ti=false;
    var link = links[linkindex];
    f_open(link.url, link.title, link.icon);
}
var menu1 ;
var menuNo;//右键的索引
$(function (){//添加右键事件
	menu1= $.ligerMenu({ top: 100, left: 100, width: 120, items:
	    [
	    { text: getDes('增加'), click: function(){
            alert(menuNo);
	    },icon:'add' }
	  
	    ]
	});
});
function linksInit() {
    var isNew=false;
    for (var i = 0, l = links.length; i < l; i++) {
        var link = links[i];
        var jlink= $("<li></li>");
        jlink.attr("linkindex", i);
        isNew=getNew(link);
        var messTi=link.title;
        if(link.url){
           if(isNew){
           	  messTi="<a href='"+itemPath+link.url+"' target='_blank' onclick='not_ti=false;'>"+link.title+"</a>";
           }else{
              messTi="<a href='javascript:void(0);' onclick='click_ti("+i+");'>"+link.title+"</a>";
           }
        }
        jlink.append("<img src='" + link.icon + "' />");
        jlink.append("<span>" + messTi + "</span>");
        jlink.append("<div class='bg'></div>");
        jlink.hover(function () {
            $(this).addClass("l-over");
        }, function () {
            $(this).removeClass("l-over");
        }).click(click_li);
        $(jlink).bind("contextmenu", function (e){
        	menuNo = $(this).attr("linkindex");
            menu1.show({ top: e.pageY, left: e.pageX });
            return false;
        });

        jlink.appendTo(winlinksul);
    }
}

var tiketMap=JSON2.parse($.cookie('ticketMap'));
var loadList_=window.localStorage.loadList;

var loadi=0;
var loadPid=0;
if((loadList_!=null&&loadList_!="")){
    loadList=JSON2.parse(loadList_);
    loadi=localStorage.loadi;
    loadPid=localStorage.loadPid;
}else{
   loadList=[{text:"开始",id:"ks",loadi:0,loadPid:"0"}];
}
itemList=getParentList(loadList);
$(function(){
clickBar(loadi,loadPid);
$(window).resize(onResize);
$.ligerui.win.removeTaskbar = function () { }; //不允许移除
$.ligerui.win.createTaskbar(); //页面加载时创建任务栏
});
function getNew(link){
   return (link.isNew&&link.url!=null&&link.url!="");
}  

function getParentList(list){
    var l=$pb.clone(list);
    var m=null;
    for(var i in l){
        l[i].click=function(item){clickBar(item.loadi,item.loadPid);} ;      
    }
    return l;
}
function clickBar(clickI,pid){
    var vli=$pb.clone(itemList);
    itemList=[];
    for(var i=0,len=vli.length;i<len;i++){
       if(i<=clickI){
          itemList.push(vli[i]);
       }
    }
   creatMenu(itemList,clickI,pid);
   load(pid);
}
function creatMenu(itemList,clickI,pid){
    $('#top').html('<div id="topmenu"></div>');
    $("#topmenu").ligerMenuBar({ items:itemList});
    localStorage.loadList=JSON2.stringify(itemList);
    localStorage.loadi=clickI;
    localStorage.loadPid=pid;
}
var cMap=null;
function load(pId,linkindex,loadFun){
    var param={pbCol:"id,parentId,url,text title,'images/3DSMAX.png' icon,isNew"};
    param["ifnull(parentId,0)"]=pId;
    param["add"]="order by porder";    	
   $pb.DoUrl("xt/pOpenTree.do?m=get&data=list",param,tiketMap, function(data){
	if(data.code==0){
	    if(linkindex){
		     var link = links[linkindex];
		     var theI=itemList.length;
		     itemList.push({text:link.title,loadi:theI,loadPid:pId,click:function(item){clickBar(theI,pId);}});
		     creatMenu(itemList,theI,pId);
	    }
        $("#winlinks ul").html('');
	    links=data.data;
	    winlinksul =  $("#winlinks ul");
	    linksInit();
	    onResize();
    }
    if($.type(loadFun) === "function"){
	      loadFun(data);
	}
});
}