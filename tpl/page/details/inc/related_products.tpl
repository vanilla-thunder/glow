<div class="col-xs-12 col-md-4 col-lg-3">
   [{block name="details_relatedproducts_accessoires"}]
      [{if $oView->getAccessoires()|count}]
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=1 listId="accessories" products=$oView->getAccessoires() head="ACCESSORIES"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_ACCESSORIES_SUBHEADER"|oxmultilangassign}]
      [{/if}]
   [{/block}]
</div>

[{* es gibt sowohl zubehör, als auch x-selling => x-se*}]
[{if $oView->getAccessoires() && $oView->getCrossSelling() }]
   [{block name="details_relatedproducts_crossselling"}]
      [{if $oView->getCrossSelling()|count}]
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=5 listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
      [{/if}]
   [{/block}]
[{/if}]

   [{if $oView->getAlsoBoughtTheseProducts()}]
      [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=5 listId="alsoBought" head="CUSTOMERS_ALSO_BOUGHT"|oxmultilangassign subhead="PAGE_DETAILS_CUSTOMERS_ALSO_BOUGHT_SUBHEADER"|oxmultilangassign products=$oView->getAlsoBoughtTheseProducts()}]
   [{/if}]



   [{block name="details_relatedproducts_similarproducts"}]
      [{if $oView->getSimilarProducts()|count}]
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=1 listId="similar"  products=$oView->getSimilarProducts() head="SIMILAR_PRODUCTS"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_SIMILAR_SUBHEADER"|oxmultilangassign}]
      [{/if}]
   [{/block}]


