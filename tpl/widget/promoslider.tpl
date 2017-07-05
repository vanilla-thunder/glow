[{block name="dd_widget_promoslider"}]
    [{assign var="oBanners" value=$oView->getBanners()}]
    [{assign var="currency" value=$oView->getActCurrency()}]

    [{if $oBanners|@count > 2}]
        <script>
            [{capture name="promosliderJS"}]
            $('#bannerSlider').slick({
                autoplay: [{if $oViewConf->getViewThemeParam('blStartPageSliderAutoplay')}]true[{else}]false[{/if}],
                autoplaySpeed: [{$oViewConf->getViewThemeParam('sStartPageSliderAutoplaySpeed')|default:'5000'}],
                [{if $oViewConf->getViewThemeParam('sStartPageSliderAnimation') == 'fade'}]fade: true,[{/if}]
                speed: [{$oViewConf->getViewThemeParam('sStartPageSliderAnimationSpeed')|default:'2000'}],
                arrows: [{if $oViewConf->getViewThemeParam('blStartPageSliderArrows')}]true[{else}]false[{/if}],
                dots:[{if $oViewConf->getViewThemeParam('blStartPageSliderDots')}]true[{else}]false[{/if}],
                [{* cssEase: "[{ $oViewConf->getViewThemeParam('sStartPageSliderEasing')|default:'ease'}]", *}]
                easing:"[{ $oViewConf->getViewThemeParam('sStartPageSliderEasing')|default:'ease'}]",
                infinite: true,
                [{if $oViewConf->getViewThemeParam('sStartPageSliderDirection') == 'vertical'}]vertical:true[{/if}]
            });
            [{/capture}]
        </script>
        [{ oxscript add=$smarty.capture.promosliderJS }]
        <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}]">
            <div id="bannerSlider" class="banner">
                    [{block name="dd_widget_promoslider_list"}]
                        [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
                            [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
                            [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]
                            [{if $oBanner->getBannerLink()}]
                                [{assign var="sBannerLinkStart" value='<a href="'|cat:$oBanner->getBannerLink()|cat:'">' }]
                                [{assign var="sBannerLinkStop" value='</a>' }]
                            [{/if}]

                            [{if $sBannerPictureUrl}]
                                <div>
                                    [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                                    [{$sBannerLinkStart}]
                                    <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" class="img-responsive">
                                    [{$sBannerLinkStop}]
                                    [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $oArticle}]
                                        <p class="banner-caption">
                                            [{$sBannerLinkStart}]
                                            <span class="title">[{$oArticle->oxarticles__oxtitle->value}]</span>[{if $oArticle->oxarticles__oxshortdesc->value|trim}]<br/>
                                            <span class="shortdesc">[{$oArticle->oxarticles__oxshortdesc->value|trim}]</span>[{/if}]
                                            [{$sBannerLinkStop}]
                                        </p>
                                    [{/if}]
                                </div>
                            [{/if}]
                        [{/foreach}]
                    [{/block}]
            </div>
        </div>
        <div class="spacer"></div>
    [{else}]
        [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
            [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
            [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]
            [{if $oBanner->getBannerLink()}]
                [{assign var="sBannerLinkStart" value='<a href="'|cat:$oBanner->getBannerLink()|cat:'">' }]
                [{assign var="sBannerLinkStop" value='</a>' }]
            [{/if}]

            [{if $sBannerPictureUrl}]
                <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}] banner">
                    [{$sBannerLinkStart}]
                    <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" class="banner-img" title="[{$oBanner->oxactions__oxtitle->value}]">
                    [{$sBannerLinkStop}]
                    [{if $oArticle}]
                        <div class="banner-caption">
                            [{$sBannerLinkStart}]
                            <span class="title">[{$oArticle->oxarticles__oxtitle->value}]</span>[{if $oArticle->oxarticles__oxshortdesc->value|trim}]
                        <br/>
                            <span class="shortdesc">[{$oArticle->oxarticles__oxshortdesc->value|trim}]</span>[{/if}]

                            [{$sBannerLinkStop}]
                        </div>
                    [{/if}]
                </div>
                <div class="spacer"></div>
            [{/if}]
        [{/foreach}]

    [{/if}]
[{/block}]
