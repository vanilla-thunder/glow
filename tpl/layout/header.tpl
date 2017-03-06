[{if $oViewConf->getViewThemeParam('blFullWidthHeader') || $oViewConf->getViewThemeParam('blFullwidthLayout') }]
    [{assign var="blFullWidthHeader" value=true}]
[{/if}]
[{strip}]
    [{block name="header_main"}]
        <div id="header" class="container[{if $blFullWidthHeader}]-fluid[{/if}] shadow">
            <div class="row header-box hidden-xs">


                <div class="col-sm-6 col-md-4">
                    [{block name="layout_header_logo"}]
                        [{assign var="slogoImg" value=$oViewConf->getViewThemeParam('sLogoFile')}]
                        [{assign var="sLogoWidth" value=$oViewConf->getViewThemeParam('sLogoWidth')}]
                        [{assign var="sLogoHeight" value=$oViewConf->getViewThemeParam('sLogoHeight')}]
                        <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                            <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/'|cat:$slogoImg}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]"
                                 style="[{if $sLogoWidth}]width:auto;max-width:[{$sLogoWidth}]px;[{/if}][{if $sLogoHeight}]height:auto;max-height:[{$sLogoHeight}]px;[{/if}]">
                        </a>
                    [{/block}]
                </div>
                <div class="col-sm-6 col-md-8 menus-col">
                    [{block name="layout_header_top"}]
                        <div class="menu-dropdowns pull-right">
                            [{block name="dd_layout_page_header_icon_menu_languages"}]
                                [{* Language Dropdown*}]
                                [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            [{/block}]
                            [{block name="dd_layout_page_header_icon_menu_currencies"}]
                                [{* Currency Dropdown*}]
                                [{oxid_include_widget cl="oxwCurrencyList" cur=$oViewConf->getActCurrency() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            [{/block}]

                            [{block name="dd_layout_page_header_icon_menu_account"}]
                                [{if $oxcmp_user || $oView->getCompareItemCount() || $Errors.loginBoxErrors}]
                                    [{assign var="blAnon" value=0}]
                                    [{assign var="force_sid" value=$oViewConf->getSessionId()}]
                                [{else}]
                                    [{assign var="blAnon" value=1}]
                                [{/if}]
                                [{* Account Dropdown *}]
                                [{oxid_include_widget cl="oxwServiceMenu" _parent=$oView->getClassName() force_sid=$force_sid nocookie=$blAnon _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            [{/block}]

                        </div>
                    [{/block}]
                </div>
            </div>
            [{block name="layout_header_bottom"}]
                [{* oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 *}]
                [{include file="widget/header/categorylist.tpl"}]
            [{/block}]

            [{foreach from=$oxidBlock_pageHeader item="_block"}][{$_block|strip}][{/foreach}]

            [{insert name="oxid_newbasketitem" tpl="widget/minibasket/newbasketitemmsg.tpl" type="message"}]
            [{oxid_include_dynamic file="widget/minibasket/minibasketmodal.tpl"}]
        </div>
    [{/block}]

[{/strip}]