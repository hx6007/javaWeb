var tEMapCook = $.cookie('ticketExit');
var dialogP;
showUnload = false;
var company;
var codeDo=true;
var form;
function reloadCode(i) 
{ 
  $("#randomming").attr({src:"/"+item+"/imageCode?rand="+i}); 
}
function showLogin() {
	var w_ = 340, h_ = 140;
    if(codeDo){
    	h_+=30;
    }
	loginMap = {
		title :"用户登录",
		width : w_,isDrag:false,
		height : h_,
		target : $("#login")
	};
	if ($.browser.msie) {
		alert("建议不要使用IE内核浏览器。\r\n\t由此带来的系统问题概不负责！");
	}
	var bl = (document.body.clientWidth - w_) / 2;
	var bt = (document.body.clientHeight - h_) / 2;
	loginMap.left = bl;
	loginMap.top = bt;
	loginMap.buttons = [ {
		text : "登录",
		onclick : function(item, dialog) {
			commit();
		}
	} ];
	company=$pb.getQueryString("company");
	if(company){
		window.localStorage.loginCompany=company;
	}else{
		company=$pb.isNull(localStorage.loginCompany,"");
	}
	if(company){
		loginMap.title=company+loginMap.title;
		loginMap.buttons.push({
		text : getDes("重置公司"),
		onclick : function(item, dialog) {
			localStorage.loginCompany="";
			location.reload();
		}
	});
	}
	loginMap.allowClose = false;
	if (frameElement != null) {
		dialogP = frameElement.dialog;
		loginMap.isDrag = false;
	}
	$.ligerDialog.open(loginMap);
}
$pb.key.enter(function() {
	$(loginMap.buttons[0]).click();
});
function jis() {
	hash = hex_md5($("#pwd").val());
	$("#password").val(hash);
}
function commit() {
	if(form.valid()){
		var data = form.getData();
		if(data.code.length!=5){
			$pb.showMess("验证码位数不匹配",1000,function(){
				return;
			});
		}else{
			var username = data.user_name;
			if (notUser != null) {
				username = notUser;
			}
			var pwd = hex_md5(data.pwd + username);
			form.setData({
				"pwd" : pwd
			});
			$pb.DoUrl("user/userinfo.do?m=login&data=json", {"dbConfig":company,"user_name":username,"md5password":pwd,code:data.code}, null, function(data) {
				if (data.code == 0) {
					$.cookie('liger-home-tab', null);
					$.cookie('ticketMap', data.ticketMap);
					$.cookie('manageUrl', data.demo_config.manage);
					$.cookie('user', JSON2.stringify(data.data));
					var userName = data.data.user_name;
					cookUsers = window.localStorage.userList;
					userList = [];
					if (cookUsers != null && cookUsers != "") {
						userList = JSON2.parse(cookUsers);
					}
					if ($.inArray(userName, userList) == -1) {
						userList.push(userName);
						window.localStorage.userList = JSON2.stringify(userList);
					}
					if (dialogP) {
						dialogP.get('opener').loginDo();
						dialogP.close();
					} else {
						window.location = "index.html";
					}
					$pb.select.remove(false);
				}else{
					if(data.code != 15){					
						form.setData({
							"pwd" : ""
						});
				    }
					$.ligerDialog.warn("登录失败！" + data.messageTxt);
					reloadCode(Math.random());
				}
			});
		}
	}
}
var notUser = null;
$(function() {
	cookUsers = null;
	if (typeof (Storage) !== "undefined") {
		cookUsers = window.localStorage.userList;
	} else {
		alert("请升级浏览器以支持web存储！");
	}
	userList = [];
	var loginType = "select";
	if (cookUsers != null && cookUsers != "") {
		userList = JSON2.parse(cookUsers);
	} else {
		loginType = "text";
	}
	var loginData = [];
	for ( var i = 0, len = userList.length; i < len; i++) {
		loginData.push({
			"name" : userList[i]
		});
	}
	var fieldList= [ {
		"newline" : true,
		"name" : "user_name",
		"display" : "账号",
		"type" : loginType,
		"editor" : {
			"data" : loginData,
			"textField" : "name",
			"valueField" : "name",
			autocomplete : function(e) {
				notUser = e.key;
			}
		}
	}, {
		"newline" : true,
		"name" : "pwd",
		"display" : "密码",
		"type" : "password"
	} ];
	if(codeDo){
		fieldList.push({
			"newline" : true,
			"name" : "code",
			"display" : "验证码",width:100,
			"type" : "text",	validate : {
				"required" : true
			},afterContent:'<img src="/'+item+'/imageCode"   id="randomming" title="重新获取验证码" border="0" alt="验证码" style="cursor: pointer;" onClick="reloadCode(Math.random())" align="absmiddle" />'
		} );
	}
	form=$("#panFrom").ligerForm({
		inputWidth : 170,
		labelWidth : 80,
		labelAlign : "right",
		space : 7,
		fields :fieldList,validate:true
	});
	if (tEMapCook != null && tEMapCook != "") {
		ticketExit = JSON2.parse(tEMapCook);
		$.cookie('ticketExit', null);
		$.cookie('ticketMap', null);
		$.cookie('user', null);
		$pb.exit(ticketExit, null);
	}
	showLogin();
});