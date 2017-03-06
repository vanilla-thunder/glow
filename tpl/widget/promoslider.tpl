[{block name="dd_widget_promoslider"}]
    [{assign var="oBanners" value=$oView->getBanners()}]
    [{assign var="currency" value=$oView->getActCurrency()}]

    [{if $oBanners|@count > 2}]
        <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}] shadow">
            <div id="promo-carousel" class="flexslider ">
                <ul class="slides">
                    [{block name="dd_widget_promoslider_list"}]
                        [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
                            [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
                            [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]

                            [{if $sBannerPictureUrl}]
                                <li class="item">
                                    [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                                    [{if $sBannerLink}]
                                    <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                        [{/if}]

                                        <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" title="[{$oBanner->oxactions__oxtitle->value}]">

                                        [{if $sBannerLink}]
                                    </a>
                                    [{/if}]
                                    [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $oArticle}]
                                        <p class="flex-caption">
                                            [{if $sBannerLink}]
                                            <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                                [{/if}]
                                                <span class="title">[{$oArticle->oxarticles__oxtitle->value}]</span>[{if $oArticle->oxarticles__oxshortdesc->value|trim}]<br/><span
                                                        class="shortdesc">[{$oArticle->oxarticles__oxshortdesc->value|trim}]</span>[{/if}]
                                                [{if $sBannerLink}]
                                            </a>
                                            [{/if}]
                                        </p>
                                    [{/if}]
                                </li>
                            [{/if}]
                        [{/foreach}]
                    [{/block}]
                </ul>
            </div>
        </div>
        <div class="spacer"></div>
    [{else}]
        [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
            [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
            [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]

            [{if $sBannerPictureUrl}]
                <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}] banner">
                    [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                    [{if $sBannerLink}]
                    <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">[{/if}]
                        <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" class="banner-img" title="[{$oBanner->oxactions__oxtitle->value}]">
                        [{if $sBannerLink}]</a>[{/if}]
                    [{if $oArticle}]
                        <div class="banner-caption">
                            [{if $sBannerLink}]
                            <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                [{/if}]
                                <span class="title">[{$oArticle->oxarticles__oxtitle->value}]</span>[{if $oArticle->oxarticles__oxshortdesc->value|trim}]<br/><span
                                        class="shortdesc">[{$oArticle->oxarticles__oxshortdesc->value|trim}]</span>[{/if}]
                                [{if $sBannerLink}]
                            </a>
                            [{/if}]
                        </div>
                    [{/if}]
                </div>
                <div class="spacer"></div>
            [{/if}]
        [{/foreach}]

    [{/if}]
[{/block}]
