[{if $oView->getBanners()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{include file="widget/promoslider.tpl"}]
    [{/capture}]
[{/if}]

[{oxifcontent ident="oxstartwelcome" object="oCont"}]
[{capture append="oxidBlock_pageSubheader"}]
    <div class="container">[{$oCont->oxcontents__oxcontent->value}]</div>
    <div class="spacer"></div>
[{/capture}]
[{/oxifcontent}]

[{if $oxcmp_shop->getDefaultCategory()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{assign var="oStartCategory" value='oxcategory'|oxnew }]
        <!-- [{$oStartCategory->load($oxcmp_shop->getDefaultCategory()) }] -->

        [{if $oStartCategory->oxcategories__oxthumb->value && $oStartCategory->getThumbUrl()}]
            <div class="container shadow">
                <div class="banner"><img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oStartCategory->getThumbUrl()}]" class="banner-img"/></div>
            </div>
        [{/if}]
        [{if $oStartCategory->oxcategories__oxlongdesc->value}]
            <div class="container content shadow">
                [{oxeval var=$oStartCategory->oxcategories__oxlongdesc}]
            </div>
        [{/if}]
        <div class="spacer"></div>
    [{/capture}]
[{/if}]

[{capture append="oxidBlock_content"}]



    [{assign var="sStartPageLayout" value=$oViewConf->getViewThemeParam('sStartPageLayout')}]

    [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
    [{assign var="oBargainArticles" value=$oView->getBargainArticleList()}]
    [{assign var="oTopArticles" value=$oView->getTop5ArticleList()}]
    [{assign var='rsslinks' value=$oView->getRssLinks()}]

    [{if $oNewestArticles && $oNewestArticles->count() }]
        [{capture assign="htmlNewestArticles"}]
            [{foreach from=$oNewestArticles item="_product" name="newestarticles"}]
                [{if $smarty.foreach.newestarticles.first || ( $smarty.foreach.newestarticles.index == 1 && $sStartPageLayout != '1+3' ) || ( $smarty.foreach.newestarticles.index == 2 && $sStartPageLayout != '2+2' && $sStartPageLayout != '1+3' ) || ( $smarty.foreach.newestarticles.index == 3 && $sStartPageLayout == '4+4') }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageLayout == '4+4' }]3[{elseif $sStartPageLayout == '3+1' }]4[{elseif $sStartPageLayout == '2+2' }]6[{else}]12[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]

    [{if $oBargainArticles && $oBargainArticles->count() }]
        [{capture assign="htmlBargainArticles"}]
            [{foreach from=$oBargainArticles item="_product" name="bargainarticles"}]
                [{if $smarty.foreach.bargainarticles.first || ( $smarty.foreach.bargainarticles.index == 1 && $sStartPageLayout != '3+1' ) || ( $smarty.foreach.bargainarticles.index == 2 && $sStartPageLayout != '2+2' && $sStartPageLayout != '3+1' ) || ( $smarty.foreach.bargainarticles.index == 3 && $sStartPageLayout == '4+4') }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageLayout == '4+4' }]3[{elseif $sStartPageLayout == '3+1' }]12[{elseif $sStartPageLayout == '2+2' }]6[{else}]4[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]


    [{if $sStartPageLayout == '4+4' }]
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
            <div class="col-xs-12 col-sm-[{if $sStartPageLayout == '3+1' }]9[{elseif $sStartPageLayout == '1+3' }]3[{else}]6[{/if}]">
                <div class="row boxwrapper">
                    <div class="col-xs-12 page-header">
                        <h3>[{oxmultilang ident="START_NEWEST_HEADER"}]</h3>
                        <small class="subhead">[{oxmultilang ident="START_NEWEST_SUBHEADER"}]</small>
                    </div>
                    [{$htmlNewestArticles}]
                </div>
            </div>
            <div class="col-xs-12 col-sm-[{if $sStartPageLayout == '3+1' }]3[{elseif $sStartPageLayout == '1+3' }]9[{else}]6[{/if}]">
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