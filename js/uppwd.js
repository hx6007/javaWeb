var tiketMap = JSON2.parse($.cookie('ticketMap'));
var dialogP;
function showLogin() {
	loginMap = {
		width : 348,
		height : 160,
		target : $("#login")
	};
	loginMap.buttons = [ {
		text : "修改",
		onclick : function(item, dialog) {
			commit();
		}
	} ];
	if (frameElement == null) {
		loginMap.allowClose = true;
		loginMap.title = "密码修改";
	} else {
		loginMap.title = "";
		dialogP = frameElement.dialog;
		loginMap.allowClose = false;
		loginMap.isDrag = false;
	}
	var pb_pan = $.ligerDialog.open(loginMap);
	if (frameElement != null) {
		$(".l-dialog-tc").parent().html('');
	}
}
$pb.key.enter(function() {
	$(loginMap.buttons[0]).click();
});
function commit() {
	var form = new liger.get("panFrom");
	var u_ = form.getData();
	if (u_.pwd.trim()!=""&&u_.pwd == u_.pwd1) {
		var user_map = JSON2.parse($.cookie('user'));
		$pb.DoUrl("user/userinfo.do?m=update&data=one", {
			"user_id" : user_map.user_id,
			"old_md5password" : hex_md5(u_.oldpassword + user_map.user_name),
			"md5password" : hex_md5(u_.pwd + user_map.user_name)
		}, tiketMap, function(data) {
			if (data.code == 0) {
				$.ligerDialog.confirm('密码修改成功！', function(yes) {
					dialogP.close();
				});
			} else {
				$.ligerDialog.warn("修改失败！" + data.messageTxt);
			}
		});
	} else {
		$.ligerDialog.warn("新密码不能为空或者确认密码不匹配！");
	}
}
$(function() {
	$("#panFrom").ligerForm({
		inputWidth : 170,
		labelWidth : 80,
		labelAlign : "right",
		space : 2,
		fields : [ {
			"newline" : true,
			"name" : "oldpassword",
			"display" : "旧密码",
			"type" : "password"
		}, {
			"newline" : true,
			"name" : "pwd",
			"display" : "新密码",
			"type" : "password"
		}, {
			"newline" : true,
			"name" : "pwd1",
			"display" : "确认密码",
			"type" : "password"
		}, ]
	});
	showLogin();
});