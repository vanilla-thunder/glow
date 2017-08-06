<div id="brands" class="row">
    <div class="boxwrapper">
        <div class="page-header">
            <h3>[{oxmultilang ident="OUR_BRANDS"}]</h3>
            <span class="subhead">[{oxmultilang ident="MANUFACTURERSLIDER_SUBHEAD"}]</span>
        </div>

            [{foreach from=$oView->getManufacturerForSlider() item=oManufacturer}]
                [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                    <div class="col-xs-6 col-sm-3 col-md-2">
                        <a href="[{$oManufacturer->getLink()}]" title="[{oxmultilang ident="VIEW_ALL_PRODUCTS"}]" class="thumbnail">
                            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oManufacturer->getIconUrl()}]" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]" style="max-height: 100px;">
                        </a>
                    </div>
                [{/if}]
            [{/foreach}]
    [{*
        <script>
            [{capture name="brandsliderJS"}]
            $('#brands').slick({
                autoplay: [{if $oViewConf->getViewThemeParam('blStartPageSliderAutoplay')}]true[{else}]false[{/if}],
                autoplaySpeed: [{$oViewConf->getViewThemeParam('sStartPageSliderAutoplaySpeed')|default:'5000'}],
                [{if $oViewConf->getViewThemeParam('sStartPageSliderAnimation') == 'fade'}]fade: true,[{/if}]
                speed: [{$oViewConf->getViewThemeParam('sStartPageSliderAnimationSpeed')|default:'2000'}],
                arrows: [{if $oViewConf->getViewThemeParam('blStartPageSliderArrows')}]true[{else}]false[{/if}],
                dots:[{if $oViewConf->getViewThemeParam('blStartPageSliderDots')}]true[{else}]false[{/if}],
                easing:"[{ $oViewConf->getViewThemeParam('sStartPageSliderEasing')|default:'ease'}]",
                infinite: true,
                [{if $oViewConf->getViewThemeParam('sStartPageSliderDirection') == 'vertical'}]vertical:true[{/if}]
            });
            [{/capture}]
        </script>
        [{ oxscript add=$smarty.capture.brandsliderJS }]
        *}]
    </div>
</div>