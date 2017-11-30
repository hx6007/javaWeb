var pMap=$pb.getQueryMap();
var tiketMap=JSON2.parse($.cookie('ticketMap'));
var par = {
 "browse_button":"pickfile",//上传按钮的ID
 "container":"btn-upload",//上传按钮的上级元素ID
 "domain":""
};
var hostname;
var site_id;
var picId;
$(function() {
    parmParent.get();
    var param=parmParent.parm;
    var tabKey=param.tabKey;
    if(tabKey==null){
       par["post_data"]=pMap;
    }else{
       par["post_data"]=param;
    }
    site_id=par["post_data"].site_id;
    picId=$pb.isNull(par["post_data"].picId,"null");
    if(par["post_data"].src){//如果传入图片路径
       loadImag(par["post_data"].src);
    }else{
		$pb.Data.load({"tableNo":"26","id":picId},tiketMap,'xt/tb.do',"",function(data){
		           if(data.code==0){ 
		              loadImag(data.data.filepath);
		           }else{
		              setTimeout($('#pickfile').click(),10000)  ;
		           }
		},'m=get&data=one');//加载图片
	}
	if(picId!="null"){
		$('#btnDelPic').show();
		$('#btnDelPic').click(function(){
			var manager = $.ligerDialog.waitting('正在保存中2,请稍候...');
			$pb.Data.load({"tabKey":tabKey,"pb_UrlId":"93"},tiketMap,'xt/man.do',"",function(data){
				manager.close();
				if(data.code==0){
					manager = $.ligerDialog.waitting('删除成功！');
					setTimeout(function () { manager.close(); }, 1000);	
	             	if(typeof parmParent.endFun == "function"){
	             		parmParent.endFun(data.imgurl);
	             	}					
				}else{					    
					$.ligerDialog.question(data.messageTxt);					    
				}
		    },'m=del&data=rows');//删除图片关系
		});
	}else{
		$('#btnDelPic').hide();
	}
	$pb.Data.load({
	 "tableNo":"25",
	 "id": site_id,
	 "pbCol":"hostname"
	},tiketMap,'xt/tb.do',"",function(data){
	           if(data.code==0){
	             hostname=data.data.hostname;
	             if(hostname!=null&&hostname.indexOf('http')!=-1){
		             par.domain=hostname;
			         Qiniu.uploader($upload.init(par));
		         }else{
		             initFile();
		         }
	           }else{
				  $.ligerDialog.question('上传配置不存在！');	              
	           }
	},'m=get&data=one');//加载七牛信息
});

function  initFile(op){
   $('#picFile').html('<input type="file" name="pickfile_file" id="pickfile_file" style="display: none" />');
   if(typeof op == "undefined"){
     $('#pickfile').click(function(){
        $('#pickfile_file').click();
     });
   } 
  $('#pickfile_file').change(function(){
   $.ligerDialog.confirm('确定要更改图像？', function (yes) {
   var fileObj = document.getElementById('pickfile_file');
   //document.getElementById('tx_id').src =  window.URL.createObjectURL(fileObj.files[0]);
   loadImag(window.URL.createObjectURL(fileObj.files[0]));
   document.getElementById('tx_id').value = fileObj.value;
    var formData = new FormData($("#tx_fm")[0]);
     $.ajax({
              url:path+'/itemFile.do?site_id='+site_id+'&picId='+picId,
              type: 'POST',  
              data: formData,
              headers: tiketMap,
              contentType : false, 
              processData : false,   
              success:function(data){
               	if (data.code==0) {
             		var file_=data.data[0];
             		par["post_data"].picId=file_["id"];
             		upInfo({
             		  "beginName":file_.beginName,
             		  "filepath":file_.filepath
             		},par["post_data"]);
             	}else{
             	    $.ligerDialog.confirm('出错了，需还原展示....', function (yes) { 
             	      if(yes){
	             	    $('#show').html($('#hidpic').html());             	    
	             	    initFile(1);
             	      }else{
             	        $.ligerDialog.question('您的选择，图像并未改过！');
             	      }
             	    });
             	}
             }
       });
   });
});
}

function loadImag(src){
   $('#hidpic').html($('#show').html());
   if(src.indexOf('http')==-1){
     src=path+"/"+src;
   }
   $('#show').html('<img id="tx_id" src="'+src+'"/>');
}