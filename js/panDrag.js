var dragging = false;
var contextMenu = null; 
var fieldReplace = $("<li class='l-fieldcontainer l-fieldcontainer-r'></li>").appendTo("body").hide();
var fieldReplaceStatue = null;
var options = { 
    labelCss: 'labelcontainer',
    fieldCss: 'fieldcontainer',
    fields: [],
    onAfterSetFields: function (){
        var g = this, p = this.options; 
        f_setDrag();
        f_setReadonly();
        if (formProperty){
            formProperty.set('fields', []);
        }
        $(".l-fieldcontainer-first").removeClass("l-fieldcontainer-first"); 
        setTimeout(function (){ 
            $(".l-group")
               .width($("#designPanel").width() * 0.95)
               .find(".togglebtn").remove();
            $(".l-group").append("<div class='togglebtn'></div>");
        }, 20);
    }
};
$.ligerui.controls.Form.prototype.getNextField = function (field){
    var g = this, p = this.options,	visited = false;
    for (var i = 0, l = p.fields.length; i < l; i++){
        if (visited) return p.fields[i];
        if (p.fields[i] == field) visited = true; 
    }
    return null;
};
$.ligerui.controls.Form.prototype.moveField = function (fromIndex, toIndex, isAfter){
    var g = this, p = this.options;
    if (!p.fields) return;
    var fromField = g.getField(fromIndex);
    var toField = g.getField(toIndex);
    if (fromField.newline != false){
        var next = g.getNextField(fromField);
        if (next){
            if (next.newline == false) next.newline = true;
        }
    }
    if (!isAfter){
        if (toField.newline != false){
            toField.newline = false;
            fromField.newline = true;
        }
    }else{
        fromField.newline = false;
    }
    fromField.group = toField.group;
    // 先移除欲移动的field
    p.fields.splice(fromIndex, 1);
    // 重新计算 目标位置field的 index
    toIndex = $.inArray(toField, p.fields);
    // 插入
    p.fields.splice(toIndex + (isAfter ? 1 : 0), 0, fromField);
    g.set('fields', p.fields);
};
$("#layout1").ligerLayout({ 
    rightWidth: 250,
    height: '100%',
    bottomHeight:"250",
    heightDiff: -4,
    space: 4 
}); 
function loadOk(){
    $("#formDesign li.l-fieldcontainer").live('mouseover', function (){
	    if (dragging) return;
	    $(this).addClass("l-fieldcontainer-over");
    }).live('mouseout', function (){
    	$(this).removeClass("l-fieldcontainer-over");
    }).live('click', function (){
	    if (dragging) return;
	    var selected = $(this).hasClass("l-fieldcontainer-selected");
	    $("li.l-fieldcontainer-selected").removeClass("l-fieldcontainer-selected");
	    if (!selected){ 
	    	$(this).addClass("l-fieldcontainer-selected");
        }
            f_setProperty();
    });
};
f_setMenu();
f_loadFile();
function showFieldsSelector(){
    var fields = formDesign.get('fields');
    if (window.winFieldsSelector){
        window.winFieldsSelector.show();
    } else{
        window.winFieldsSelector = $.ligerDialog.open({
            target: $("#fieldsSelector"),
            isResize: true,
            title: '选择字段',
            width: 700,
            height: 370,
            buttons: [
                {
                    text: '确定', onclick: f_selectFields
                },
                {
                    text: '取消', onclick: function () { winFieldsSelector.hide(); }
                }
            ]
        });
        $("#listbox1,#listbox2").ligerListBox({
            isShowCheckBox: true,
            isMultiSelect: true,
            width:300,
            height: 286            
        });
    }
  
    var data1 = [], data2 = [];
    $(fields).each(function (i, field){
        var o = {
            text: field.display+":"+field.name,
            id: field.name,
            field : field
        }; 
        if (field.type == "hidden") data1.push(o);
        else data2.push(o);
    }); 
    liger.get("listbox1").setData(data1);
    liger.get("listbox2").setData(data2);
}
function f_selectFields(){
    var selecteds = liger.get("listbox2").data;
    var fields = formDesign.get('fields');
    var isChanged = false;
    $(fields).each(function (i, field){
        if (find(field)){
            if (field.type == "hidden"){
                field.type = field.oldtype || "text";
                isChanged = true;
            }
        } else{
            if (field.type != "hidden"){
                field.oldtype = field.type;
                field.type = "hidden";
                isChanged = true;
            }
        }
    });
	if (isChanged){
	    formDesign.set('fields', fields);
	}
    winFieldsSelector.hide();
	
    function find(field){
        for (var i = 0, l = selecteds.length; i < l; i++){
            if (selecteds[i].field == field) return selecteds[i];
        }
        return null;
    }
}
function moveToLeft(){
    var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
    var selecteds = box2.getSelectedItems();
    if (!selecteds || !selecteds.length) return;
    box2.removeItems(selecteds);
    box1.addItems(selecteds);
}
function moveToRight(){
    var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
    var selecteds = box1.getSelectedItems();
    if (!selecteds || !selecteds.length) return;
    box1.removeItems(selecteds);
    box2.addItems(selecteds);
}
function moveAllToLeft(){ 
    var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
    var selecteds = box2.data;
    if (!selecteds || !selecteds.length) return;
    box1.addItems(selecteds);
    box2.removeItems(selecteds); 
}
function moveAllToRight(){ 
    var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
    var selecteds = box1.data;
    if (!selecteds || !selecteds.length) return;
    box2.addItems(selecteds);
    box1.removeItems(selecteds);           
}
function f_loadFile(){
  $pb.lang.loadDes($pb.lang.getlangMap(langNo,langNoC),tiketMap,pb_UrlId,function(data){
       langDesMap=data;
        var map={
          "id":neiId,
          "pbCol":"repText"
        };
        loadDesNext(function(){
        $pb.DoUrl($pb.manageUrl+"sys/prep.do?m=get&data=one",map,tiketMap, function(data){// 回调函数
            if(data.code==0){
            	options.fields=repDesJson(JSON.parse(data.data.repText));
            	formDesign = $("#formDesign").ligerForm(options);
            	$pb.panel.init(formDesign);
            	loadOk();
            }
       }); 
        });
  });      
}


