[{if $oView->getBanners()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{include file="widget/promoslider.tpl"}]
    [{/capture}]
[{/if}]

[{capture append="oxidBlock_content"}]
    [{oxifcontent ident="oxstartwelcome" object="oCont"}]
        <div class="welcome-teaser">[{$oCont->oxcontents__oxcontent->value}]</div>
    [{/oxifcontent}]

    [{assign var='rsslinks' value=$oView->getRssLinks()}]

    [{assign var="sStartPageLayout" value=$oViewConf->getViewThemeParam('sStartPageLayout')}]

    [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
    [{assign var="oBargainArticles" value=$oView->getBargainArticleList()}]
    [{assign var="oTopArticles" value=$oView->getTop5ArticleList()}]

    [{if $oNewestArticles && $oNewestArticles->count() }]
        [{capture assign="htmlNewestArticles"}]
            [{foreach from=$oNewestArticles item="_product" name="newestarticles"}]
                [{if $smarty.foreach.newestarticles.first || ( $smarty.foreach.newestarticles.index == 1 && $sStartPageLayout != '1+2' ) || ( $smarty.foreach.newestarticles.index == 2 && $sStartPageLayout == '3+3' ) }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageLayout == '3+3' }]4[{elseif $sStartPageLayout == '2+1' }]6[{else}]12[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]

    [{if $oBargainArticles && $oBargainArticles->count() }]
        [{capture assign="htmlBargainArticles"}]
            [{foreach from=$oBargainArticles item="_product" name="bargainarticles"}]
                [{if $smarty.foreach.bargainarticles.first || ( $smarty.foreach.bargainarticles.index == 1 && $sStartPageLayout != '2+1' ) || ( $smarty.foreach.bargainarticles.index == 2 && $sStartPageLayout == '3+3' ) }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageLayout == '3+3' }]4[{elseif $sStartPageLayout == '2+1' }]12[{else}]6[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]


    [{if $sStartPageLayout == '3+3' }]
        <div class="row boxwrapper">
            <div class="col-xs-12">
                <div class="page-header">
                    <h3>[{oxmultilang ident="START_NEWEST_HEADER"}]</h3>
                    <small class="subhead">[{oxmultilang ident="START_NEWEST_SUBHEADER"}]</small>
                </div>
            </div>
            [{$htmlNewestArticles}]
        </div>
        <hr/>
        <div class="row boxwrapper">
            <div class="col-xs-12">
                <h3>[{oxmultilang ident="START_BARGAIN_HEADER"}]</h3>
                <small class="subhead">[{oxmultilang ident="START_BARGAIN_SUBHEADER"}]</small>
            </div>
            [{$htmlBargainArticles}]
        </div>
    [{else}]
        <div class="row">
            <div class="col-xs-12 col-sm-[{if $sStartPageLayout == '2+1' }]8[{else}]4[{/if}]">
                <div class="row boxwrapper">
                    <div class="col-xs-12 page-header">
                        <h3>[{oxmultilang ident="START_NEWEST_HEADER"}]</h3>
                        <small class="subhead">[{oxmultilang ident="START_NEWEST_SUBHEADER"}]</small>
                    </div>
                    [{$htmlNewestArticles}]
                </div>
            </div>
            <div class="col-xs-12 col-sm-[{if $sStartPageLayout == '2+1' }]4[{else}]8[{/if}]">
                <div class="row boxwrapper">
                    <div class="col-xs-12 page-header">
                        <h3>[{oxmultilang ident="START_BARGAIN_HEADER"}]</h3>
                        <small class="subhead">[{oxmultilang ident="START_BARGAIN_SUBHEADER"}]</small>
                    </div>
                    [{$htmlBargainArticles}]
                </div>
            </div>
        </div>
    [{/if}]



    [{if $oViewConf->getViewThemeParam('bl_showManufacturerSlider')}]
        [{include file="widget/manufacturersslider.tpl"}]
    [{/if}]


    [{if $oNewestArticles && $oNewestArticles->count() && $oTopArticles && $oTopArticles->count()}]
        <div class="row">
            <hr>
        </div>
    [{/if}]

    [{if $oTopArticles && $oTopArticles->count()}]
        [{include file="widget/product/list.tpl" type="infogrid" head="START_TOP_PRODUCTS_HEADER"|oxmultilangassign subhead="START_TOP_PRODUCTS_SUBHEADER"|oxmultilangassign listId="topBox" products=$oTopArticles rsslink=$rsslinks.topArticles rssId="rssTopProducts" showMainLink=true iProductsPerLine=2}]
    [{/if}]

    [{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl"}]