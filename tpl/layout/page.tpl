[{capture append="oxidBlock_pageHeader"}]
    [{if $oView->getClassName() != "start" && !$blHideBreadcrumb}]
        [{block name="layout_breadcrumb"}]
            [{strip}]
                <ol id="breadcrumb" class="breadcrumb">
                    [{block name="dd_widget_breadcrumb_list"}]
                        <li class="text-muted">[{oxmultilang ident="YOU_ARE_HERE"}]:</li>
                        [{foreach from=$oView->getBreadCrumb() item="sCrum" name="breadcrumb"}]
                            <li   [{if $smarty.foreach.breadcrumb.last}] class="active"[{/if}]>
                                <a href="[{if $sCrum.link}][{$sCrum.link}][{else}]#[{/if}]" title="[{$sCrum.title|escape:'html'}]">
                                  [{$sCrum.title}]
                                </a>
                            </li>
                        [{/foreach}]
                    [{/block}]
                </ol>
            [{/strip}]
        [{/block}]
    [{/if}]
[{/capture}]


[{assign var="sActiveClass" value=$oView->getClassName() }]
[{assign var="aSidebarConfig" value=$oViewConf->getViewThemeParam('aSidebarConfig')}]
[{if $oViewConf->getViewThemeParam('blKeepDefaultSidebar') }]
    [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass|default:$sidebar }]
[{else}]
    [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass }]
[{/if}]

[{capture append="oxidBlock_pageBody"}]
    <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}]">
        <div class="row" id="pagecontent">
            [{if $sidebar && $sidebar|strtolower == "left"}]
                <div id="sidebar" class="col-xs-12 col-md-3">[{include file="layout/sidebar.tpl"}]</div>
            [{/if}]

            <div id="" class="col-xs-12 [{if $sidebar|strtolower == "left" || $sidebar|strtolower == "right"}]col-md-9[{/if}]">
                <div id="content" class="shadow">
                [{$smarty.capture.loginErrors}]

                [{block name="content_main"}]
                    [{include file="message/errors.tpl"}]

                    [{foreach from=$oxidBlock_content item="_block"}]
                        [{$_block|strip}]
                    [{/foreach}]
                [{/block}]
                </div>
            </div>

            [{if $sidebar && $sidebar|strtolower == "right"}]
                <div id="sidebar" class="col-xs-12 col-md-3">[{include file="layout/sidebar.tpl"}]</div>
            [{/if}]
        </div>
        [{block name="layout_init_social"}][{/block}]
        <i class="fa fa-chevron-circle-up icon-4x" id="jumptotop"></i>
        <div id="outdated">
            <h6>[{oxmultilang ident="OUTDATED_OLDBROWSER"}]</h6>
            <p>[{oxmultilang ident="OUTDATED_UPDATENOW"}] <a id="btnUpdateBrowser" href="http://outdatedbrowser.com/[{$oView->getActiveLangAbbr()}]">[{oxmultilang ident="OUTDATED_GETNEWBROWSER"}]</a>
            </p>
            <p class="last"><a href="#" id="btnCloseUpdateBrowser" title="Close">&times;</a></p>
        </div>
    </div>
[{/capture}]
[{include file="layout/base.tpl"}]