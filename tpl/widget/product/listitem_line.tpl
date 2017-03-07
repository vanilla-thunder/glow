[{block name="widget_product_listitem_line"}]
   [{assign var="product"         value=$oView->getProduct()}]
   [{assign var="currency"        value=$oView->getActCurrency()}]
   [{assign var="iIndex"          value=$oView->getIndex()}]
   [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
   [{assign var="showMainLink"    value=$oView->getShowMainLink()}]
   [{if $showMainLink}]
      [{assign var='_productLink' value=$product->getMainLink()}]
   [{else}]
      [{assign var='_productLink' value=$product->getLink()}]
   [{/if}]
   <div class="row">
      <div class="col-xs-12 col-sm-3">
         <div class="picture">
            [{block name="widget_product_listitem_line_picturebox"}]
               <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]"
                       alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" class="img-responsive">
               </a>
            [{/block}]
         </div>
      </div>
      <div class="col-xs-12 col-sm-5">
         [{block name="widget_product_listitem_line_titlebox"}]
            <div class="title h2">
               <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                [{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]
               </a>
            </div>
         [{/block}]

         [{block name="widget_product_listitem_line_shortdesc"}]
            <strong class="description">
               <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  [{$product->oxarticles__oxshortdesc->rawValue}]
               </a>
            </strong>
         [{/block}]

         [{block name="widget_product_listitem_line_longdesc"}]
            <div class="description">
               <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  [{$product->getLongDesc()|strip_tags|truncate:300:' [...]'}]
               </a>
            </div>
         [{/block}]
      </div>
      <div class="col-xs-12 col-sm-4">
         [{block name="widget_product_listitem_line_attributes"}]

            [{assign var="oAttributes" value=$product->getAttributes()}]
             [{if $oAttributes|@count}]
               <div class="attributes">
                  <div class="title h3">[{oxmultilang ident="SPECIFICATION" suffix="COLON"}]</div>
                  <ul class="list-unstyled attributes">
                     [{foreach from=$oAttributes item="oAttr" name="attribute"}]
                        <li>
                           <strong>[{$oAttr->oxattribute__oxtitle->value}][{oxmultilang ident="COLON"}]</strong>
                         [{$oAttr->oxattribute__oxvalue->value}]
                        </li>
                     [{/foreach}]
                  </ul>
               </div>
            [{/if}]
         [{/block}]

         <div class="functions text-right">
            [{block name="widget_product_listitem_line_price"}]
               [{assign var="price"      value=$product->getPrice()}]
               [{assign var="tprice"     value=$product->getTPrice()}]
               [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
               <div class="price">
                  <link   href="http://schema.org/NewCondition"/>

                  [{block name="widget_product_listitem_line_price"}]
                     <a href="[{$_productLink}]" class="btn btn-default btn-block btn-lg">
                        [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                           <div class="small tprice">
                              [{oxmultilang ident="REDUCED_FROM"}] [{$product->getFTPrice()}] [{$currency->sign}] [{oxmultilang ident="OUR_REGULAR_PRICE"}]
                           </div>
                        [{/if}]

                        [{block name="widget_product_listitem_line_price_value"}]
                           [{if $product->getFPrice()}]
                              [{assign var="sFrom" value=""}]
                              [{assign var="fPrice" value=$product->getFPrice()}]

                              [{if $product->isParentNotBuyable()}]
                                 [{assign var="fPrice" value=$product->getFVarMinPrice()}]
                                 [{if $product->isRangePrice()}]
                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                 [{/if}]
                              [{/if}]
                              <div class="h3">
                              <span class="price-from">[{$sFrom}]</span>
                              <span class="price">[{$fPrice}]</span>
                                 <span class="currency">[{$currency->sign}]</span><em>*</em>
                              </div>
                           [{/if}]
                        [{/block}]
                     </a>
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
                  [{/block}]
               </div>
            [{/block}]

            [{if $product->loadAmountPriceInfo()}]
               <div class="form-group">
                  [{include file="page/details/inc/priceinfo.tpl" oDetailsProduct=$product}]
               </div>
            [{/if}]
         </div>
      </div>
   </div>
   <hr/>
[{/block}]
