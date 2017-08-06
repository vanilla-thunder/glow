[{assign var="oCurrentPromotions" value=$oView->getPromoCurrentList()}]
[{if $oCurrentPromotions && $oCurrentPromotions->count() }]
    <div class="container[{if $oViewConf->getViewThemeParam('blFullwidthLayout')}]-fluid[{/if}]">
        <div id="promotions" class="row">
            [{foreach from=$oView->getPromoCurrentList() item="_promo"}]
                [{assign var="sPromoPicture" value=$_promo->getBannerPictureUrl() }]
                [{assign var="oPromoArticle" value=$_promo->getBannerArticle()}]
                [{if $_promo->getBannerLink()}]
                    [{assign var="sPromoLinkStart" value='<a href="'|cat:$_promo->getBannerLink()|cat:'">' }]
                    [{assign var="sPromoLinkStop" value='</a>' }]
                [{/if}]
                <div class="col-xs-12 [{if $oCurrentPromotions->count() == 2}]col-sm-6[{elseif $oCurrentPromotions->count() == 3}] col-sm-4[{/if}] promotion">
                    <div class="well shadow" style="[{if !$sPromoPicture }]min-height: 300px;[{/if}]">
                        [{if $sPromoPicture }]
                            [{$sPromoLinkStart}]
                            <img src="[{$sPromoPicture}]" class="img-responsive"/>
                            [{$sPromoLinkStop}]
                        [{/if}]
                        [{if $oPromoArticle}]
                            <div class="promo-title">
                                [{$sPromoLinkStart}]
                                [{$oPromoArticle->oxarticles__oxtitle->value}]
                                [{$sPromoLinkStop}]
                            </div>
                        [{/if}]
                        [{if $_promo->getLongDesc() || $oPromoArticle }]
                            <div class="promo-caption">
                                [{$sPromoLinkStart}]
                                <div>
                                    [{if $_promo->getLongDesc()}][{$_promo->getLongDesc()}]
                                    [{elseif $oPromoArticle}][{ $oPromoArticle->oxarticles__oxshortdesc->value}][{/if}]
                                    [{if $oPromoArticle}] &ndash; [{oxprice price=$oPromoArticle->getPrice()}][{/if}]
                                </div>
                                [{if $_promo->oxactions__oxactiveto->value > 0}]
                                    <div class="label label-warning">
                                        [{oxmultilang ident="VALID_UNTIL" suffix="COLON"}] [{ $_promo->oxactions__oxactiveto->value|date_format:"%d-%m-%Y" }]
                                    </div>
                                [{/if}]
                                [{$sPromoLinkStop}]
                            </div>
                        [{/if}]
                    </div>
                </div>
            [{/foreach}]
        </div>
        [{if $oCurrentPromotions->count() > 3}][{* > 3 promotions, flexslider *}]
            <script>
                [{capture name="promotionsJS"}]
                $('#promotions').slick({
                    dots: true,
                    arrows: false,
                    infinite: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    autoplay: true,
                    autoplaySpeed: 3000,
                    responsive: [
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 2
                            }
                        },
                        {
                            breakpoint: 480,
                            settings: {
                                slidesToShow: 1
                            }
                        }
                    ]
                });
                [{/capture}]
            </script>
            [{oxscript add=$smarty.capture.promotionsJS }]
        [{/if}]
    </div>
    <div class="spacer"></div>
[{/if}]