function repDisplay(des){
	return  getDes(des.replace('${langDes',"").replace("langDes}",""));
}
function showMessage(message){
    var input = $("<textarea style='width:99%;height:220px' />").val(message);
    $.ligerDialog.show({
        target: input,
        width: 400,
        height:290,
        showMax: false,
        showToggle: false,
        showMin: false 
    });
}
function f_saveToFile(){
  var map={
    "id":neiId,
    "repText":repDesToOldJson(formDesign.get('fields'))//JSON.stringify()
  };
  $pb.DoUrl($pb.manageUrl+"sys/prep.do?m=update&data=one",map,tiketMap, function(data){// 回调函数
      if(data.code==0){                      
      	$pb.showMess('保存成功！', 1000,function(){
      		var saveing= $.ligerDialog.waitting('正在保存字段设置,时间稍久点.....');
      		 $pb.Data.load({},tiketMap,"xt/tb.do",'',function(dd){
      			saveing.close();
      			location.reload();
      		 },"m=import&urlId="+pb_UrlId+"&pan=true");//保存到字段
		});      	
      	cha_=false;
      }
 });
}
function f_init() {
}
function f_setDrag(){            
    $('li.l-fieldcontainer').ligerDrag({ 
        revert: true, handler: '.labelcontainer',
        proxy: function (){
            var div = $("<div class='fieldproxy'></div>");
            // $(this).clone().appendTo(div);
            div.add(fieldReplace).width($(this).width());
            div.add(fieldReplace).height($(this).height());
            div.appendTo('body');
            return div;
        },onrevert: function (){
            return false;
        },ondrag: function (current, e){
            dragging = true;
            var pageX = e.pageX || e.screenX, pageY = e.pageY || e.screenY;
            var height = this.proxy.height(), width = this.proxy.width();
            var centerX = pageX , centerY = pageY - height / 2;
            this.target.hide();

            var result = getPositionIn($('li.l-fieldcontainer').not(this.handler), centerX, centerY); 
            if (result){
                if (result != true){ 
                    fieldReplace.show();
                    // 判断是否跟上次匹配的位置一致
                    if (fieldReplaceStatue &&
                    fieldReplaceStatue.fieldindex == result.fieldindex &&
                    fieldReplaceStatue.position == result.position){
                        return;
                    } 
                    if (result.position == "left"){
                        fieldReplace.insertBefore(result.element);
                    } else if (result.position = "right"){
                         fieldReplace.insertAfter(result.element);
                    }
                    fieldReplaceStatue = result;
                }
            }else{ // 没有匹配到
                fieldReplacePosition = null;
                fieldReplace.hide();
            }
        },onStopDrag: function (current, e){
            dragging = false;
            fieldReplacePosition = null;
            fieldReplace.hide();
            this.target.show();
            if (fieldReplaceStatue){
                var fromIndex = parseInt(this.target.attr("fieldindex"));
                var toIndex = parseInt(fieldReplaceStatue.fieldindex);
                formDesign.moveField(fromIndex, toIndex, fieldReplaceStatue.position == "right");
            }
        }
    });
}
// 从指定的元素集合匹配位置
function getPositionIn(jelements,x,y){
    for (var i = 0, l = jelements.length; i < l;i++){
        var element = jelements[i];
        var r = positionIn($(element), x, y);
        if (r) return r;
    }
    return null;
}
// 坐标在目标区域范围内
function positionIn(jelement,x,y){ 
    var height = jelement.height(), width = jelement.width();
    var left = jelement.position().left, top = jelement.position().top;
    var diff = 3;
    if (y > top + diff && y < top + height -diff){
        if (x > left + diff && x < left + width/2 - diff){
            if (jelement.hasClass("l-fieldcontainer-r")) return true;
            return {
                element: jelement,
                fieldindex: jelement.attr("fieldindex"),
                position: "left"
            };
        }
        if (x > left + width / 2 + diff && x < left + width - diff){
            if (jelement.hasClass("l-fieldcontainer-r")) return true;
            	return {
		                element: jelement,
		                fieldindex: jelement.attr("fieldindex"),
		                position: "right"
                    }; 
         }
    }
    return null;
}
function f_addGroup(){
    
}
function f_deleteField(){
    
}
function f_setMenu(){
	contextMenu = $.ligerMenu({
	    width: 120,
	    height : 400,
	    items:[
	        { text: '增加分组', click: f_addGroup } ,
	        { line: true },
	        { text: '删除项', click: f_deleteField }
	        ]
});
$(".l-layout-header,.l-group").bind("contextmenu", function (e){
    contextMenu.show({ top: e.pageY, left: e.pageX });
    return false;
});
}
function f_setReadonly(){
    $("input").attr("readonly", true);
}
var formDesign ;//= $("#formDesign").ligerForm(options);
var formProperty = $("#formProperty").ligerForm({
    onAfterSetFields: function (){
        var g = this, p = this.options;
        if (!p.fields || !p.fields.length){
            $("#btnSaveProperty").hide();
        }else{
            $("#btnSaveProperty").show();
        }
    }
}); 
var btnSaveProperty = $("#btnSaveProperty").ligerButton({
    click: f_saveProperty, text: '保存属性'
}); 
var btnSaveToFile = $("#btnSaveToFile").ligerButton({
    click: f_saveToFile, text: '保存'
}); 
var btnSelectFields = $("#btnSelectFields").ligerButton({
    click: showFieldsSelector, text: '显示/隐藏字段',width:100
});
// 保存，更新值
function f_saveProperty(){
    var selected = $("li.l-fieldcontainer-selected");
    var fieldindex = selected.attr("fieldindex");
    var field = formDesign.getField(fieldindex);
    var type=field.type;
    var thePro=formProperty.getData();
    if(thePro.type!=type){
    	thePro.oldtype=type;
    }
    if(thePro.hasOwnProperty("rowSize")){
    	field.editor.rowSize=thePro.rowSize;
    	delete thePro.rowSize;
    }
    $.extend(field, thePro);
    formDesign.set('fields', formDesign.options.fields);
    loadOk();
    $pb.panel.init(formDesign);
    cha_=true;
}
function getValueByType(value, type){
    if (type == "number"){
        return parseInt(value);
    }
    if (type == "boolean"){
        return (value == "true" || value == true) ? true : false;
    }
    return value;
}
// 获取field属性编辑框列表，初始化值
function f_setProperty(){
    var selected = $("li.l-fieldcontainer-selected");
    if (!selected.length){
        formProperty.set('fields', []);
    }
    var fieldindex = selected.attr("fieldindex");
    var field = formDesign.getField(fieldindex);
    if (field == null){
        formProperty.set('fields', []);
    }
    var fields = f_getFieldProperties(field,fieldindex);
    formProperty.set('fields', fields);
    field.text=conMap[field.type][0].text;
    if(field.hasOwnProperty("oldtype")){
    	field.oldtext=conMap[field.oldtype][0].text;
    }
    if(field.hasOwnProperty("editor")&&field.editor.hasOwnProperty("rowSize")){
    	field.rowSize=field.editor.rowSize;
    }
    if(field.hasOwnProperty("validate")){
    	var valid="required";
    	for(var v in field.validate){
    		if(v!="required"){
    			valid=v;
    		}
    	}
    	field.is_validate=valid;
    }
    formProperty.setData(field);  
}
function repDesJson(fields){
	$(fields).each(function(k,t_m){
		if(t_m.hasOwnProperty("display")&&t_m["display"].indexOf("${langDes")!=-1){
			t_m["display"]=repDisplay(t_m["display"]);
		}
		if(t_m["groupicon"]){
			t_m["groupicon"]=$pb.manageUrl+t_m["groupicon"];
		}
	});
	return fields;
}
function repDesToOldJson(fs){
	var notGroup=true;
	var groupText="";
	var douf,i;
	var notSave=["text","oldtext","pbSelect","rowSize"];//不保存字段 自己加的
	var funStrAdd="_funStr";//字段加上此后缀的作为替换为加此后缀字段的值，一般为函数
	var json="[";
	$(fs).each(function(k,t_m){
		json+=((k>0)?",":"")+"{";
		i=0;
		notGroup=(t_m["group"]==groupText);
		for(var f in t_m){
			if(f.indexOf(funStrAdd)!=-1) continue;//此字段不保存进数据库，由下面处理
			if((t_m[f]==""&&f!="newline")||$.inArray(f,notSave)>-1) continue;
			douf=((i>0)?",":"")+f;
			if(f=="display"){
				json+=douf+':getDes("'+t_m["name"]+'")';
			}else if(f=="newline"){
				if(!t_m[f]){
				   json+=douf+':'+t_m[f];
				}else{
					i--;
				}
			}else if(f=="groupicon"){
				continue;
			}else if(f=="group"){
				if(!notGroup){
					groupText=t_m[f];
					json+=douf+':"'+t_m[f]+'",groupicon:"images/group/group.gif"';
				}
			}else if (f=="is_validate"){
				if(t_m[f]){
					json+=((i>0)?",":"")+"validate:{"+t_m[f]+":true"+("required"!=t_m[f]?",required:true":"")+" }";
				}
			}else if($pb.isObject(t_m[f])){
				if(f=="editor"&&t_m.hasOwnProperty("pbSelect")){
					var objStr=[];
					for(var key in t_m["editor"]){
						if(key=="data"){
							objStr.push('data:$pb.select.getObj("'+t_m["pbSelect"]+'").data');
						}else{
							var tv=t_m["editor"][key];
							if(typeof tv =="string"){
								 objStr.push(key+":'"+tv+"'");
							}else{
							   objStr.push(key+":"+tv);
							}
						}
					}
					json+=douf+':{'+objStr.join(",")+'},pbSelect:"'+t_m["pbSelect"]+'"';
				}else{
				   json+=douf+":"+JSON.stringify(t_m[f]);
				}
			}else{
				var fdd=f+funStrAdd;
				if(t_m.hasOwnProperty(fdd)){
					json+=douf+':'+t_m[fdd]+','+fdd+':\''+t_m[fdd]+'\'';//此处将对应的两个字段同时保存进数据库
				}else{
			       json+=douf+':"'+t_m[f]+'"';
				}
			}
			i++;
		}
		json+="}";
	});
	json+="]";
	return json;
}
function f_getFieldProperties(field,fieldIndex){
	var properties = [];
	if(field){
    for (var name in propFieldEditors) {
        if (";name;editor;text;label;groupicon;".indexOf(";"+name+";")!=-1) continue; //groupicon;
        //var editor = propFieldEditors[name];
        var pro = $.extend({
            name: name,
            label: name,
            width: 110,
            newline: false,
            type: 'text'
        }, $pb.clone(propFieldEditors[name]));
        properties.push(pro);
    }
    if(field.hasOwnProperty("oldtype")){
    	properties.push({
            label: '原控件类型',
            type: 'popup', newline: false, width: 110,name: "oldtype",
            editor: {
            	grid:{ columns: [{ display: '类型', name: 'id'},{ display: '描述', name: 'text' }] ,
            		data:{
            			Rows: conData
            		},selectable:false
                } 
            },valueField: "id", textField: "oldtext"
        });
    }
    if(field.hasOwnProperty("type")&&";checkboxlist;radiolist;".indexOf(";"+field.type+";")!=-1){
    	properties.push({
            label: '列数',
            type: 'int', newline: false, width: 110,name: "rowSize",digits:true
        });
    }
 }
    return properties;
}
var conData=[ 
             { id: 'text', text: '文本框' },
             { id: 'int', text: '整数编辑框' },
             { id: 'number', text: '浮点数编辑框' },
             { id: 'currency', text: '货币编辑框' },
             { id: 'combobox', text: '表格下拉框' },
             { id: 'select', text: '简单下拉框' },
             { id: 'popup', text: '弹出选取框' },
             { id: 'date', text: '日期编辑' },
             { id: 'checkbox', text: '复选框' },
             { id: 'listbox', text: '列表框' },
             { id: 'radiolist', text: '单选框列表' },
             { id: 'checkboxlist', text: '多选复选框'},
             { id: 'textarea', text: '多行编辑框' },
             { id: 'htmleditor', text: 'HTML编辑框' }
         ];
