var ok=false;
function itemclick(item){ 
    if(item.id)
    {
        switch (item.id)
        {
            case "modify":
                var rowsdata = gridManager.getCheckedRows();
                var str = "";
                $(rowsdata).each(function ()
                {
                    str += this.CustomerID + ",";
                });
                if (!rowsdata.length) alert('请选择行');
                else
                    alert(str);
                return;
            case "delete":
                var data = gridManager.getCheckedRows();
                if (data.length == 0)
                    alert('请选择行');
                else
                {
                    var checkedIds = [];
                    $(data).each(function ()
                    {
                        checkedIds.push(this.CustomerID);
                    });
                    $.ligerDialog.confirm('确定删除' + checkedIds.join(',') + '?', function ()
                    {
                        alert('演示数据，不能删除');
                    }); 
                }
                return;
            case "Excel":
            case "Word":
            case "PDF":
            case "TXT":
            case "XML":
                $.ligerDialog.waitting('导出中，请稍候...');
                setTimeout(function ()
                {
                    $.ligerDialog.closeWaitting();
                    if (item.id == "Excel")
                        $.ligerDialog.success('导出成功');
                    else
                        $.ligerDialog.error('导出失败');
                }, 1000);
                return;
        }   
    }
    alert(item.text);
}
function menuLang(data){
	var menuLan = { width: 100, items: [] };//语言
	var m;
	menuLan.items=[];
	for(var i in data.data){
	    m=data.data[i];
        menuLan.items.push({ text: m.langdes,langNo:m.langId,click:clickLang});
	}
	return menuLan;
}
var morenToobarList=[];

function loadMenu(langData){
	$pb.panel.init(pb_Pan);
	var menuLan=menuLang(langData);
	$("#kLangDes").html(getDes('语言')); 
	$("#btnSearh").html(getDes('查询'));      
	if(typeof loadLang =="function"){  
	loadLang();
	}
	//菜单一
	var menu1 = { width: 120, items:
	    [
	    { text: getDes('保存'), click: itemclick,icon:"save" },
	    { text: getDes('列存为'), click: itemclick },
	    { line: true },
	    { text: getDes('关闭'), click: itemclick }
	    ]
	};
	//菜单二
	var menu2 = { width: 100, items:
	    [ {
	        text:getDes('文件'), children:
	        [
	            { text: 'Excel',id:'Excel', click: itemclick },
	            { text: 'Word', id: 'Word', click: itemclick },
	            { text: 'PDF', id: 'PDF', click: itemclick },
	            { text: 'TXT', id: 'TXT', click: itemclick },
	            { line: true },
	            { text: 'XML', id: 'XML', click: itemclick }
	        ]
	    },{
	        text: getDes('多级节点'), children:
		        [
		            { text: 'Excel',id:'Excel', click: itemclick, children:
				        [
				            { text: 'Excel',id:'Excel', click: itemclick },
				            { text: 'Word', id: 'Word', click: itemclick , children:
						        [
						            { text: 'Excel',id:'Excel', click: itemclick },
						            { text: 'Word', id: 'Word', click: itemclick },
						            { text: 'PDF', id: 'PDF', click: itemclick },
						            { text: 'TXT', id: 'TXT', click: itemclick },
						            { line: true },
						            { text: 'XML', id: 'XML', click: itemclick , children:
								        [
								            { text: 'Excel',id:'Excel', click: itemclick },
								            { text: 'Word', id: 'Word', click: itemclick },
								            { text: 'PDF', id: 'PDF', click: itemclick },
								            { text: 'TXT', id: 'TXT', click: itemclick },
								            { line: true },
								            { text: 'XML', id: 'XML', click: itemclick }
								        ]}
						        ]},
				            { text: 'PDF', id: 'PDF', click: itemclick },
				            { text: 'TXT', id: 'TXT', click: itemclick },
				            { line: true },
				            { text: 'XML', id: 'XML', click: itemclick }
				        ] },
		            { text: 'Word', id: 'Word', click: itemclick },
		            { text: 'PDF', id: 'PDF', click: itemclick },
		            { text: 'TXT', id: 'TXT', click: itemclick },
		            { line: true },
		            { text: 'XML', id: 'XML', click: itemclick }
		        ]
		    }
	    ]
	};
   //菜单条
	pb.menu=$("#topmenu").ligerMenuBar({ items: [
        { text: getDes('文件'), menu: menu1 },
        { text: getDes('导出'), menu: menu2 },
//        { text: '表格风格', menu: menu3 },
        {text:getDes('语言'),menu:menuLan},
        {text:getDes('新页卡'),click:function(item){
        	window.open(location.href);
        }}
    ]
    });
	itemList=[];
//	if(typeof toobarList !="undefined"){
//		itemList=toobarList;
//	}else{
		itemList.push({ text: getDes('增加'), id:'add', click:pb.addNewRow,icon: 'add'});
		itemList.push({ text:getDes('删除'), id:'delete', click:pb.deleteRow,icon: 'delete'});
		itemList.push({ text: getDes('复行'), id:'copyRow', click: function(){$pb.grid.copyRow(pb);},icon:"cut"});   
		itemList.push({ text: getDes('保存'), id:'save', click: pb.saveAll,icon: 'save'});
		itemList.push({ text: getDes('确定'), id:'nextOk', click:docOk,icon: 'ok'});
		itemList.push({ text: getDes('确认'), id:'saveOk', click:function(){
			pb_Pan.setData({pbOk:1});
			pb.saveAll();
		},icon: 'ok'});
		morenToobarList=$pb.clone(itemList);
		itemList.push({ text: getDes('查找'), id:'searche', click: yeLoad,icon:"search"});
		itemList.push({ text: getDes('返回'), id:'fanhui', click:function(){
			history.back();				
		},icon:"back"});
//	}	
    //工具条
	if(itemList.length>0)
    pb.toobar=$("#toptoolbar").ligerToolBar({ items:itemList});
	if(pb.toobar){
		if(!parmParent.isHas()&&!pb.parentData){
			pb.toobar.removeItem("fanhui");
		}
		if(typeof(removeSave)=="undefined"||removeSave){
			$(["nextOk","saveOk"]).each(function(i,v){												
			    pb.toobar.removeItem(v);
			});
		}
	}
}
function docOk(){
	ok=true;
	pb.saveAll();
}
function clickLang(item){
	if(typeof load != "undefined"){
		load=0;
	}
	chanLan(item.langNo);
}
function chanLan(lNo){
   langNo=lNo;
   $("#maingridSpan").html('<div id="maingrid" style="margin-top:5px"></div>');
//   $("#hidMenu").show();
   $("#showMenu").html('<div id="topmenu"></div><div id="toptoolbar"></div>');   
   yeLoad();         
 }
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
$(function (){
	if(parmParent.isHas()){
	    var pM=parmParent.get();
	    if(pM.hasOwnProperty("langNo")){
	    	langNo=pM['langNo'];
	    }
	    if(pM.hasOwnProperty("langNoC")){
	    	langNoC=pM['langNoC'];
	    }
	}
	if(typeof yeLoad =="function"){
	    yeLoad();
	}
});