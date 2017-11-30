var g;
$(function() {
var panels = [];
var tiketMap = JSON2.parse($.cookie('ticketMap'));
$pb.Data.load({
	pcNo: liuNo,
	"user_id":user_id,  // 将判断流程权限用，查询对应有权限的记录  
	"add":"order by pcGid asc"
}, tiketMap, "105", "", function(data) { // 获取流程对应的 步骤信息 
	if(data.code == 0) {
		var pic_ = [];
		var picId_map={};
		var pcId_=[];
		for(var i in data.data) { // 将流程步骤信息 用集合组合 
		    pcUrlId=data.data[i].pcUrlId;
		    pcId=data.data[i].pcId;
			pic_.push(pcUrlId);
			picId_map[pcId]=data.data[i];
			pcId_.push(pcId);
		}
		var PerformNum=data.data[0].pcId;// 默认执行步骤 为第一步 
		var hasJl_=false;
		var not_ok=true;
		var has_commit=true; // 当前用户是否有权限提交，即操作保存，确认  修改 
		var PostName; // 已经处理过的人 处理过的人有权限查询自己处理过的单据 
		$pb.Data.load({"DocCode":doccode,"FlowNnumber":liuNo},tiketMap,"5","",function(docData){ // 查询单据审核信息 可以根据审核信息判断权限
			var paramJson={};
	       	if(docData.code==0){	
			   PerformNum=docData.data["FlowStep"]; // 执行到的步骤  
			   paramJson=JSON2.parse($pb.isNull(docData.data["okJson"],"{}"));
			   if(docData.data.FlowOk==1){// 单据 是否已经  确认 
				   not_ok=false;
			   }
			   var next_user=$pb.isNull(docData.data.NextPostName,'');// 当前流程 还需审核的人 
			   PostName=$pb.isNull(docData.data.PostName,'');
			   if(next_user!=''&&next_user.indexOf(user_id)==-1){ // 下步执行人不存在并且不包含当前用户 则无权限审核 
				   has_commit=false;
			   }
			   hasJl_=true;
		    }else if(doccode!=""){
                pageCole("不存在此单据！");
	    	}
	       	$pb.Data.load({
				"id": pic_
			}, tiketMap, "xt/pOpenTree.do", "id,url", function(mom) { // 获取 步骤路径对应信息，比如页面url 
				if(mom.code == 0) {
					var pic_map = $pb.findMap(mom.data, "id");
	                var showTo=false;
	                var tjBoo;
	                var userInf=$pb.user.getUserInf();
	                var nextBoo;
					for(var p_ in pcId_) { //循环流程步骤 
						tjBoo=true;
						var i_=pcId_[p_];
					    var nextParm={"pbCode":doccode,showToParent:0};
					    liuInfo=picId_map[i_];
					    var tId=liuInfo.pcUrlId;
					    var tj=$pb.isNull(liuInfo.Conditions,"");
					    if(tj!=""){ //替换条件所对应的字段值
					    	var param;
					    	for(var p_i in paramJson){
					    		tj=tj.replace("\${"+p_i+"}",paramJson[p_i]);
					    	}
					    	for(var d in userInf){
					    		tj=tj.replace("\$("+d+")",userInf[d]);
					    	}
					    	tj=tj.replace('and','&&').replace('or','&&');
					    	tjBoo=(tj.indexOf("\${")> -1 || eval(tj)); //条件设置 是否为true 
					    }
						nextParm.pbProccesNo=i_;
						nextBoo=(nextParm.pbProccesNo==PerformNum); //是否当前步骤 
					    if(tjBoo||nextBoo){
							row = pic_map[tId][0];
							url = path + row.url;
							if(nextBoo&&not_ok&&has_commit&&tjBoo){
								var ExeRoles=liuInfo.ExeRoles;  //判断 角色权限 判端到达的步骤权限
								if(!hasExeRoles(roleIds,ExeRoles)&&doccode!=""){
									if((","+PostName+",").indexOf(","+user_id+",")==-1){
										pageCole("无权限查看");
									}
									isMask=true;
								}else{
									isMask=false;
								}
							}else{
							    isMask=true;
							}
							var obj = {
								title: liuInfo.pcDes,
								width: liuInfo.width,
								height: liuInfo.height,
								url:url, 
								data:nextParm,
								isMask:isMask,
								liuNo:liuNo,
								hasJilu:hasJl_,
								showClose: false,
								showToggle: showTo
							};						
							panels.push(obj);
					   }
						if(nextBoo){
							if(doccode==""){
								doccode="无记录";
							}
							panels.push({
								title: "流程跟踪记录",
								width: '100%',
								height: 370,
								url: path+"xt/lc/gz.jsp", 
								data:{"pbCode":doccode,showToParent:0},
								isMask:false,
								showClose: false,
								showToggle: true
							});
							break;   //如果跳出 未到达的流程步骤 不加载
						}
						showTo=true;
					}
					g = $("#portalMain").ligerPortal({
						draggable: false,
						columns: [{
							width: '100%',
							panels: panels
						}]
					});
				}
			}, 'm=get&data=list');
	   },'m=get&data=one');
	}
});
});
$(function(){
	   $("#topmenu").ligerMenuBar({ items: [
	        {text:'新页卡',click:function(item){
	        	window.open(location.href);
	        }},  {text:'新单',click:function(item){
	        	window.open(itemPath+'Template/panel_page.jsp?no='+liuNo);
	        }}
	    ]
	   });
	   $pb.key.addExec(function(e){ //ctrl+shift+l 
			return (e.keyCode==76)&&(e.ctrlKey)&&(e.shiftKey);
		}, function(){
			f_import(function(){
				imp.title=":流程控制";
				 parmaMap={showMap:{showMax:false}}; parmaMap.pcNo=liuNo ;
			}, '',itemPath+ "xt/lc.jsp");
		});
});
function hasExeRoles(h,to){
	var h_=h.split(",");
	to=","+to+",";
	var has=false;
	for(var r in h_){
		if(to.indexOf(","+h_[r]+",")!=-1){
			has=true;
			break;
		}
	}
	return has;
}
function pageCole(mess){
	 alert(mess);
	 window.opener=null;
     window.open('','_self');
     window.close();
}