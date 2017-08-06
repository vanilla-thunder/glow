[{block name="widget_product_listitem_mini"}]
   [{assign var="product"         value=$oView->getProduct()}]
   [{assign var="iIndex"          value=$oView->getIndex()}]
   [{assign var="showMainLink"    value=$oView->getShowMainL}]

   [{assign var="currency" value=$oView->getActCurrency()}]
   [{if $showMainLink}]
      [{assign var='_productLink' value=$product->getMainLink()}]
   [{else}]
      [{assign var='_productLink' value=$product->getLink()}]
   [{/if}]

   [{assign var="tprice"     value=$product->getTPrice()}]
   [{assign var="price"      value=$product->getPrice()}]
   <div class="panel panel-default">
      <div class="panel-body">
         [{block name="widget_product_listitem_mini_titlebox"}]
            <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
               [{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]
            </a>
         [{/block}]
         <div class="media">
            <div class="media-left">
               [{block name="widget_product_listitem_mini_picture"}]
                  <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                     <img src="[{$product->getIconUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  </a>
               [{/block}]
            </div>
            <div class="media-body">
               <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  [{$product->oxarticles__oxshortdesc->value}]
               </a>
               <div class="bottom">
               <hr/>
               [{block name="widget_product_listitem_mini_price_value"}]
                  [{if $product->getFPrice()}]
                        <strong>
                           <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                              [{if $product->isRangePrice()}]
                                 [{oxmultilang ident="PRICE_FROM"}]
                                 [{if !$product->isParentNotBuyable()}][{$product->getFMinPrice()}]
                                 [{else}][{$product->getFVarMinPrice()}][{/if}]
                              [{else}]
                                 [{if !$product->isParentNotBuyable()}][{$product->getFPrice()}]
                                 [{else}][{$product->getFVarMinPrice()}][{/if}]
                              [{/if}]
                              [{$currency->sign}]
                           </a> <a href="#footer">*</a>
                        </strong>
                  [{/if}]
               [{/block}]
               [{* zu wenig Platz...
               [{block name="widget_product_listitem_mini_price"}]
                  [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}][{$product->getFTPrice()}] [{$currency->sign}] <small>([{oxmultilang ident="OUR_REGULAR_PRICE"}])</small>
                  [{/if}]
               [{/block}] *}]
            </div>
            </div>
         </div>
      </div>
   </div>
[{/block}]