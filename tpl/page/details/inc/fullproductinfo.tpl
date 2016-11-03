<div id="detailsMain">
   [{include file="page/details/inc/productmain.tpl"}]

</div>
<div id="detailsRelated">
   <div class="row">
      <div class="col-xs-12 [{if $oView->getCrossSelling() || $oView->getSimilarProducts() || $oView->getCrossSelling() || $oView->getAccessoires()}]col-md-8 col-lg-9[{/if}]">
         [{include file="page/details/inc/tabs.tpl"}]

         [{if $oView->isReviewActive()}]
            [{include file="page/details/inc/reviews.tpl"}]
         [{/if}]
      </div>

      [{include file="page/details/inc/related_products.tpl"}]
   </div>
</div>
