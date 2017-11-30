(function ()
{  
    var homepage = true;
    var tab;



    var isDesign = (function ()
    {
        return true;

        var url = window.location.href;
        return url.toLowerCase().indexOf("creator.") != -1 || url.toLowerCase().indexOf("designmode=y") != -1;

    })();

    window.initTab = function (o)
    {
        tab = o;

        if (tab.menu)
        {
            var menuitem = {
                text: '编辑视图' ,
                click: function ()
                { 
                    var tabid = tab.actionTabid;
                    var contentitem = $(".l-tab-content-item[tabid=" + tabid + "]"); 
                    var iframe = $("iframe:first", contentitem);
                    var url = "";
                    if (iframe.length)
                    {
                        url = iframe.attr("src");
                    } else
                    {
                        url = contentitem.children(":eq(0)").attr("data-url") 
                    }
                    var model = ne.getUrlParm(url, "model");
                    var viewtype = ne.getUrlParm(url, "viewtype");
                    var viewname = ne.getUrlParm(url, "viewname"); 

                    openTab({
                        url: 'web/main?model=home&viewname=viewEditor#'+model+'/' + (viewname || viewtype),
                        text: '编辑视图',
                        showClose: true,
                        tabid: 'vieweditor'
                    });
                }
            };
            tab.menu.addItem({ line: true });
            tab.menu.addItem(menuitem);

        }
    };
    window.setTabTitle = function (tabid, title)
    {
        tab.setTabItemTitle(tabid, title);
    };
    window.setTabSrc = function (tabid, url)
    {
        url = ne.getAppUrl(url);
        tab.setTabItemSrc(tabid, url);
    };

    window["removeTab"] = ne.removeTab = function (tabid)
    {
        tab.removeTabItem(tabid);
    };

    window["openTab"] = ne.openTab = function (options, tabid, text)
    {
        if (typeof (options) == "string")
        {
            options = {
                url: options,
                tabid: tabid,
                text: text
            };
        }
        var p = options || {};
        if (NextEasy && NextEasy.config && NextEasy.config.singlePage)
        {
            if (p.url && p.url.indexOf('web/main?') > -1)
            {
                singlePage_open(options);
                return;
            }
        }
        p.url = ne.getAppUrl(p.url);
        var tabid = p.tabid, text = p.text || p.title, url = p.url;
        if (tab.isTabItemExist(tabid))
        {
            var tabTitle = tab.getTabItemTitle(tabid),
                tabSrc = tab.getTabItemSrc(tabid);
            if (tabTitle != text)
            {
                tab.setTabItemTitle(tabid, text);
            }
            if (tabSrc != url)
            {
                tab.setTabItemSrc(tabid, url);
            }
            tab.selectTabItem(tabid);
            return;
        }
        tab.addTabItem(p);
    };
    
    function getRunnerOp(url,target)
    {
        var model = ne.getUrlParm(url, "model");
        var viewtype = ne.getUrlParm(url, "viewtype");
        var viewname = ne.getUrlParm(url, "viewname");
        var isView = ne.getUrlParm(url, "isView");
        var id = ne.getUrlParm(url, "id");

        var initOp = {
            model: model,
            viewType: viewtype,
            isView: isView ? true : false,
            showInDialog: false,
            viewName: viewname,
            renderTo: target
        };
        if (id)
        {
            initOp.formContext = id;
        }
        return initOp;

    }

    function singlePage_open(options)
    { 
        var op = $.extend({}, options);

        NextEasy.traceTime("打开TAB:" + op.text);
        var url = op.url;
         
        if (tab.isTabItemExist(op.tabid))
        {
            jtarget = $(".l-tab-content-item[tabid=" + op.tabid + "] .nexteasypage:first", tab.tab.content);
            var tabTitle = tab.getTabItemTitle(op.tabid),
            tabSrc = jtarget.attr("data-url");
            tab.selectTabItem(op.tabid);
            if (tabTitle != op.text)
            {
                tab.setTabItemTitle(op.tabid, op.text);
            }
            if (tabSrc != url)
            {
                jtarget.attr("data-url", url);
                jtarget.html(""); 
                var runner = new ne.web.init(getRunnerOp(url,jtarget.get(0)));
                runner.run();
            }
            return;
        }

        var jtarget = $("<div class='ne-view nexteasypage'></div>");
        
        op.url = "";
        op.target = jtarget.get(0);
        op.target.tabOpener = tab;
     
     
        var initOp = getRunnerOp(url, jtarget.get(0));
         
        jtarget.attr("data-url", url);
        tab.addTabItem(op);
        var runner = new ne.web.init(initOp);
        runner.run();

        jtarget.get(0).tabReload = function ()
        {
            jtarget.html("");
            var runner = new ne.web.init($.extend({},initOp)); 
            runner.run();
        };
    }
     
    
    //刷新 iframe方法
    window.callFrame = function(frameName, fnName)
    {
        var ele = $("#" + frameName);
        if (!ele.length) return;
        ele = ele[0];
        if (!ele.contentWindow || !ele.contentWindow[fnName]) return;
        ele.contentWindow[fnName]();
    }

    window.openDialog = function(options)
    {
        var w = $(window).width(), h = $(window).height();
        var p = $.extend({
            height: h * 0.9,
            width: w * 0.9,
            showMax: false,
            showToggle: true,
            showMin: false,
            isResize: true,
            slide: false
        }, options);
        return $.ligerDialog.open(p);
    }


})();