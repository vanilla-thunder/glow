[{oxifcontent ident="oxstartwelcome" object="oCont"}]
[{capture append="oxidBlock_pageSubheader"}]
    <div class="container">[{$oCont->oxcontents__oxcontent->value}]</div>
    <div class="spacer"></div>
[{/capture}]
[{/oxifcontent}]

[{if $oView->getBanners()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{include file="page/shop/inc/banners.tpl"}]
    [{/capture}]
[{/if}]

[{if $oView->getPromoCurrentList()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{include file="page/shop/inc/promotions.tpl"}]
    [{/capture}]
[{/if}]

[{capture append="oxidBlock_content"}]

    [{assign var="sStartPageActionsLayout" value=$oViewConf->getViewThemeParam('sStartPageActionsLayout')}]

    [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
    [{assign var="oBargainArticles" value=$oView->getBargainArticleList()}]
    [{assign var="oTopArticles" value=$oView->getTop5ArticleList()}]
    [{assign var='rsslinks' value=$oView->getRssLinks()}]

    [{if $oNewestArticles && $oNewestArticles->count() }]
        [{capture assign="htmlNewestArticles"}]
            [{foreach from=$oNewestArticles item="_product" name="newestarticles"}]
                [{if $smarty.foreach.newestarticles.first || ( $smarty.foreach.newestarticles.index == 1 && $sStartPageActionsLayout != '1+3' ) || ( $smarty.foreach.newestarticles.index == 2 && $sStartPageActionsLayout != '2+2' && $sStartPageActionsLayout != '1+3' ) || ( $smarty.foreach.newestarticles.index == 3 && $sStartPageActionsLayout == '4+4') }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageActionsLayout == '4+4' }]3[{elseif $sStartPageActionsLayout == '3+1' }]4[{elseif $sStartPageActionsLayout == '1+3' }]12[{else}]6[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]
    [{if $oBargainArticles && $oBargainArticles->count() }]
        [{capture assign="htmlBargainArticles"}]
            [{foreach from=$oBargainArticles item="_product" name="bargainarticles"}]
                [{if $smarty.foreach.bargainarticles.first || ( $smarty.foreach.bargainarticles.index == 1 && $sStartPageActionsLayout != '3+1' ) || ( $smarty.foreach.bargainarticles.index == 2 && $sStartPageActionsLayout != '2+2' && $sStartPageActionsLayout != '3+1' ) || ( $smarty.foreach.bargainarticles.index == 3 && $sStartPageActionsLayout == '4+4') }]
                    <div class="grid col-xs-12 col-sm-[{if $sStartPageActionsLayout == '4+4' }]3[{elseif $sStartPageActionsLayout == '3+1' }]12[{elseif $sStartPageActionsLayout == '1+3' }]4[{else}]6[{/if}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_grid isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/if}]
            [{/foreach}]
        [{/capture}]
    [{/if}]
    [{if $sStartPageActionsLayout == '4+4' }]
        [{if $oNewestArticles && $oNewestArticles->count() }]
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
        [{/if}]
        [{if $oBargainArticles && $oBargainArticles->count() }]
            <div class="row boxwrapper">
                <div class="col-xs-12">
                    <h3>[{oxmultilang ident="START_BARGAIN_HEADER"}]</h3>
                    <small class="subhead">[{oxmultilang ident="START_BARGAIN_SUBHEADER"}]</small>
                </div>
                [{$htmlBargainArticles}]
            </div>
        [{/if}]
    [{elseif $oNewestArticles && $oNewestArticles->count() && $oBargainArticles && $oBargainArticles->count() }]
        <div class="row">
            <div class="col-xs-12 col-sm-[{if $sStartPageActionsLayout == '3+1' }]9[{elseif $sStartPageActionsLayout == '1+3' }]3[{else}]6[{/if}]">
                <div class="row boxwrapper">
                    <div class="col-xs-12 page-header">
                        <h3>[{oxmultilang ident="START_NEWEST_HEADER"}]</h3>
                        <small class="subhead">[{oxmultilang ident="START_NEWEST_SUBHEADER"}]</small>
                    </div>
                    [{$htmlNewestArticles}]
                </div>
            </div>
            <div class="col-xs-12 col-sm-[{if $sStartPageActionsLayout == '3+1' }]3[{elseif $sStartPageActionsLayout == '1+3' }]9[{else}]6[{/if}]">
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
        [{include file="page/shop/inc/brands.tpl"}]
    [{/if}]

    [{if $oTopArticles && $oTopArticles->count()}]
        <div id="topseller" class="row">
            <div class="boxwrapper">
                <div class="page-header">
                    <h3>[{oxmultilang ident="START_TOP_PRODUCTS_HEADER"}]</h3>
                    <span class="subhead">[{oxmultilang ident="START_TOP_PRODUCTS_SUBHEADER"}]</span>
                </div>

                <div class="slider">
                    [{foreach from=$oTopArticles item="_product"}]
                        <div>
                            <a href="[{$_product->getMainLink()}]" class="thumbnail shadow" style="background-image: url('[{$_product->getThumbnailUrl()}]');">
                                <img src="[{$_product->getThumbnailUrl()}]" class="img-responsive hidden"/>
                                <div class="slider-caption">[{$_product->oxarticles__oxtitle->value}]<br/></div>
                            </a>
                        </div>
                    [{/foreach}]
                </div>
            </div>
        </div>
        [{* <script> *}]
            [{capture name="topsellerJS"}]
            $('#topseller .slider').slick({
                arrows: true,
                dots:true,
                slidesToShow: 5,
                infinite: true,
                responsive: [
                    {
                        breakpoint: 1200,
                        settings: { slidesToShow: 4 }
                    },{
                        breakpoint: 800,
                        settings: { slidesToShow: 3 }
                    },{
                        breakpoint: 560,
                        settings: { slidesToShow: 2 }
                    }
                ]
            });
            [{/capture}]
        [{* </script> *}]
        [{oxscript add=$smarty.capture.topsellerJS }]
        [{*
            <div class="row boxwrapper">
                <div class="col-xs-12 page-header">
                    <h3>[{oxmultilang ident="START_TOP_PRODUCTS_HEADER"}]</h3>
                    <small class="subhead">[{oxmultilang ident="START_TOP_PRODUCTS_SUBHEADER" args=$oTopArticles->count() }]</small>
                </div>
                [{foreach from=$oTopArticles item="_product"}]
                    <div class="col-xs-12 col-sm-[{if $oTopArticles->count() == 1}]12[{elseif $oTopArticles->count() == 2}]6[{elseif $oTopArticles->count() == 3}]4[{else}]3[{/if}]">
                        [{if $oTopArticles->count() == 1}][{assign var="listitem_line" value="listitem_line"}][{/if}]
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=$sListType|default:'listitem_grid' isVatIncluded=$oView->isVatIncluded()}]
                    </div>
                [{/foreach}]
            </div>
            *}]
    [{/if}]

    [{insert name="oxid_tracker"}]
[{/capture}]

[{if $oxcmp_shop->getDefaultCategory()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{assign var="oStartCategory" value='oxcategory'|oxnew }]
        <!-- [{$oStartCategory->load($oxcmp_shop->getDefaultCategory()) }] -->

        [{if $oStartCategory->oxcategories__oxthumb->value && $oStartCategory->getThumbUrl()}]
            <div class="container shadow">
                <div class="banner"><img src="" data-src="[{$oStartCategory->getThumbUrl()}]" class="banner-img" style/></div>
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

[{include file="layout/page.tpl"}]