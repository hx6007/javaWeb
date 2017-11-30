/**
 * 七牛上传对象，改对象用于创建上传集合
 */
(function($){
	var uptoken_url='/qiniutoken.do';
	var s_={
			"uploader":{
	    runtimes: 'html5,flash,html4',
//	    browse_button: 'pickfiles',//上传按钮的ID
//	    container: 'btn-uploader',//上传按钮的上级元素ID
	    //drop_element: 'btn-uploader',//拖拽区域ID 
	    max_file_size: '100mb',//最大文件限制
//	    flash_swf_url: '/static/js/plupload/Moxie.swf',
	    dragdrop: false,
	    chunk_size: '4mb',//分块大小
	    uptoken_url:itemPath+uptoken_url,// '/manage/qiniutoken.do',//设置请求qiniu-token的url	
	    max_retries: 3, // 上传失败最大重试次数
//	    get_new_uptoken: true,  // 设置上传文件的时候是否每次都重新获取新的uptoken
	    //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
	    // uptoken : '<Your upload token>',
	    //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
	    // unique_names: true,
	    // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
	    // save_key: true,
	    // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
	    domain: 'aa',//自己的七牛云存储空间域名
	    multi_selection: false,//是否允许同时选择多文件
	    //文件类型过滤，这里限制为图片类型
	    filters: {
	      mime_types : [
	        {title : "Image files", extensions: "jpg,jpeg,gif,png"}
	      ]
	    },
	    auto_start: true,
	//  unique_names:true,
	    init: {
	        'FilesAdded': function(up, files) {
	            //do something
	        },
	        'BeforeUpload': function(up, file) {
	            //do something
	        },
	        'UploadProgress': function(up, file) {
	            //可以在这里控制上传进度的显示
	            //可参考七牛的例子
//	            console.log(file);
//	            console.log(file);
	        },
	        'UploadComplete': function() {
	            //do something
	        },
	        'FileUploaded': function(up, file, info) {
	           //每个文件上传成功后,处理相关的事情
	           //其中 info 是文件上传成功后，服务端返回的json，形式如
	           //{
	           //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
	           //  "key": "gogopher.jpg"
	           //}
//	         var domain = up.getOption('domain');
//	         var sourceLink = domain + res.key;//获取上传文件的链接地址
	           var res = eval('(' + info + ')');
	           $pb.DoUrl(itemPath+"/file.do",$pb.mergeMap(res,s_.post_data),{},function(data){
	        	   console.log(data);
	             	if (data.code==0) {
	             		if(typeof parmParent.endFun == "function"){
	             			parmParent.endFun(data.imgurl);
	             		}
	             		loadImag(data.imgurl);
	             	}
	           });
	        },
	        'Error': function(up, err, errTip) {
				console.log(errTip);
				console.log(err);
				console.log(up);
	        },
	        'Key': function(up, file) {
	            //当save_key和unique_names设为false时，该方法将被调用
	        	var timestamp = Date.parse(new Date());
	            var key = hex_md5(timestamp+file.name);
	            //var ext = Qiniu.getFileExtension(file.name);
	            return key;
	        }
	    }
	},init:function(obj){//{}
//		if(obj['uptoken_url']){
//			uptoken_url=obj['uptoken_url'];
//		}
		 this.uploader.browse_button =obj.browse_button;// 'pickfile';//上传按钮的ID
		 this.uploader.container =obj.container;// 'btn-upload';//上传按钮的上级元素ID
		 this.uploader.domain =obj.domain;
		 this.post_data=obj.post_data;
		 return this.uploader;
	}//
	,post_data:null
	};
	window.$upload=s_;
})($);
