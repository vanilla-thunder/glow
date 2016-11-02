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
      <div class="col-xs-12 col-md-4 col-lg-3">
         [{include file="page/details/inc/related_products.tpl"}]
      </div>
   </div>
   <hr/>
   [{block name="details_relatedproducts_crossselling"}]
      [{if $oView->getCrossSelling()|count}]
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=5 listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
      [{/if}]
   [{/block}]

   [{if $oView->getAlsoBoughtTheseProducts()}]
      [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=5 listId="alsoBought" head="CUSTOMERS_ALSO_BOUGHT"|oxmultilangassign subhead="PAGE_DETAILS_CUSTOMERS_ALSO_BOUGHT_SUBHEADER"|oxmultilangassign products=$oView->getAlsoBoughtTheseProducts()}]
   [{/if}]

</div>
