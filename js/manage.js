var hf=window.location.href;
var item="manage";
var itemPath=hf.substring(0, hf.indexOf(item)+7);
var gridFile={};
var arrayFiled={};
var ok_=[];//加载时不是确认状态
var isMask=false;
var is_super=false;
var clickBtn=false;//按钮已点击
$pb={};
var skin_links = {
	    "aqua":itemPath+ "js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css",
	    "gray":itemPath+ "js/Source/lib/ligerUI/skins/Gray/css/all.css",
	    "silvery":itemPath+ "js/Source/lib/ligerUI/skins/Silvery/css/style.css",
	    "gray2014":itemPath+ "js/Source/lib/ligerUI/skins/gray2014/css/all.css",
	    "ne":itemPath+ "js/Source/lib/ligerUI/skins/ne/css/all.css"
};
function cacheCss(skin){
   if(skin){
   	  localStorage.css_skin=skin;
   }else{
	  skin=localStorage.css_skin;
   }
   return skin;
}
function qiPaoImg(id,src,w,h){
	$("#"+id).ligerTip({ content: '<img src="'+src+'" width="'+w+'" />',auto:true,width:w,height:h });
};
function css_init_to(skin){
    var css = $("#mylink").get(0),skin=cacheCss(skin);
    if (!css || !skin) return;
    skin = skin.toLowerCase();
    $('body').addClass("body-" + skin); 
    $(css).attr("href", skin_links[skin]); 
}
function getRowEdit(item){
	var hasEdit=true;
	if(item!=null&&item.hasOwnProperty("pbOk")){
    	hasEdit=(item.pbOk=="1")?false:true;
    }
	return hasEdit;
}
function f_isChecked(rowdata){
	 if(parmParent.isHas()){
	  if(parmParent.checkFun){
	     return parmParent.checkFun(rowdata);
	  }}
	 return false;
}
function gObj(gManager){
	return eval(gManager);
};
function openMask(){
	var msk= $.ligerDialog.waitting('开启遮罩');
	msk.close();
	msk.mask();
}
function repDesJson(fields){
	$(fields).each(function(k,t_m){
		if(t_m["groupicon"]){
			t_m["groupicon"]=itemPath+t_m["groupicon"];
		}
	});
	return fields;
}
function getDes(filed){
	return typeof langDesMap!="undefined"?$pb.lang.readDes(langDesMap,filed):filed;
}
function upInfo(res,post_data){//提交服务器信息
    $pb.DoUrl(itemPath+"/file.do",$pb.mergeMap(post_data,res),{},function(data){
     	if (data.code==0) {
     		if(typeof parmParent.endFun == "function"){
     			parmParent.endFun(data.imgurl);
     		}
     		loadImag(data.imgurl);
     	}
   });
}
(function(window, itemUrl ){//TODO 树	
	var langNoC="1";
	var the_gManager=null;
    var pb={ 
    		manageUrl:itemUrl,
    		getlangMap:function(lno,lnoC){
                return {"langNo":lno,"langNoC":lnoC};
        },exit:function(tiketMap,relocation){
        	   $pb.DoUrl(itemUrl+"account/logout.do",{},tiketMap,function(data){
			    	 if(data.code==7||data.code==8){
			    		  if($.type(relocation) === "function"){
			    			  relocation();
			    		  }else if(relocation){
		    	    	     $.cookie('ticketMap',null);
				             window.location=relocation;
			    		  }
					  }else{
					       $.ligerDialog.warn("退出失败！"+data.messageTxt);
					  }
				}); 
         },array_search:function(data,key){
        	  re = new RegExp(key,[""]);
        	  return (data.toString().replace(re,"┢").replace(/[^,┢]/g,"")).indexOf("┢");
         },getUrlId:function(fun){
        	 var url=window.location.href.replace(itemPath, '');
        	 var n_=["login.html","index.html"];
        	 if(this.array_search(n_,url)==-1){
	        	 pb.DoUrl(itemUrl+"xt/pOpenTree.do?m=get&data=one", {
						"pbCol":"id",
						"url":url
						}, tiketMap, function(data){
							if(typeof fun=="function"){
								fun(data);
							}											
						});
        	 }
         },showMess:function(mess,time,closeFun){
			  $.ligerDialog.waitting(mess);
              setTimeout(function (){
            	  $.ligerDialog.closeWaitting();
            	  if(typeof closeFun=="function"){
            		  closeFun();
            	  }
              }, time);
         },DoUrl:function(do_url,param,ticketMap,fun){// 权限请求处理
    			$.ajax({
    				type: "post",
    				contentType:"application/json",
    	            headers: ticketMap,
    				url: do_url,
    				data: JSON.stringify(param),
    				success: function(data){
    					if(typeof(fun) == "function"){
    							fun(data);
    					}    						    	
    				},error: function(data){
    					pb.showMess("错误"+data.message, 1000);
    				}
    			});	
    		},
    		getColData:function(d,gridCols){
      		  var colMap=gridCols;
    		  var cols="";
    		  for(var c_ in colMap){
    		          cols+=colMap[c_]['name']+";";
    		  }
    		  var data=[];
    		  var map={};
    		  for(var i=0,len=d.length;i<len;i++){
    		    map=d[i];
    		    for(var key in map){
    		    	if(cols.indexOf(key+";")==-1){
    		    	  delete map[key];
    		    	}
    		    }
    		    data.push(map);       		    
    		  }
    		  return data;
    		},findMap:function(d,col,repMap){//(数据集合，集合列） 根据集合的列中的值重新分组集合
    			var tM={};
    			var key=null;
    			for(var i=0,len=d.length;i<len;i++){
    				if(repMap){
    					for(var rKey in repMap){
    						var v_=d[i][rKey];
    						d[i][rKey]=repMap[rKey][v_];
    					}
    				}
    				key=$pb.isNull(d[i][col],"0");
//    				if(key==""){
//    					key="0";
//    				}
    				if(tM[key]==null){
    					tM[key]=[];
    				}
    				tM[key].push(d[i]);
    			}
    			return tM;
    		},findTreeMap:function(d,node,parentNode,repMap){//数节点格式（数据list，子节点名称，父节点名称,需要替换集合）
    			var tM=this.findMap(d, parentNode,repMap);
    			var treeMap={};
    			var t_=null;
    			var nodeV=null;
    			treeMap=pr.findAndDel(tM,tM,node);
    			return treeMap['tree'];
    		},bulid:function(no,ticketMap,sucessFun){
    			var url=itemUrl;
    			if(no!=null&&no!=""){
    				url+="xt/pOpenTree.do?m=bulid&id="+no;
    			}else{
    				url+="xt/pOpenTree.do?m=bulidAll";
    			}
    			var saveing= $.ligerDialog.waitting('正在生成，请稍等.....');
    			pb.DoUrl(url, {}, ticketMap, function(data){
                    saveing.close();
    				if(data.code==0){
    					pb.showMess('生成成功！', 1000,function(){
    						if(typeof sucessFun=="function"){
    							sucessFun();
    						}else{    							
    							location.reload();
    						}
    					});
    				}
    			});
    		}
    };
  
    pb.tree={
    		isExtend:function (rowData){
    	        if ('isextend' in rowData && rowData['isextend'] == false)
    	            return false;
    	        return true;
    	    },isParent:function (rowData){
    	        var exist = 'children' in rowData;
    	        return exist;
    	    },gridCheck:function(gFun,field,V,index,checked,sameParentChecked,one){//控制树节点的勾选情况 1.表格对象，2设置字段，3设置对应值,4,父节点同时选择,5子集合同时选择,
    	    	var g=gFun();
    	    	g.updateCell(field,V,index);
    	    	sameParentChecked=(sameParentChecked==null||sameParentChecked);
    	    	if(one==null||one){//第一次 用户操作选择，真假都控制子级
    		    	var ch=g.getChildren(index);//真假与否 都要控制子集合，要么全选择，要么全不选
    		    	$(ch).each(function(i,row){
    		    		$pb.tree.gridCheck(gFun, field, V, row.__index, checked,false,false);
    		    	});
    	    	}
    		    var pData=g.getParent(index);		    	
    		    if(pData!=null){
		    	    var allCheck=true;
		    	    if(!sameParentChecked){//如果不是 选择一个则处理，则全部选择处理
    		    		var ch=g.getChildren(pData.__index);	    		    		
    		    		$(ch).each(function(i,row){
    		    			if(row[field]!=V){
    		    				allCheck=false;//存在一个则为有一个未选择
    		    				return false;
    		    			}
    		    		});
		    	    }
		    		if(allCheck){//全部选择 或者  有一个选择 
		    			$pb.tree.gridCheck(gFun, field, V, pData.__index, checked,sameParentChecked,false);
		    		}
    	    	}
    	    }
        };
    pb.grid={//表格处理
		getDeleteWhere:function(data,tKey){
			if(data){
				if(typeof(data)=='object'&&data.length>0){
					var delMap={};
					var delData = [];
					var b=false;
					for(var i=0;i<data.length;i++){
						if(typeof data[i][tKey]=="string"||typeof data[i][tKey]=="number"){
						  delData.push(data[i][tKey]);
						  b=true;
						}else{
							var list=this.getDeleteWhere(data[i], tKey);
							if(list!=null){
							  delData.push.apply(delData,list[tKey]);
							  b=true;
						    }
						}
					}
					if(b){
						delMap[tKey]=delData;
					}
					return delMap;
				}
			}
			return null;
		},getData:function(tData,chr,pNode){//处理树节点数据	(list,'子节点字段','父节点tree值')		
			var ref=false;
			for(var i in tData){
				ref=false;
				if(pNode&&pNode!=""){
					if(tData[i].theNode!=pNode){//只有字集合的节点非父级节点下 则修改，判断修养修改子项
					    tData[i].theNode=pNode;
					    ref=true;
					}
				}
				if(tData[i][chr]){
					if(ref){//判断子集合需不需要修改
						var theNode=tData[i].theNode+"-"+tData[i].id; 
						var chrList=pb.grid.getData(tData[i][chr], chr,theNode);
						for(var j in chrList){
							tData.push(this.hasCol(tData,chrList[j]));
						}
					}
					delete tData[i][chr];
				}
			}
			return tData;
		},initRow:function(l){//初始数据
			var fM={};
			var m;
			for(var i in l){
				m=l[i];
				fM[m['name']]=m['value'];
			}
			var cM=parmParent.get('obj').initValue;
			for(var key in cM){
				if(fM.hasOwnProperty(key)){
					fM[key]=cM[key];
				}
			}
			return fM;
		},hasCol:function(l,m){
			if(l.length>0){
				for(var k in m){
					if(typeof(l[0][k])=="undefined"){
						delete m[k];
					}
				}
			}
			return m;
		},pbCol:function(cols){
			var c_="";
			var type="";
			var file='';
			for(var m in cols){
				if(cols[m]['name']){
					if(cols[m].hasOwnProperty("type")){
						type=cols[m].type;
					}else if(cols[m].hasOwnProperty("editor")){
						type=cols[m]["editor"].type;
					}else{
						type="";
					}
					file=cols[m]['name'];
					if(type=="date"){
						c_+="DATE_FORMAT(" + file + "{dou}'%Y-%m-%d %T') as " + file+",";
					}else{
						c_+=file+",";
					}
				}
			}
			if(c_!=""){
				c_=c_.substring(0, c_.length-1);
			}
			return c_;
		},showCol:function(cols,showList){
			 if(showList.length>0){
				var hid=true;
	            for(var c_ in cols){
	            	 hid=true;
	                 for(var f in showList){
	                     if(cols[c_]['name']==showList[f]){
	                        hid=false;
	                        break;
	                     }
	                }
	                if(hid){
	                	cols[c_]['hide']=true;
	                }
	            }
			 }
            return cols;
		},copyRow:function(gObj){
			var gManage=gObj.manager;
			var n_=",lId,lkey,"+gObj.noCopy+",";
			var sRow=gManage.getSelectedRow();
			var scRow={};
			for (var key in sRow) {
				if(key.substring(0,1)=='_'){
					continue;
				}
				if(n_.indexOf(","+key+",")==-1){
					scRow[key]=sRow[key];
				}
			}
			gManage.addRow(scRow);
		},repColConfig:function(cols,d_,refField){
 		   if(d_){
 		      for(var r_ in refField){        		      
 		       for(var c_ in cols){
 		           if(cols[c_]['name']==r_){
 		        	  cols[c_]['render']=refField[r_]['render'];
 		        	  cols[c_]['editor']=refField[r_]['editor'];
 		        	  cols[c_]['value']=refField[r_]['value'];
 		              break;
 		           }
 		       } 
 		      }     		    
 			}
 		   return cols;
		}
	};
    var pr={
    		findAndDel:function(tM,t_Map,node){//tm 需查找的所有     t_Map ：查询集合  node 根据字段判断节点
    			var treeList=null;
    			var t_=null;
    			var nodeV=null;
    			var hasNode="";
    			var cheList={};
    			for(var the in t_Map){
    				t_=t_Map[the];
    				for(var vM in t_){
    					nodeV=t_[vM][node];
    					if(tM[nodeV]!=null){
    						hasNode+=nodeV+";";
    						var nodeMap=[];
    						nodeMap[nodeV]=tM[nodeV];
    						delete tM[nodeV];
    						if(t_Map[nodeV]!=null){
    							delete t_Map[nodeV];
    						}
    						var tTree=this.findAndDel(tM,nodeMap, node);
    						t_[vM]['children']=tTree['tree'];
    						hasNode+=tTree['hasNode'];
    					}
    				}
    				cheList[nodeV]=t_;
    			}
    			treeList=[];
    			for(var the in cheList){
    				if((";"+hasNode).indexOf(";"+the+";")!=-1){
    					treeList=cheList[the];
    				}
    			}
    			if(treeList.length==0){
    				treeList=t_;
    			}
    			return {'tree':treeList,'tM':tM,"hasNode":hasNode};
    		}
    };
    pb.isObject=function(o){
    	return typeof o == "object";
    };
    pb.isArray=function(obj) {//是否array集合
        return Object.prototype.toString.call(obj) === '[object Array]';   
    };
    pb.isMap=function(o){
    	return pb.isObject(o)&&!o.sort;
    };
    
    pb.getUrl=function(){
    	var localObj=document.location;
    	return 	localObj.origin+localObj.pathname;
    };
    pb.getQueryArray=function(){
    	var now_url = document.location.search.slice(1), q_array = now_url.split('&');
    	return q_array;
    };
    pb.getQueryMap=function(){
    	q_array=pb.getQueryArray();
    	var the={};
    	var v_array;
        for (var i = 0; i < q_array.length; i++)
        {
            v_array = q_array[i].split('=');
            the[v_array[0]]=v_array[1];
        }
        return the;
    };
    pb.isNull=function(obj,obj2){
    	if(typeof obj =="undefined" || obj==null ||obj==""){
    		return obj2;
    	}
    	return obj;
    };
    pb.getQueryString=function(name)
    {
    	q_array=pb.getQueryArray();
        for (var i = 0; i < q_array.length; i++)
        {
            var v_array = q_array[i].split('=');
            if (v_array[0] == name)
            {
                return v_array[1];
            }
        }
        return "";
    };
    pb.setLocaltion=function(arry){
    	return pb.getUrl()+(arry.length>0)?("?"+arry.join("&")):"";
    };
    pb.mergeMap=function (map1){
	  for (var i=1;i<arguments.length;i++){
	    map2=arguments[i];
	    for (var k in map2){
	      map1[k]=map2[k];
	    }
	  }
	  return map1;
    };
    pb.mergeNewMap=function(map){
    	var map1=pb.clone(map);
  	  	for (var i=1;i<arguments.length;i++){
		    map2=arguments[i];
		    for (var k in map2){
		      map1[k]=map2[k];
		    }
		  }
		return map1;
    };
    pb.mergeArray=function(a1){
 	  	for (var i=1;i<arguments.length;i++){
		    a2=arguments[i];
		    for (var k in a2){
		    	a1.push(a2[k]);
		    }
		 }
 	  	return a1;
    };
    pb.mergeNewArray=function(array){
    	var a1=pb.clone(array);
 	  	for (var i=1;i<arguments.length;i++){
		    a2=arguments[i];
		    for (var k in a2){
		    	a1.push(a2[k]);
		    }
		 }
 	  	return a1;
    };
    pb.clone=function(myObj){ //克隆程序
    	  if(typeof(myObj) != 'object') return myObj;
    	  if(myObj == null) return myObj;
    	  var myNewObj=null;
    	  if(pb.isArray(myObj)){
    		  myNewObj=[]; 
    	  }else if(typeof myObj=="function"){
    		  myNewObj=myObj();
    	  }else{
    		  myNewObj = new Object();
    	  }
    	  for(var i in myObj)
    	    myNewObj[i] = pb.clone(myObj[i]);
    	  
    	  return myNewObj;
    };
    pb.edit={ //TODO 编辑控件   
    		checkEdit:function(gManager,item,field,is_edit,setfun){
    	   		var checked="";
                if(item[field]){
                  var s=item[field].toString();
                  if(s.length<2||s.substring(0,2)!="p_"){//p_为未选择标志
                     checked="checked";
                  }
                }
                var editClick="false;";
                if(is_edit&&$.inArray(item.__index, ok_)==-1){
                	is_edit=getRowEdit(item);
                }
                if(is_edit){
                	gFun=gManager;
	                if(typeof gManager !="function" && gManager){
	       				gFun=function(){
	       					return gObj(gManager);
	       				};
	                }
                	editClick=$pb.fun.get(function(obj){
                		if(field=="pbOk"&&$.inArray(item.__index, ok_)==-1){
                			ok_.push(item.__index);
                		}
                		if(typeof (setfun)=="function"){
                			setfun(obj.checked);
                		}else{
                		   var g=gFun();
                		   g.updateCell(field,(obj.checked?1:0),item.__index);
                		   if(field=="pbOk"){
                			   g.beginEdit(item.__index);
                    		   g.cancelEdit(item.__index);
                		   }
                		}
      				},'this').str;
                }
               return '<input  type="checkbox" onclick="return '+editClick+'"  value="'+item[field]+'" '+checked+' />';
       		},
       		textArea:function(gManager,item,field,param){
       		  var editV="return false;";
       		  var shV=(param.value)?param.value:item[field];
       		  var c_;
       		  var gFun=gManager;
   			  if(typeof gManager !="function" && gManager){
   				gFun=function(){
   					return gObj(gManager);
   				};
   			  }
   			if(param.edit){
   				param.edit=getRowEdit(item);
   			}
			if(param.edit){
			  editV=$pb.fun.get(function(obj){
				 getRowEdit(item)?gFun().updateCell(field,obj.value,item.__index):obj.value=item[field];
			  },'this').str;
			  c_=function(val){
				  getRowEdit(item)?gFun().updateCell(field,val,item.__index):null;
			  };
			}
			var okV=$pb.fun.get(function(){
				$pb.edit.areaShow(shV,c_,param.edit);
			}).str;
			var tc='<input type="button" value="T" onclick="'+okV+'"/>';
       		  if(!param.cols){
       			param.cols=10;
       		  } if(!param.rows){
       			param.rows=1;
       		  }
       		  var ch_=(param.edit)?'onchange="'+editV+'"':'readOnly="true" style="background:#EAEAEA;"';
       		  return '<table><tr><td><textarea  cols="'+param.cols+'" rows="'+param.rows+'" '+ch_+' >'+pb.isNull(shV,'')+'</textarea></td><td valign="top">'+tc+'</td></tr></table>';
       		},areaShow:function(val,fun,edit){
       			if($('#target1').length==0){
       				$("body").append('<div id="target1" style="display:none;"><textarea id="tarValue" cols="90" rows="27" style="margin: 0px; width: 840px; height: 390px;"></textarea></div>');
       			}
       			var s_={
       					width:880,
       					height:470,showToggle: true, 
       					target: $("#target1")	                
       			};
       			if(edit==null||edit){
       				s_.buttons=[{ text: imp.ok, onclick: function(item, dialog){ 
       					if(typeof(fun)=="function"){
       						fun($('#tarValue').val());
       					}
       					dialog.close();
       				}}];
       			}else{
       				$('#tarValue').attr('readOnly',true);
       			}
       			$('#tarValue').val(val);
       			$.ligerDialog.open(s_);       			
       		},import_:function(beginFun,endFun,url,theFiles,impFiles,isAdd,key,item){
       		    var reStr='';
       			if(getRowEdit(item)){
       				if(url.indexOf("http")==-1){
       					url=itemUrl+url;
       				}
      		        var gfun=beginFun;
        			if(typeof beginFun !="function" && beginFun){
        				gfun=function(){
        					return gObj(beginFun);
        				};
        			}
					var fn=$pb.fun.get(function(){
						if(getRowEdit(item)){
		   					if(typeof endFun != "function"){
		   						var gIndex=endFun;
		   						endFun=function(dataMap){
		   							if(typeof gfun == "function"){
		   								gfun= gfun();
		   						    }
			       					$pb.Data.setGrid(gfun,dataMap,gIndex);
		   						};	       				
		   					}
							f_import(gfun,endFun,url,theFiles,impFiles,isAdd);
						}
					}).str;
					key=$pb.isNull(key,"");
				    if(theFiles&&key==""){
				    	reStr+='<span style="width:16px;"><button style="padding:0" onclick="'+fn+'">...</button></span>';
				    }else{
				       key=$pb.isNull(key, getDes('查看'));
	   			       reStr+='<a href="javascript:'+fn+'">'+key+'</a>';
	       			}
       			}
       		    return reStr;
       		},date:function(obj){
       			var item=obj.item;
       			var filed=obj.filed;
       			var v=item[filed];
       			if(v==null){
       				return "";
       			}
       			var format=obj.format;
                if(typeof (v) != "number"){
                	if(typeof (v)=="object"){
                		gridFile[filed]=item.__index;
                		gManage=window.pb.manager;
                		if(obj.gManage!=null){
                			gManage=obj.gManage;
                		}
                		gManage.updateCell(filed,$pb.Date.formatDate(v,format),item.__index);
                		return;
                	}
                    v=Date.parse(v);
                    if(gridFile[filed]!=null&&item.__index==gridFile[filed]){
                    	delete gridFile[filed];
                    }
                }
                return $pb.Date.formatDate(new Date(v),format);
       		},checkboxlist:function(item,field,cInfo){//处理表格
       			var id=field+'_'+item.__index;
       			var sp=$pb.isNull(cInfo.split,";");
       			var v_=item[field];
       			$(function(){
       			     $("#"+id).ligerCheckBoxList(cInfo);
       			});
       			return '<span id="'+id+'">'+item[field]+'</span>';
       		}
    };
   
    pb.lang={
    	  getlangMap:function(lno,lnoC){
                return {"langNo":lno,"langNoC":lnoC};
          },load:function(lNo,tiketMap,fun){
        	 var id= lNo+"lang_select";
        	 var hasLang=localStorage[id];
        	 if(hasLang != null && hasLang != ""){
        		 if(typeof fun=="function"){
        			 fun(JSON2.parse(hasLang)); 
        		 }
        	 }else{
	    		 pb.Data.load(pb.lang.getlangMap(lNo,langNoC),tiketMap,"/lang.do",'',function(data){
	    				if(data.code==0){
	    					if(typeof fun=="function"){
	    						localStorage[id]=JSON2.stringify(data);
	    						fun(data);
	    					}
	    				}else{
	                       
	                    }
	             });
        	 }
    	 },loadDes:function(param,tiketMap,urlId,fun){
    		 if(typeof param != 'object'){
    			 param=pb.lang.getlangMap(param,langNoC);
    		 }
    		 //param.uId=urlId;
    		 param["ifNull(uId,'"+urlId+"')"]=urlId;
    		 pb.Data.load(param,tiketMap,"/des.do",'',function(data){
 				if(data.code==0){
 					if(typeof fun=="function"){
 						fun(pb.findMap(data.data,'desKey',null));
 					}
 				}else{
                    
                }
            });
    	 },readDes:function(map,key){
    		 if(map[key]!=null&&map[key].length>0){
    			 return map[key][0]['des'];
    		 }
    		 return key;
    	 }
    };
    pb.report={//TODO 报表
    		getA:function(fr,param,name){
    			if(fr==null){
    				return "";
    			}
    			var url=itemUrl;
    			var fn=null;
    			var urlParam=jQuery.param(param);
    			var frams=fr.split(",");
    			var fram=null;
    			var rA="";
    			var txt=(name)?name:"";
    			var repMap=$pb.select.getObj("reportType").map;
    			for(var i=0,len=frams.length;i<len;i++){
    				fram=repMap[frams[i]][0].text;
	    			if(fram=='pdf'){
	    				fn=url+"PdfServlet?"+urlParam;
	    				rA += "&nbsp;<a href='"+fn+"' target='blank'>"+txt+getDes('Pdf')+"</a> ";
	    			}else if(fram=='rtf'){
	    				fn=url+"RtfServlet?"+urlParam;
	    				rA += "&nbsp;<a href='"+fn+"' target='blank'>"+txt+getDes('Rtf')+"</a> ";
	    			}else if(fram=='xls'){
	    				fn=url+"XlsServlet?"+urlParam;
	    				rA += "&nbsp;<a href='"+fn+"' target='blank'>"+txt+getDes('Xls')+"</a> ";
	    			}else if(fram=='flash'){
	    				fn=url+"swf_bei.jsp?"+urlParam;
	    				rA += "&nbsp;<a href='"+fn+"' target='blank'>"+txt+getDes('Flash')+"</a> ";
	    			}
    			}
    			return rA;
    		},getPdf:function(param){
    			var url=itemUrl;
    			return pb.fun.get(function(){
    				$.post(url+"PdfServlet",param);
    			});
    		}
    };
    window.imp={title:'引入',ok:'确定',cannot:"取消"};
    window.f_import=function(beginFun,endFun,url1,theFiles,impFiles,isAdd){//TODO 导入其他页
    	if(typeof beginFun =="function"){
    		    beginFun();
		}
    	parmParent.get();
    	if(typeof parmParent.showToParent !="undefined"&&parmParent.showToParent==0){
    		parmParent.showToParent=true;
    	}else{
    		parmaMap.showToParent=parmParent.showToParent-1;
    	}
    	var sw=$('body').width()-50;
    	var sh=$('body').height()-50;
    	sw=(sw<500)?500:(sw>900)?900:sw;
    	sh=(sh<600)?600:(sh>700)?700:sh;
    	var openMap={ title: imp.title, width:sw , height: sh, url: url1,opener:window,showToggle: true, showMax: true};
    	if(theFiles){
    		openMap.buttons=[
    		                 { text: imp.ok, onclick: function(item,dialog){
    		     	            var rows = dialog.frame.selectRows();
		     	            	  var vMap={};
		     		              var the=theFiles.split(";");
		     		              var imp=impFiles.split(";");
			     		          for(var i=0;i<the.length;i++){
			     		        	 if (!rows||rows.length<1){
			     		        		vMap[the[i]]="";
			     		        	 }else{
	     		            	     for(var h=0;h<rows.length;h++){
		     		            	     if(!vMap.hasOwnProperty(the[i])){
		     		            	    	vMap[the[i]]="";
		     		            	     }else{
		     		            	    	vMap[the[i]]+=",";
		     		            	     }
	     		            		     vMap[the[i]]+=rows[h][imp[i]];    		     		            		 
			     		             }
			     		        	 }
		     		              }
	     			              if(typeof endFun =="function"){
	     			            	 endFun(vMap);
	     			              }
    		     	               dialog.close();
    		     	            } 
    		                 },
    		                 { text:imp.cannot, onclick:function(item, dialog){ dialog.close();}}
    		 ];
    	}
    	imp={title:'引入',ok:'确定',cannot:"取消"};
    	if(typeof parmParent.showToParent == "boolean"&& parmParent.showToParent){
    		window.diaP =parent.$.ligerDialog.open(openMap);
    	}else{
    		window.diaP =$.ligerDialog.open(openMap);
    	}
    	if(typeof parmaMap.showMap=="undefined"||typeof parmaMap.showMap.showMax == "undefined"||parmaMap.showMap.showMax){
    	    window.diaP.max();
    	}
    };
    //TODO gridToobar
    pb.gridToobar={
    	    html:[],
    	    initHtml:function(t_){
    	        var s=this.html.join("");
    	        s=s.replace(/{pagesizeOptin}/, this.pageSizeOptions(t_.pageSizeOptions));
    	        return s;
    	    },    	   
    	    pageSizeOptions:function(pO){
    	       var option='';
    	       var selected='';
    	       for(var i=0,len=pO.length;i<len;i++){
    	    	  selected=(this.pageInfo.page_size==pO[i])?"selected":"";
    	          option+='<option value="'+pO[i]+'" '+selected+'>'+pO[i]+'</option>';
    	       }
    	       return option;
    	    },
    	    pageInfo:{
    	    	page:1,
    	    	page_size:20
    	    },
    	    render:function(data){
    		    var page=data.page;
    		    var page_size=data.page_size;
    		    this.pageInfo={
    		    		"page":page,
    	    	    	"page_size":page_size	
    		    };
    		    var page_count=data.page_count;
    		    var rowCount=data.rowCount;
    		    var bigin=(page-1)*page_size+1;
    		    var end=(page-1)*page_size+page_size;
    		    if(end>rowCount){
    		    	end=rowCount;
    		    }
    		    var s_=pb.fun.get(function(t){
    		    	pb.gridToobar.pageInfo.page_size=Number(t.value);    		    	
    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
    		    },'this').str;
    	      	var h_=['<div class="l-panel-bbar-inner">'];
    				h_.push('<div class="l-bar-group  l-bar-message"><span class="l-bar-text">'+$pb.lang.readDes(langDesMap,'显示从')+bigin+$pb.lang.readDes(langDesMap,'到')+end+'，总 '+rowCount+' 条 。每页显示：'+page_size+'</span></div>');    
    				h_.push('<div class="l-bar-group l-bar-selectpagesize"><select name="pb_rp" onchange="'+s_+'">{pagesizeOptin}</select></div>');
    				h_.push('<div class="l-bar-separator"></div>');
    				h_.push('<div class="l-bar-group">');
    				var classDis='';
    				var firstFun=pb.fun.get(function(p){
    	    		    	pb.gridToobar.pageInfo.page=Number(p);    		    	
    	    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
    	    		},1).str;    			
    				classDis=(page>1)?'<div class="l-bar-button l-bar-btnfirst"><span onclick="'+firstFun+'"></span></div>':'';
    				h_.push(classDis);
    				var prevFun=pb.fun.get(function(p){
	    		    	pb.gridToobar.pageInfo.page=Number(p);    		    	
	    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
	    		    },page-1).str;    			
				    classDis=(page>1)?'<div class="l-bar-button l-bar-btnprev"><span onclick="'+prevFun+'"></span></div>':'';
    				h_.push(classDis);
    				h_.push('</div>');
    				h_.push('<div class="l-bar-separator"></div>');
    				var inputFun=pb.fun.get(function(t){
    					var inPage=Number(t.value);
    					if(page_count<inPage||inPage<1){
    						alert('输入页面数不合理！');
    						return;
    					}
	    		    	pb.gridToobar.pageInfo.page=inPage;   		    	
	    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
	    		    },'this').str;
    				classDis=page_count>page?'<input type="text" onchange="'+inputFun+'" size="4" value="'+page+'" style="width:20px" maxlength="3">':page;
    				h_.push('<div class="l-bar-group"><span class="pcontrol">'+classDis+' / <span>'+page_count+'</span></span></div>');
    				h_.push('<div class="l-bar-separator"></div>');
    				h_.push('<div class="l-bar-group">');
    				var nextFun=pb.fun.get(function(p){
	    		    	pb.gridToobar.pageInfo.page=Number(p);    		    	
	    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
	    		    },page+1).str;    			
				    classDis=(page<page_count)?'<div class="l-bar-button l-bar-btnnext"><span onclick="'+nextFun+'"></span></div>':'';
    				h_.push(classDis);
    				var lastFun=pb.fun.get(function(p){
	    		    	pb.gridToobar.pageInfo.page=Number(p);    		    	
	    		    	window.pb.loadUrlData(pb.gridToobar.pageInfo);
	    		    },page_count).str;    			
				    classDis=(page<page_count)?'<div class="l-bar-button l-bar-btnlast"><span onclick="'+lastFun+'"></span></div>':'';
    				h_.push(classDis);
    				h_.push('</div>');
    				h_.push('<div class="l-bar-separator"></div>');
    				h_.push('<div class="l-clear"></div>');
    				h_.push('</div>');
    	       	this.html=h_;
    	    }
    	};
    window.selectRows=function(){
    	return window.pb.manager.getCheckedRows();
    };
	window.$pb = pb;
	window.parmaMap={};
	pb.dialog={
			map:{},
			get:function(key){
				return this.map[key];
			},set:function(key,obj){
				this.map[key]=obj;
			},init:function(){
				this.set("opener",{"parmaMap":parmaMap});
				window.dialog=this;
			}
	};
	window.parmParent={//TODO parmParent
			parm:null,
			showFiled:[],
			initValue:{},
			panelMap:{},
			showMap:{},
			endFun:null,
			urlParam:"",
			panel:{getData:function(){
			     var panel =(frameElement!= null)?frameElement.panel:null;
			     if(panel){
			    	 isMask=panel.options.isMask;
			    	 this.liuNo=panel.options.liuNo;
			    	 this.data=panel.options.data;
			    	 this.pbProccesNo=this.data.pbProccesNo;
			    	 this.hasJilu=panel.options.hasJilu;
			    	 if(isMask){
			    		 openMask();
			    	 }
			     }
                 return this.data;
			},reLoad:function(pk){
				var bakFun=function(p){
					if(p){
						parent.document.location.href=itemPath+"Template/panel_page.jsp?no="+parmParent.panel.liuNo+"&pbCode="+pk;
					}else{
						location.reload();
					}
				};
				if(ok||parmParent.panel.hasJilu){
					bakFun(ok);
				}else{
					$pb.DoUrl(itemPath+"xt/man.do?m=add&data=one",{"langNo":langNo,
						"langNoC":langNoC,
						"tableNo":"33",
						"DocCode":pk,
						"DocDate":$pb.Date.formatDate(new Date()),
						"FlowNnumber":parmParent.panel.liuNo,
						"FlowStep":parmParent.panel.pbProccesNo},tiketMap,function(data){
		      				if(data.code==0){
		      					bakFun(true);
		    				}else{
		    					pb.showMess("流程记录添加失败,反馈给开发者！", 500, function(){});
		    				}
						});
				}
			}
			},
			isHas:function(){
				var boo=false;
				if(frameElement!= null&&$pb.isNull(frameElement.dialog,'')!=''){
					boo=true;
				}
				if(!boo){
					if(parent!=null&&parent.dialog!=null&&frameElement!=null){
						frameElement.dialog=parent.dialog;
						boo=true;
					}
				}
				if(!boo){
					var parentData=parmParent.panel.getData();
					if(parentData){
						this.panelParm=true;
						boo=true;
					}
				}
				return boo;
			},
			get:function(obj){
				this.parm={};
				if(this.isHas()){
					if(this.panelParm){
						var p_=parmParent.panel.getData();
						if(p_.hasOwnProperty("pbCode")){
							this.parm=p_;
						}
					}else{
						var t_dialg=(frameElement==null)?parent.dialog:frameElement.dialog;
						this.parm=pb.clone(t_dialg.get('opener').parmaMap);
					}
					var getField=["showFiled","initValue","panelMap","showMap","endFun","showToParent","urlParam","checkbox","checkFun"];
					var has_=";"+getField.join(";")+";";
					var x_=pb.clone(this.parm);
					for(var key in x_){
						if(has_.indexOf(";"+key+";")!=-1){
							this[key]=this.parm[key];
							delete parmParent.parm[key];
						}
					}
				}
				if(pb.isNull(obj, "")==""){
				    return this.parm;
				}else{
					return this;
				}
			},set:function(key,value){
				frameElement.dialog.get('opener').parmaMap[key]=value;
			}
	};
	window.pb_Pan=null;//面板对象
	
	window.count=function (o){
	    var t = typeof o;
	    if(t == 'string'){
	            return o.length;
	    }else if(t == 'object'){
	            var n = 0;
	            for(var i in o){
	                    n++;
	            }
	            return n;
	    }
	    return false;
	}; 
})( window , itemPath);
(function(itemUrl,$pb){//TODO 时间
$pb.Date={
	getLocalTime:function(nS,hm){
	    		if(typeof (nS) != "number"){
			return nS;
		}
		if(typeof hm =="undefined"){
			hm=1;
		}
		return this.formatDate(new Date(parseInt(nS) * hm));
	},formatDate:function(now,format)   {     
        var   year=now.getFullYear();     
        var   month=now.getMonth()+1;     
        var   date=now.getDate();     
        var   hour=now.getHours();     
        var   minute=now.getMinutes();     
        var   second=now.getSeconds(); 
        format=$pb.isNull(format,"yyyy-MM-dd HH:mm:ss");
        date=(date.toString().length==1?"0":"")+date;
        month=(month.toString().length==1?"0":"")+month;
        var restr=format.replace("yyyy",year).replace("MM",month).replace("dd",date).replace("HH",hour).replace("mm",minute).replace("ss",second);
        return  restr;// year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;     
    },diff:function(begin,end){
    	var day1 = new Date(begin);
    	var day2 = new Date(end);
    	var diff = day2.getTime()-day1.getTime();
    	var day_diff = Math.floor(diff/(24*3600*1000)); 
    	var mo = diff%(24*3600*1000);
    	var house_diff = Math.floor(mo/(3600*1000));
    	mo = mo%(3600*1000);
    	var minutes_diff = Math.floor(mo/(60*1000));
    	mo = mo%(60*1000);
    	var seconds_diff = Math.floor(mo/1000);
    	return {"day":day_diff,"house":house_diff,"minutes":minutes_diff,"seconds":seconds_diff};
    }
};
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 数据处理
$pb.Data={
	 select:function(selectNo,fun){
	    			this.load($pb.mergeMap({"sNo":selectNo,"pbCol":"sNo,sValue,text"},$pb.lang.getlangMap(langNo,langNoC)),tiketMap,"145",'',function(data){
	    				if(typeof fun == "function"){
	    					fun(data);
	    				}
	    			});
	},load:function(param,tiketMap,pbUrlId,cols,fun,addParam){
		var url=this.loadUrl(pbUrlId, addParam); //itemUrl+"/xt/man.do?"+addParam;
		if(cols){
			param["pbCol"]=cols;
		}
		if(!isNaN(parseInt(pbUrlId))){
		 param["pb_UrlId"]=pbUrlId;
		}
		$pb.DoUrl(url,param,tiketMap, function(data){
			if(typeof (fun) =="function"){
				fun(data);
			}
        });			
	},loadUrl:function(pbUrlId,addParam){
		if($pb.isNull(addParam, '')==''){
			addParam="m=get&data=list";
		}
		var url=itemUrl+"/xt/man.do?"+addParam;
		if(isNaN(parseInt(pbUrlId))){
			url= itemUrl+pbUrlId+"?"+addParam;
		}
		return url;
	},gridLoad:function(param,tiketMap,pbUrlId,cols,fun){
		return this.load(param, tiketMap, pbUrlId, cols, fun, "m=get&data=list");
	},panLoad:function(param,tiketMap,pbUrlId,cols,fun){
		return this.load(param, tiketMap, pbUrlId, cols, fun, "m=get&data=one");
	},toGrid:function(data){
		return {Rows:data,Total:data.length};
	},toTreeGrid:function(data,node,parentNode){//（数据,子节点名称，父节点名称）
		return {Rows:$pb.findTreeMap(data,node,parentNode),Total:data.length};
	},gridSave:function(gManger,tiketMap,pbUrlId,priId,fun,langMap){
		if(clickBtn){
			return ;//禁止多次点击按钮
		}
		clickBtn=true;//禁止下次进入
		var doMap={};
		if(gManger!=null && typeof gManger != "undefined"){
			doMap={
				"delete":$pb.grid.getDeleteWhere(gManger.getDeleted(),priId),
				"add_data":gManger.getAdded(),
				"up_data":$pb.grid.getData(gManger.getUpdated(),"children")			
		    };
			for(var i in doMap["up_data"]){
				var row=doMap["up_data"][i];
				if(!row.hasOwnProperty(priId)||$pb.isNull(row[priId],'')==""){
					doMap["up_data"].splice(i,1); 
				}
			}
		}
         var form = new liger.get("panFrom");
         if(typeof form.getData == "function"){
        		doMap["panel"]=$pb.panel.getData(form);// form.getData();
         }
		if(langMap!=null){
			$pb.mergeMap(doMap,langMap);    		
		}
		var url=itemUrl+"xt/man.do?m=sqlAll";
		if(isNaN(parseInt(pbUrlId))){
			url= itemUrl+pbUrlId+"?m=sqlAll";
			if(pbUrlId.indexOf('man.do')!=-1){
			  doMap["pb_UrlId"]=pb_UrlId;
			}
		}else{
			doMap["pb_UrlId"]=pbUrlId;
		}
		var saveing= $.ligerDialog.waitting('正在保存，请稍等.....');
		$pb.DoUrl(url,doMap,tiketMap,function(data){
			setTimeout(function (){
                saveing.close();
            }, 1000);  
			if(data.code==0){
				var nextFun=function(){
  					if(typeof (fun) =="function"){
    					fun(data);
    			    }else{
    			    	location.reload();
    			    }
				};
				var pbCode=data.pbCode;
				if(ok){//TODO 确认
					var tC_=parmParent.panel.data.pbCode;
					if(tC_!=null&&tC_!=""){
						pbCode=tC_;
					}
					$pb.DoUrl(itemPath+"xt/tb.do?m=ok",{
						"pbCode":pbCode,
						"pbProccesNo":parmParent.panel.pbProccesNo,
						"user_id":user_id,
						"liuNo":parmParent.panel.liuNo
						},tiketMap,function(data_ok){
		      				if(data_ok.code==0){
		      				     nextFun({"pbCode":pbCode});
		    				}else{
		    					$pb.showMess("确认失败,反馈给开发者！", 500, function(){});
		    				}
		      				clickBtn=false;
						});
				}else{
					nextFun();
					clickBtn=false;
				}
			}else{
				$.ligerDialog.confirm(data.messageTxt, function (yes) {
					clickBtn=false;
				});
			}
		});
	},setGrid:function(gObj,dataMap,gIndex){
		for(var i in dataMap){
			gObj.updateCell(i,dataMap[i],gIndex);
		}
	},loadArrayDes:function(arr,fun){
		if(arr.length>0){
			$pb.Data.loadDes($pb.mergeNewMap(arr[0],{"endfun":function(){
				arr.shift();
				$pb.Data.loadArrayDes(arr,fun);
			}}));
		}else{
			fun();
		}
	},loadDes:function(m,wy){
		var tNo=$pb.isNull(m["tableNo"], "0");
		var col=$pb.isNull(m["col"], "");
		var pk=$pb.isNull(m["pk"], "0");
		var pageNo=$pb.isNull(m["pageNo"], "0");
		var cache=$pb.isNull(m["cache"], "0");
		if(pk=="0"){
			return ;
		}
		//if(col==""){
		//	return ;
		//}
		var param={};
		var action="xt/man.do";
		var me_="m=get&data=list";
		if(m.hasOwnProperty("param")){
			param=m["param"];		
		}
		if(tNo!="0"){
			action="xt/tb.do";
			param["tableNo"]=tNo;
			tNo=tNo+"_table";
		}else{
			if(pageNo!="0"){
				action=pageNo;
			}
			tNo=pageNo+"_page";
		}
		var pkV;
		if(param.hasOwnProperty(pk)){
			pkV=param[pk];
		}else{
			pkV=wy;
			if(pkV==""){
				return null;
			}
			param[pk]=pkV;
		}
		var isRow=false;
		if(col==""||col.indexOf(",")!=-1){
			isRow=true;
		}
		var cn_={};
		if(cache!="0"){
			var n_=localStorage[tNo+pkV];
			if (n_ != null && n_ != "") {
				cn_=JSON2.parse(n_);
				if(!arrayFiled.hasOwnProperty(tNo)){
				arrayFiled[tNo]={};
				}
				if(!arrayFiled[tNo].hasOwnProperty(pkV)){
					arrayFiled[tNo][pkV]=cn_;
				}
			}
		}
		if(!arrayFiled.hasOwnProperty(tNo)||!arrayFiled[tNo].hasOwnProperty(pkV)||!arrayFiled[tNo][pkV].hasOwnProperty(col)){
			param=$pb.mergeMap(param,$pb.lang.getlangMap(langNo,langNoC));
		    this.load(param,tiketMap,action,(col==""?"*":(pk+","+col)), function(data){
		    	var theRow=null;
				if(data.code==0){
					var row;
					var thePkv;
					for(var ri in data.data){
						row=data.data[ri];
						thePkv=row[pk];
						if(typeof arrayFiled[tNo] == "undefined"){
							arrayFiled[tNo]={};
						}
//						if(typeof arrayFiled[tNo][pkV] == "undefined"){
//							arrayFiled[tNo][pkV]={};
//						}
						arrayFiled[tNo][thePkv]=row;
						if(cache!="0"){
							localStorage[tNo+thePkv]=JSON2.stringify(row);
					    }
//						if(wy){
//							if(typeof arrayFiled[tNo][wy] == "undefined"){
//								arrayFiled[tNo][wy]={};
//							}
//							arrayFiled[tNo][wy]=row;
//						}
					}
					if(pkV){
					  theRow=arrayFiled[tNo][pkV];
					}else{
					  theRow=arrayFiled[tNo][thePkv];
					}
			  }
				if(m.hasOwnProperty("endfun")){
					if(typeof m["endfun"]=="function"){
						if(isRow){
						   m["endfun"](theRow);
						}else{
						   m["endfun"](theRow[col]);
						}
					}
				}
			},"m=get&data=list");
		}else{
			var t_;
			if(isRow){
				t_= arrayFiled[tNo][pkV];
			}else{
				t_= arrayFiled[tNo][pkV][col];
			}
//			if(m.hasOwnProperty("endfun")){//如果是缓存中的值 就不执行结束函数
//				if(typeof m["endfun"]=="function"){
//					m["endfun"](t_);
//				}
//			}else{
				return t_;
//			}
		}	
	},loadDate:function(tableNo,col,pk,parm,wId,showCol){
		var parmMap={"tableNo":tableNo,"col":col,"pk":pk};
		var des=$pb.Data.loadDes($pb.mergeNewMap(parmMap,{"param":parm,"endfun":function(row){
			  if(col.indexOf(",")==-1&&showCol==null){
				  showCol=col; 
			  }
			  if(row==null){
				  row={showCol:""};
			  }
			$('#span_des_'+wId).html(row[showCol]);
		}}));
		return '<span id="span_des_'+wId+'">'+des+'</span>'; 
	},loadPic:function(tabKey,tableNo,tabFiled,site_id,imageId,item){//TODO 加载图片
		if($pb.isNull(tabKey,"")==""){
			return;
		}		
		var p_={"tabKey":tabKey,"tableName":tableNo,"tabFiled":tabFiled};
		$pb.Data.load({}, tiketMap, "/item.do", "*", function(data){
			if(data.code!=0){
				return "";
			}
			var row1=data.data[0];
				if(row1==null){
					row1={filepath:null};	
				}
				var imagSrc=itemUrl+ "/images/upload.jpg";
			    if(row1.filepath){
			      imagSrc=row1.filepath;
			      if(row1.filepath.indexOf('http')==-1){
			        imagSrc=itemUrl+imagSrc;
			      }
			    }
			    var tuHeight="24px";
			     var tu='<img id="'+imageId+'" '+(row1.filepath?"":'title="图上传或者修改"')+' height="'+tuHeight+'"  src="'+imagSrc+'"/>';                  
			     var tu_imp=tu;
			     if(getRowEdit(item)){//禁止修改
			       tu_imp=$pb.edit.import_(function(){
		    	   for(var tipid in $.ligerui.managers){
		    		   if(tipid.indexOf('Tip')==0){//清除所有弹出层
		    			   $.ligerui.managers[tipid].remove();
		    		   }			    		  
		    	   };
		          	imp.title="图片上传";
		            parmaMap={
		                  "tabKey":tabKey,"src":row1.filepath,
		                  "tableNo":tableNo,
		                  "tabFiled":tabFiled,
		                  "site_id":site_id,"picId":row1.picId,"ptKey":row1.ptKey,
		                  "showMap":{"showMax":false},
		                   "endFun":function(src){	                             
		                    diaP.close();
							gManage=window.pb.manager;
							gManage.beginEdit(item.__index);
                    		gManage.cancelEdit(item.__index);
		                     //location.reload();
		                  }
		            };                    
		       },"","xt/pic.jsp","","",false,tu,item);
			  }
		    $('#span_'+imageId).html(tu_imp);
		    if(row1.filepath){
		       qiPaoImg(imageId,imagSrc,300,300);
		    }
		}, "m=img&tableNo="+tableNo+"&tabKey="+tabKey+"&tabFileds="+tabFiled);
//		$pb.Data.loadDes({"param":p_,"tableNo":"28","pk":"ptKey","endfun":function(row){
//			if(row==null){
//				row={picId:null,ptKey:null};
//			}
//			$pb.Data.loadDes({"tableNo":"26","pk":"id","endfun":function(row1){
//				if(row1==null){
//					row1={filepath:null};	
//				}
//				var imagSrc=itemUrl+ "/images/upload.jpg";
//			    if(row1.filepath){
//			      imagSrc=row1.filepath;
//			      if(row1.filepath.indexOf('http')==-1){
//			        imagSrc=itemUrl+imagSrc;
//			      }
//			    }
//			    var tuHeight="24px";
//			     var tu='<img id="'+imageId+'" '+(row1.filepath?"":'title="图上传或者修改"')+' height="'+tuHeight+'"  src="'+imagSrc+'"/>';                  
//			     var tu_imp=tu;
//			     if(getRowEdit(item)){//禁止修改
//			       tu_imp=$pb.edit.import_(function(){
//	              	imp.title="图片上传";
//	                parmaMap={
//	                      "tabKey":tabKey,"src":row1.filepath,
//	                      "tableNo":tableNo,
//	                      "tabFiled":tabFiled,
//	                      "site_id":site_id,"picId":row.picId,"ptKey":row.ptKey,
//	                      "showMap":{"showMax":false},
//	                       "endFun":function(src){	                             
//	                         diaP.close();
//	                         location.reload();
//	                      }
//	                };                    
//	           },"","xt/pic.jsp","","",false,tu,item);
//			  }
//			    $('#span_'+imageId).html(tu_imp);
//			    if(row1.filepath){
//			       qiPaoImg(imageId,imagSrc,300,300);
//			    }
//			   // document.getElementById(pb.manager._getRowDomId(item,false)).style.height=tuHeight;
//			   // document.getElementById(pb.manager._getRowDomId(item,true)).style.height=tuHeight;
//			}},row.picId);		  
//		}});
		return '<span id="span_'+imageId+'"></span>';
	}
};
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 转换函数
	$pb.fun={
			index:0,
			get:function(fun,parma){
				var i=this.index;
				this.index=i+1;
				var strFun="$pb.fun["+i+"]";
				var rStr=strFun;
				if(typeof fun =="function"){
					$pb.fun[i]=function(obj){
						fun(obj);
					};
					if(typeof parma != 'undefined'){
						rStr+="("+parma+")";
					}else{
						rStr+="()";	
					}
				}else{
					$pb.fun[i]=fun;
				}
				return {str:rStr,funObj:function(){return $pb.fun[i];},"strFun":strFun};
			}
	}; 
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 快捷键
	$pb.key={
		index:0,
		enterFun:[],
		addExecFun:[],
		enter:function(fun){
			$pb.key.enterFun.push(fun);
		},exec:function(ifFun,doFun){
			if(typeof ifFun=="function"){
				if(ifFun()){
					doFun();
				}
			}
		},addExec:function(ifFun,doFun){
			$pb.key.addExecFun.push({"ifFun":ifFun,"doFun":doFun});
		},hotkey:function(event){
			if(typeof tiketMap == "undefined"){
				try{
				  tiketMap=JSON2.parse($.cookie('ticketMap'));
				}catch(e){
					
				}
			}
			var ieBoo=true;
			try{
				ieBoo=$.browser.msie;
			}catch (e) {
				ieBoo=false;
			}
			if(ieBoo) {//IE浏览器
			    var fr=parent.frames;	
				for(var i=0;i<fr.length;i++){
					if(fr[i].event!=null){				
						event=fr[i].event;
						break;
					}
				}
				if(event==null){		
					event=window.event;	
				}
			}	
			var e=window.event||event;
			var eCode=e.keyCode;
			if(event.keyCode==13||event.which==13){//enter
				if($pb.key.enterFun.length>0){
					for(var i=0,len=$pb.key.enterFun.length;i< len ;i++){
						fun=$pb.key.enterFun[i];
						if(typeof fun == "function"){
							fun();
						}
					}
				}
			}else if(is_super=="true"){
				if(typeof pb_UrlId =='undefined'){
					$pb.getUrlId(function(data){
						if(data.code==0){
							pb_UrlId=data.data.id;
						}
					});
				}
				if($pb.key.addExecFun.length>0){
					for(var i=0,len=$pb.key.addExecFun.length;i< len ;i++){
						obj=$pb.key.addExecFun[i];
						$pb.key.exec(function(){//
							return obj['ifFun'](e);
						}, obj["doFun"]);
					}
				}
			}
		}
	};
	document.onkeydown =$pb.key.hotkey;
	$pb.key.addExec(function(e){//a
		return (e.keyCode==65)&&(e.ctrlKey)&&(e.shiftKey);
	}, function(){
		f_import(function(){
			imp.title=pb_UrlId+":"+getDes("页面设置");
			parmaMap={};
			parmaMap.id=pb_UrlId;
			}, '', itemUrl+"xt/pOpenTree.jsp");
	});
	$pb.key.addExec(function(e){//s
		return (e.keyCode==83)&&(e.ctrlKey)&&(e.shiftKey);
	}, function(){
		$pb.bulid(pb_UrlId,tiketMap);
	});
	$pb.key.addExec(function(e){//z
		return (e.keyCode==90)&&(e.ctrlKey)&&(e.altKey);
	}, function(){
		var neiM_=function(id){
			f_import(function(){
			imp.title=id+":引入";
			parmaMap={};
			parmaMap["initValue"]={
			   "pPageNo":id
			};
			parmaMap["panelMap"]={
			   "pPageNo":id
			};
			},'',itemUrl+'xt/biao.jsp','','',false,getDes('字段设置'));
		};
		neiM_(pb_UrlId);
	});
	$pb.key.addExec(function(e){//n
		return (e.keyCode==78)&&(e.ctrlKey)&&(e.altKey);
	}, function(){
		var neiM_=function(id){
			f_import(function(){
				imp.title=id+":查看内部模块";
				parmaMap={};
				parmaMap["ifnull((case urlId when '' then null else urlId end),'"+id+"')"]=id;
				parmaMap["initValue"]={
				"urlId":id
				};
				},'',itemUrl+'xt/pr.jsp','','',false,getDes("内模板"));
		};
		neiM_(pb_UrlId);
	});
	$pb.key.addExec(function(e){//m
		return (e.keyCode==77)&&(e.ctrlKey)&&(e.altKey);
	}, function(){
		var neiM_=function(id){
			f_import(function(){
			   imp.title=id+":语言描述";
			 parmaMap=$pb.lang.getlangMap(langNo,langNoC); parmaMap.uId=id ;
			},"",itemUrl+"xt/des.jsp","","",false,getDes("语言描述")); 
		};
		neiM_(pb_UrlId);
	});
	$pb.key.addExec(function(e){//x
		return (e.keyCode==88)&&(e.ctrlKey)&&(e.altKey);
	}, function(){
		f_import(function(){
			   imp.title=pb_UrlId+":下拉值设置";
			   parmaMap=$pb.lang.getlangMap(langNo,langNoC); parmaMap.sNo=$pb.select.keys;
			   parmaMap.all="true";
		},"",itemUrl+"xt/xll.jsp","","",false,getDes("下拉值设置")); 
	});
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 下拉
	$pb.select={
		   value:{},
		   keys:["kqj"],
		   getObj:function(get_xl){
			   return $pb.select.value[get_xl+"_select"];
		   },
		   exec:function(xl,data,fun){
			   window.localStorage[xl]=JSON2.stringify(data);
			   var t_={"data":data,"map":$pb.findMap(data,'sValue')};
			   $pb.select.value[xl]=t_;
			   return t_;
		   },		  
		   get:function(get_xl,fun){
			   var theParm=[];
			   if(!$pb.isArray(get_xl)){
				   get_xl=[get_xl];
			   }
			   if(typeof fun =="function"){
				   $(get_xl).each(function(i,v){
					   if($.inArray(v,$pb.select.keys)==-1){
						   $pb.select.keys.push(v);
						   var xl=v+"_select";
						   if(!$pb.select.value.hasOwnProperty(xl)){
							   t_=window.localStorage[xl];
							   t_=(t_==null||t_=="[]")?{}:{"data":JSON2.parse(t_)};
							   if(t_.hasOwnProperty("data")){
								   $pb.select.exec(xl,t_["data"]);
							   }else{
								   theParm.push(v);
							   }
						   }
					   }
				   });
				   if(theParm.length>0){
					   $pb.Data.select(theParm,function(sdate){
						   if(sdate.code==0){
							   var kList=$pb.findMap(sdate.data,"sNo");
							   for(var key in kList){
								   $pb.select.exec(key+"_select",kList[key]);
							   }
						   }
						    fun();
						});
			      }else{
			    	  fun();
			      }
		      }else{
		    	  $pb.showMess("小传function参数了",200); 
		      }
//			   }else{
//				   var xl=get_xl+"_select";
//				   if($.inArray(get_xl,$pb.select.keys)==-1){
//					   $pb.select.keys.push(get_xl);
//				   }
//				   if(typeof fun =="function"){
//					   var t_={};
//					   if($pb.select.value.hasOwnProperty(xl)){
//						   fun($pb.select.value[xl]);
//					   }else{
//						   t_=window.localStorage[xl];
//						   t_=(t_==null||t_=="[]")?{}:{"data":JSON2.parse(t_)};
//						   if(t_.hasOwnProperty("data")){
//							   fun($pb.select.exec(xl,t_["data"]));
//						   }else{
//							   $pb.Data.select(get_xl,function(sdate){
//								   if(sdate.code==0){							   
//									   fun($pb.select.exec(xl,sdate.data));
//								   }else{
//									   fun($pb.select.exec(xl,[]));
//								   }
//								});
//						   }
//					   }
//				   }else{
//					   $pb.showMess("小传function参数了",200);
//				   }
//			   }
		   },remove:function(show){
			   for(var key in window.localStorage){
		           if(key.indexOf("_select")!=-1){
		               window.localStorage.removeItem(key);
		           }
		       }
			   if(show==null||show){
			      $pb.showMess("清楚缓存完成！",1000);
			   }
		   }
	   };
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 只读设置
	$pb.panel={
		readOnly:function(paneFrame,fields){
			if(paneFrame!=null){
				for(var i in fields){
					var el=this.getElement(paneFrame,fields[i],function(obj){
							obj.control.setDisabled("");//所有类型控件 都设置为只读
							//obj.control.updateStyle();
					});
					if(el){
						$(el).attr({"readonly":true});
						$(el).css({"background":"#EAEAEA","color":"#000"});
					}
				}
			}
		},getElement:function(paneFrame,field,contorlFun){
			var fileObj=this.getPanelAll(paneFrame)[field];
			if(fileObj){
				var el=fileObj.el;
				var t_type=fileObj.type;
				var control=fileObj.control;
				if(typeof contorlFun =="function"){
					contorlFun({"type":t_type,"control":control});
				}
			}
			return el;
		},getPanelAll:function(paneFrame){
			var panAll=$pb.isNull(this.panelObj_,{});
			if($.isEmptyObject(panAll)&&paneFrame!=null){
				for(var e_ in paneFrame.editors){
					control=paneFrame.editors[e_].control;
					var name=control.id;
					t_type=control.type;
					if(name==null){
					  name=control[0].name;
					  t_type=control[0].type;
					}
					switch(t_type){
					   case "TextBox":
					   case "DateEditor":
						   el=control.inputText;
						break;
					   case "CheckBox":
						   el=control.input;
						break;
						default:
							el=control[0];
							break;
					}
					panAll[name]={"el":el,"type":t_type,"control":control};
				}
				this.panelObj_=panAll;
			}
			return panAll;
		},getValue:function(paneFrame,field){
			var v=$(this.getElement(paneFrame, field)).val();
			alert(v);
		},getData:function(paneFrame){
			if(paneFrame!=null){
		         var data = paneFrame.getData();
		         var fields=paneFrame.options.fields;
		         $(fields).each(function(){
		        	 if(this.type=="date"){
		        		 if(this.dataAuto){//
		        			delete data[this.name];
		        		 }else{
				        	 var el=$pb.panel.getElement(paneFrame,this.name);
				        	 data[this.name]=$(el).val();
		        		 }
		        	 }else if(this.type=="checkbox"){
		        		 data[this.name]=data[this.name]?1:0;
		        	 }
		         });
		         return data;
			}
			return null;
		},init:function(paneFrame){
			if(paneFrame!=null){
				var fields=paneFrame.options.fields;
				for(var i in fields){
					var row=fields[i];
					var readOnly_=(row.disabled!=null)?true:false;
					var field=row.name;
					if(row.validate){
						if(!row.validate.required){
							var el=this.getElement(paneFrame,field);
							$(el).attr({"class":"required"});
						}
					}
					if(row.type=="date"){
						var el=this.getElement(paneFrame,field);
						readOnly_=(row.dataAuto)?true:false;
					}
					if(readOnly_){
						this.readOnly(paneFrame, [field]);
					}
				}
			    this.readOnly(paneFrame,["pbCode","pbProccesNo"]);
			}
		}			
	};
})(itemPath,$pb);
(function(itemUrl,$pb){//TODO 用户信息
	$pb.user={
			getUserInf:function(){
				return {user_id:user_id};
			}
	};
})(itemPath,$pb);
//var _hmt = _hmt || [];
//(function() {
//  var hm = document.createElement("script");
//  hm.src = "https://hm.baidu.com/hm.js?9dd2e4160f16907c2d7bd217052e3d23";
//  var s = document.getElementsByTagName("script")[0]; 
//  s.parentNode.insertBefore(hm, s);
//})();
$(function(){
	if(isMask){
		openMask();
	}
	css_init_to($pb.getQueryString("skin"));
});
$(window).bind("beforeunload",function(){
	if(typeof showUnload =="undefined" || showUnload){
	   // return "刷新页面,未保存数据将丢失！是否继续？";
	}
 });