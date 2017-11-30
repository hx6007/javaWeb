$(document).ready(function() { 
	$("#fileupload").css("display","block");
    $("#fileupload").uploadify({ 
        'uploader'       : path+'/js/jqueryUpload/scripts/uploadify.swf', 
        'script'         : path+'/file.do',//请求地址
        'method'         : 'Get',
        'cancelImg'      : path+'/js/jqueryUpload/cancel.png', 
        'queueID'        : 'fileQueue',
        'fileDataName'   : 'fileupload', 
        'auto'           : false,
        'multi'          : true,
        'sizeLimit'      : fileSize,
        'queueSizeLimit' : 200,
//        'buttonText'     : 'BROSER',
        'buttonImg'      : path+'/js/jqueryUpload/browser.jpg',
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
			alert("上传成功的文件个数:"+(data.filesUploaded-data.errors)+"\n"
				  +"上传出现错误的文件个数:"+data.errors+"\n");
		}
    }); 
}); 
function resetScriptDate(){

	 //设置参数
	$('#fileupload').uploadifySettings('scriptData',{"zdr":zdr});
	jQuery('#fileupload').uploadifyUpload();
}
