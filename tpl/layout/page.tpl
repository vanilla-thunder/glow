[{capture append="oxidBlock_pageHeader"}]
    [{if $oView->getClassName() != "start" && !$blHideBreadcrumb}]
        [{block name="layout_breadcrumb"}]
            [{strip}]
                <ol id="breadcrumb" class="breadcrumb">
                    [{block name="dd_widget_breadcrumb_list"}]
                        <li class="text-muted">[{oxmultilang ident="YOU_ARE_HERE"}]:</li>
                        [{foreach from=$oView->getBreadCrumb() item="sCrum" name="breadcrumb"}]
                            <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"[{if $smarty.foreach.breadcrumb.last}] class="active"[{/if}]>
                                <a href="[{if $sCrum.link}][{$sCrum.link}][{else}]#[{/if}]" title="[{$sCrum.title|escape:'html'}]" itemprop="url">
                                    <span itemprop="title">[{$sCrum.title}]</span>
                                </a>
                            </li>
                        [{/foreach}]
                    [{/block}]
                </ol>
            [{/strip}]
        [{/block}]
    [{/if}]
[{/capture}]

[{capture append="oxidBlock_pageBody"}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
    [{assign var="sActiveClass" value=$oView->getClassName() }]
    [{assign var="aSidebarConfig" value=$oViewConf->getViewThemeParam('aSidebarConfig')}]
    [{if $oViewConf->getViewThemeParam('blKeepDefaultSidebar') }]
        [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass|default:$sidebar }]
    [{else}]
        [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass }]
    [{/if}]
    <div id="wrapper">

        <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">

            <div class="content-box">
                [{$smarty.capture.loginErrors}]
                <div class="row">
                    [{if $sidebar && $sidebar|strtolower == "left"}]
                        <div class="col-xs-12 col-md-3 [{$oView->getClassName()}]">
                            <div id="sidebar">
                                [{include file="layout/sidebar.tpl"}]
                            </div>
                        </div>
                    [{/if}]

                    <div class="col-xs-12 [{if $sidebar|strtolower == "left" || $sidebar|strtolower == "right"}]col-md-9[{/if}]">

                        <div id="content">
                            [{block name="content_main"}]
                                [{include file="message/errors.tpl"}]

                                [{foreach from=$oxidBlock_content item="_block"}]
                                    [{$_block|strip}]
                                [{/foreach}]
                            [{/block}]
                        </div>

                    </div>

                    [{if $sidebar && $sidebar|strtolower == "right"}]
                        <div class="col-xs-12 col-md-3 [{$oView->getClassName()}]">
                            <div id="sidebar">
                                [{include file="layout/sidebar.tpl"}]
                            </div>
                        </div>
                    [{/if}]
                </div>

            </div>

        </div>

    </div>
    [{block name="layout_init_social"}][{/block}]
    <i class="fa fa-chevron-circle-up icon-4x" id="jumptotop"></i>
    <div id="outdated">
        <h6>[{oxmultilang ident="OUTDATED_OLDBROWSER"}]</h6>
        <p>[{oxmultilang ident="OUTDATED_UPDATENOW"}] <a id="btnUpdateBrowser" href="http://outdatedbrowser.com/[{$oView->getActiveLangAbbr()}]">[{oxmultilang ident="OUTDATED_GETNEWBROWSER"}]</a></p>
        <p class="last"><a href="#" id="btnCloseUpdateBrowser" title="Close">&times;</a></p>
    </div>
[{/capture}]
[{include file="layout/base.tpl"}]