var conMap=$pb.findMap(conData,"id");
//var imgData=[ 
//             {id:1,url:"images/group/group.gif" },
//             {id:2,url:"images/group/group1.gif"},
//             {id:3,url:""}
//         ];
var propFieldEditors = {
    display:{
    	label:"显示描述"
    },type: {
        label: '控件类型',
        type: 'popup',
        editor: {
        	grid:{ columns: [{ display: '类型', name: 'id'},{ display: '描述', name: 'text' }] ,
        		data:{
        			Rows: conData
        		}
            }
        },valueField: "id", textField: "text"
    },width: {
        label: '宽度',
        type: 'int'
    },labelWidth: {
        label: '标签宽度',
        type: 'int'
    },space: {
        label: '间隔',
        type: 'int'
    },label: {
        label: '标签',
    },newline: {
        label: '是否新行',
        type: 'checkbox'
    },group: {
        label: '设置分组'
    }
//    ,groupicon:{
//    	label: '图标【设置第一个分组】',type: 'popup',
//        editor: {
//        	grid:{ columns: [{ display: '编号', name: 'id',type:"int",width:100}
//        					,{ display: '路径', name: 'url',width:400}
//        					,{width:60, display: '查看',render:function(item){
//        							return item.url?'<img src="'+$pb.manageUrl+item.url+'" width="16" hight="16 ">':"";
//        					}}
//        	                 ] ,
//        	data:{
//        			Rows:imgData
//        		}
//            }
//        },valueField: "url", textField: "id"
//    }
    ,disabled:{
    	label: '是否只读',
        type: 'checkbox'
    },is_validate:{
    	label: '是否验证',width:300,
        type: 'select',editor : {
			"data" : [ {"sNo" : "validate","sValue" : "required","text" : "该字段不能为空"},
			           {"sNo" : "validate","sValue" : "remote","text" : "请修正该字段"},
			           {"sNo" : "validate","sValue" : "email","text" : "请输入正确格式的电子邮件"},
			           {"sNo" : "validate","sValue" : "url","text" : "请输入合法的网址"},
			           {"sNo" : "validate","sValue" : "date","text" : "请输入合法的日期"},
			           {"sNo" : "validate","sValue" : "dateISO","text" : "请输入合法的日期 (ISO)"},
			           {"sNo" : "validate","sValue" : "number","text" : "请输入合法的数字"},
			           {"sNo" : "validate","sValue" : "digits","text" : "只能输入整数"},
			           {"sNo" : "validate","sValue" : "creditcard","text" : "请输入合法的信用卡号"},
			           {"sNo" : "validate","sValue" : "equalTo","text" : "请再次输入相同的值"},
			           {"sNo" : "validate","sValue" : "accept","text" : "请输入合法的数字"},
			           {"sNo" : "validate","sValue" : "maxlength","text" : "请输入一个长度最多是 {0} 的字符串"},
			           {"sNo" : "validate","sValue" : "minlength","text" : "请输入一个长度最少是 {0} 的字符串"},
			           {"sNo" : "validate","sValue" : "rangelength","text" : "请输入一个长度介于 {0} 和 {1} 之间的字符串"},
			           {"sNo" : "validate","sValue" : "range","text" : "请输入一个介于 {0} 和 {1} 之间的值"},
			           {"sNo" : "validate","sValue" : "max","text" : "请输入一个最大为 {0} 的值"},
			           {"sNo" : "validate","sValue" : "min","text" : "请输入一个最小为 {0} 的值"},
			           {"sNo" : "validate","sValue" : "notnull","text" : "不能为空"}
			],"valueField" : "sValue"
		}
    }
};
var cha_=false;
$(window).bind("beforeunload",function(){
	if(cha_){
	  return "是否保存,未处理数据将丢失？";
	}
});
