[{oxifcontent ident="oxstartwelcome" object="oCont"}]
[{capture append="oxidBlock_pageSubheader"}]
    <div class="container">[{$oCont->oxcontents__oxcontent->value}]</div>
    <div class="spacer"></div>
[{/capture}]
[{/oxifcontent}]

[{if $oView->getBanners()}]
    [{capture append="oxidBlock_pageSubheader"}]
        [{include file="widget/promoslider.tpl"}]
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

    [{assign var="oCurrentPromotions" value=$oView->getPromoCurrentList()}]
    [{if $oCurrentPromotions && $oCurrentPromotions->count() }]
        [{capture assign="htmlCurrentPromotions"}]
            [{foreach from=$oView->getPromoCurrentList() item="_promo"}]
                [{assign var="sPromoPicture" value=$_promo->getBannerPictureUrl() }]
                [{assign var="sPromoLink" value=$_promo->getBannerLink() }]
                [{if $_promo->getBannerLink()}]
                    [{assign var="sPromoLinkStart" value='<a href="'|cat:$_promo->getBannerLink()|cat:'">' }]
                    [{assign var="sPromoLinkStop" value='</a>' }]
                [{/if}]
                <div class="col-xs-6 col-sm-4 promotion">
                    <div class="well shadow" [{if $sPromoPicture }]style="background-image: url('[{$sPromoPicture}]');"[{/if}]>
                        <!-- [{ $_promo|@var_dump }] -->

                        <div class="promo-title">
                            <a href="[{$sPromoLink|default:'#'}]" class="btn btn-block">[{$_promo->oxactions__oxtitle->value}]</a>
                        </div>
                        <div class="promo-caption">
                            <div>
                                [{$sPromoLinkStart}]
                                [{$_promo->getLongDesc()}]
                                [{$sPromoLinkStop}]
                            </div>
                            [{if $_promo->oxactions__oxactiveto->value > 0}]
                                <div class="label label-warning">
                                    [{oxmultilang ident="VALID_UNTIL" suffix="COLON"}] [{ $_promo->oxactions__oxactiveto->value|date_format:"%d-%m-%Y" }]
                                </div>
                            [{/if}]
                        </div>
                    </div>
                </div>
            [{/foreach}]
        [{/capture}]
        [{if $oViewConf->getViewThemeParam('sStartPagePromotionsLayout') == 1}]
            [{capture append="oxidBlock_pageSubheader"}]
                <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}]">
                    <div class="row">[{$htmlCurrentPromotions}]</div>
                </div>
            [{/capture}]
        [{else}]
            <div class="row boxwrapper">
                <div class="col-xs-12 page-header">
                    <h3>[{oxmultilang ident="GLOW_CURRENT_PROMOTIONS" suffix="COLON"}]</h3>
                    [{* <small class="subhead">[{oxmultilang ident="START_TOP_PRODUCTS_SUBHEADER" args=$oTopArticles->count() }]</small> *}]
                </div>
                [{$htmlCurrentPromotions}]
            </div>
        [{/if}]
    [{/if}]


    [{if $oViewConf->getViewThemeParam('bl_showManufacturerSlider')}]
        [{include file="widget/manufacturersslider.tpl"}]
    [{/if}]

    [{if $oTopArticles && $oTopArticles->count()}]
        <script>
            [{capture name="topArticlesSlickJS"}]
            $('#topProductsSlider > .slider').slick({
                centerMode: true,
                centerPadding: '0px',
                dots:true,
                slidesToShow: 5,
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 5
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 3
                        }
                    }
                ]
            });
            [{/capture}]
        </script>
        [{oxscript add=$smarty.capture.topArticlesSlickJS }]
        <div class="row">
            <div id="topProductsSlider" class="boxwrapper">
                <div class="page-header">
                    <h3>[{oxmultilang ident="START_TOP_PRODUCTS_HEADER"}]</h3>
                    <span class="subhead">[{oxmultilang ident="START_TOP_PRODUCTS_SUBHEADER"}]</span>
                </div>

                <div class="slider">
                    [{foreach from=$oTopArticles item="_product"}]
                        <div>
                            <a href="[{$_product->getMainLink()}]" class="thumbnail" style="background-image: url('[{$_product->getThumbnailUrl()}]');">
                                <img src="[{$_product->getThumbnailUrl()}]" class="img-responsive hidden"/>
                                <div class="slider-caption">[{$_product->oxarticles__oxtitle->value}]<br/></div>
                            </a>
                        </div>
                    [{/foreach}]
                </div>
            </div>
        </div>
        <hr/>
        <hr/>
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