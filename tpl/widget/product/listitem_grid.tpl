[{block name="widget_product_listitem_grid"}]
   [{assign var="product"         value=$oView->getProduct()}]
   [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
   [{assign var="iIndex"          value=$oView->getIndex()}]
   [{assign var="showMainLink"    value=$oView->getShowMainL}]

   [{assign var="currency" value=$oView->getActCurrency()}]
   [{if $showMainLink}]
      [{assign var='_productLink' value=$product->getMainLink()}]
   [{else}]
      [{assign var='_productLink' value=$product->getLink()}]
   [{/if}]
   [{assign var="aVariantSelections" value=$product->getVariantSelections(null,null,1)}]

   [{block name="widget_product_listitem_infogrid_gridpicture"}]
      <div class="picture text-center">
         <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" class="img-responsive">
         </a>
      </div>
   [{/block}]
   <div class="listDetails text-center">
      [{block name="widget_product_listitem_infogrid_titlebox"}]
         <div class="title">
            <a id="[{$testid}]" href="[{$_productLink}]" class="title" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
               <span>[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
            </a>
         </div>
      [{/block}]

      <div class="price text-center">
         <div class="content">
            [{block name="widget_product_listitem_grid_price"}]
               [{oxhasrights ident="SHOWARTICLEPRICE"}]
               [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
               [{assign var="tprice"     value=$product->getTPrice()}]
               [{assign var="price"      value=$product->getPrice()}]

               [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                  <span class="oldPrice text-muted">
                                    <del>[{$product->getFTPrice()}] [{$currency->sign}]</del> <small>[{oxmultilang ident="OUR_REGULAR_PRICE"}]</small><br/>
                                </span>
               [{/if}]
               [{block name="widget_product_listitem_grid_price_value"}]
                  [{if $product->getFPrice()}]
                     <span class="lead text-nowrap">
                                        [{if $product->isRangePrice()}]
                                           [{oxmultilang ident="PRICE_FROM"}]
                                           [{if !$product->isParentNotBuyable()}]
                                              [{$product->getFMinPrice()}]
                                           [{else}]
                                              [{$product->getFVarMinPrice()}]
                                           [{/if}]
                                        [{else}]
                                           [{if !$product->isParentNotBuyable()}]
                                              [{$product->getFPrice()}]
                                           [{else}]
                                              [{$product->getFVarMinPrice()}]
                                           [{/if}]
                                        [{/if}]
                        [{$currency->sign}]
                        <a href="#incVatInfo" class="hasTooltip" data-toggle="tooltip"
                           title="[{if $oView->isVatIncluded()}][{oxmultilang ident="PLUS_SHIPPING"}][{else}][{oxmultilang ident="PLUS"}][{/if}]
                                           [{oxmultilang ident="PLUS_SHIPPING2"}]">*</a>
                                    </span>
                  [{/if}]
               [{/block}]
               [{if $oUnitPrice}]
                  <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit">
                                    [{$product->oxarticles__oxunitquantity->value}] [{$product->getUnitName()}] | [{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}]
                                </span>
               [{elseif $product->oxarticles__oxweight->value }]
                  <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit">
                                    <span title="weight">[{oxmultilang ident="WEIGHT"}]</span>
                                    <span class="value">[{$product->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]</span>
                                </span>
               [{/if}]
               [{/oxhasrights}]
            [{/block}]
         </div>
      </div>
      [{block name="widget_product_listitem_grid_tobasket"}]
         <div class="actions text-center">
            <a class="btn btn-primary" href="[{$_productLink}]">[{oxmultilang ident="DETAILS"}]</a>
         </div>
      [{/block}]
   </div>
[{/block}]