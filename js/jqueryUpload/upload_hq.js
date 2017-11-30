$(document).ready(function() { 
	$("#fileupload").css("display","block");
    $("#fileupload").uploadify({ 
        'uploader'       : '/js/jqueryUpload/scripts/uploadify.swf', 
        'script'         : '/upload.do',//请求地址
        'method'         : 'Get',
        'cancelImg'      : '/js/jqueryUpload/cancel.png', 
        'queueID'        : 'fileQueue',
        'fileDataName'   : 'fileupload', 
        'auto'           : false,
        'multi'          : true,
        'sizeLimit'      : fileSize,
        'queueSizeLimit' : 200,
//        'buttonText'     : 'BROSER',
        'buttonImg'      : '/js/jqueryUpload/browser.jpg',
//        'simUploadLimit' : 1, //一次同步上传的文件数目  ,这个好像不起作用
//        'sizeLimit'      : 10, 
        'fileDesc'       : '支持格式:'+fileType,
        'fileExt'        : fileType,
    	onComplete: function (event, queueID, fileObj, response, data) {
    		if(response!='success'){
    			alert(response);
    			jQuery('#fileupload').uploadifyClearQueue();
    			return;
    		}
		}, 
		onError: function(event, queueID, fileObj) { 
			//fileObj.size
			if(fileSize<999999999){
				if(fileObj.size>fileSize){
					alert(fileObj.name+" 大于允许上传文件大小！");
					return;
				}
			}
    		 alert("文件:" + fileObj.name + "上传失败"); 
		},
		onAllComplete:function(event,data){
			insertDBAfterUpload();
			alert("上传成功的文件个数:"+(data.filesUploaded-data.errors)+"\n"
				  +"上传出现错误的文件个数:"+data.errors+"\n");
		}
    }); 
}); 
function resetScriptDate(){
	//上传时需要传递其它参数  不需要则删除
	 var formid= $('#fileupload').attr("formid");
	  	if(formid==undefined||formid==null||$.trim(formid)==""||formid=='null'){
	  		alert("功能号传递有误！");
	  		return;
	  	}
	 var fieldid= $('#fileupload').attr("fieldid");
	 if(fieldid==undefined||fieldid==null||$.trim(fieldid)==""||fieldid=='null'){
		 alert("fieldid传递有误！");
		 return;
	 }
	 var doccode= $.trim($('#fileupload').attr("doccode"));
	 var rowid= $.trim($('#fileupload').attr("rowid"));
	 if(rowid=='null'||rowid=='NULL'){
		 rowid='';
	 }
	 var sessionId = $('#fileupload').attr("sessionId");
	 if((doccode==""||doccode=='null')&&(rowid==""||rowid=='null')){
		 alert("参数传递有误！");
		 return;
	 }
	 
	 //设置参数
	$('#fileupload').uploadifySettings('scriptData',{'formid':formid,'doccode':doccode,'fieldid':encodeURI(encodeURI(fieldid)),'rowid':rowid,'sessionId':sessionId});
	jQuery('#fileupload').uploadifyUpload();
}

function insertDBAfterUpload() {
	$.post("/execSQLFromSession.do");
}