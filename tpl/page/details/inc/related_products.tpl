[{block name="details_relatedproducts_accessoires"}]
   [{if $oView->getAccessoires()|count}]
      <div class="col-xs-12 col-md-3">
         [{math equation="12/x" x=$oView->getAccessoires()|count assign="sm"}]
         [{include file="widget/product/list.tpl" type="mini" size="col-xs-12 col-sm-`$sm` col-md-12" listId="accessories" products=$oView->getAccessoires() head="ACCESSORIES"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_ACCESSORIES_SUBHEADER"|oxmultilangassign}]
         [{oxscript add='$(".panel-body","#accessories").matchHeight();'}]
      </div>
   [{/if}]
[{/block}]


[{block name="details_relatedproducts_crossselling"}]
   [{if $oView->getCrossSelling()|count}]
      [{if $oView->getAccessoires()}]
         [{* es gibt schon Zubehör, also wird das hier in voller Breite unter der Beschreobung angehängt *}]
         <div class="col-xs-12">
            [{include file="widget/product/list.tpl" type="mini" listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
         </div>
      [{else}]
         [{* es gibt kein Zubehör, also wird das rechts neben der Beschreibung reingequetscht *}]
         [{math equation="12/x" x=$oView->getCrossSelling()|count assign="sm"}]
         <div class="col-xs-12 col-md-3">
            [{include file="widget/product/list.tpl" type="mini" size="col-xs-12 col-sm-`$sm` col-md-12" listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
         </div>
      [{/if}]
      [{oxscript add='$(".panel-body","#cross").matchHeight();'}]
   [{/if}]
[{/block}]

[{block name="details_relatedproducts_alsobought"}]
   [{if $oView->getAlsoBoughtTheseProducts()}]
      <div class="col-xs-12">
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=4 listId="alsoBought" head="CUSTOMERS_ALSO_BOUGHT"|oxmultilangassign subhead="PAGE_DETAILS_CUSTOMERS_ALSO_BOUGHT_SUBHEADER"|oxmultilangassign products=$oView->getAlsoBoughtTheseProducts()}]
      </div>
      [{oxscript add='$(".panel-body","#alsoBought").matchHeight();'}]
   [{/if}]
[{/block}]


[{block name="details_relatedproducts_similarproducts"}]
   [{if $oView->getSimilarProducts()|count}]
      <div class="col-xs-12">
         [{include file="widget/product/list.tpl" type="mini" iProductsPerLine=4 listId="similar"  products=$oView->getSimilarProducts() head="SIMILAR_PRODUCTS"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_SIMILAR_SUBHEADER"|oxmultilangassign}]
      </div>
      [{oxscript add='$(".panel-body","#similar").matchHeight();'}]
   [{/if}]
[{/block}]


