[{block name="widget_product_listitem_infogrid"}]
   [{assign var="product"         value=$oView->getProduct()}]
   [{assign var="currency" value=$oView->getActCurrency()}]
   [{assign var="iIndex"          value=$oView->getIndex()}]
   [{assign var="showMainLink"    value=$oView->getShowMainL}]
   [{if $showMainLink}]
      [{assign var='_productLink' value=$product->getMainLink()}]
   [{else}]
      [{assign var='_productLink' value=$product->getLink()}]
   [{/if}]
   <div class="panel panel-default">


   <div class="row panel-body" itemscope itemtype="http://schema.org/Product">
      <div class="col-xs-12 col-md-5">
         [{block name="widget_product_listitem_infogrid_gridpicture"}]
            <a class="text-center" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
               <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
            </a>
         [{/block}]
      </div>

      <div class="col-xs-12 col-md-7">
         [{block name="widget_product_listitem_infogrid_titlebox"}]
            <div class="title h3">
               <a id="[{$testid}]" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                  <span itemprop="name">[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
               </a>
            </div>
         [{/block}]

         [{block name="widget_product_listitem_infogrid_shortdesc"}]
            <div class="shortdesc" itemprop="description">[{$product->oxarticles__oxshortdesc->rawValue}]</div>
         [{/block}]

         <hr/><pre>
            [{$product->getBasePrice()|var_dump}]
         </pre><hr/>

         [{assign var="price"      value=$product->getPrice()}]
         [{assign var="tprice"     value=$product->getTPrice()}]
         [{assign var="oUnitPrice" value=$product->getUnitPrice()}]

         <div class="price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
            <link itemprop="itemCondition" href="http://schema.org/NewCondition"/>

            [{block name="widget_product_listitem_infogrid_price"}]
               [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                  <div class="tprice">
                     <span class="h5">[{oxmultilang ident="REDUCED_FROM"}] [{$product->getFTPrice()}] [{$currency->sign}]</span>
                     <em>[{oxmultilang ident="OUR_REGULAR_PRICE"}]</em>
                  </div>
               [{/if}]

               [{block name="widget_product_listitem_infogrid_price_value"}]
                  [{if $product->getFPrice()}]
                     [{assign var="sFrom" value=""}]
                     [{assign var="fPrice" value=$product->getFPrice()}]

                     [{if $product->isParentNotBuyable()}]
                        [{assign var="fPrice" value=$product->getFVarMinPrice()}]
                        [{if $product->isRangePrice()}]
                           [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                        [{/if}]
                     [{/if}]
                     <strong class="h2">
                        <span class="price-from">[{$sFrom}]</span>
                        <span class="price" itemprop="[{if $product->isRangePrice()}]minPrice[{/if}] price" content="[{$product->getBasePrice()}]">[{$fPrice}]</span>
                        <span class="currency" itemprop="priceCurrency" content="[{$currency->name}]">[{$currency->sign}]</span>
                        <span class="price-markup">[{include file="page/details/inc/vatinfo.tpl"}]</span>
                     </strong>
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
            [{/block}]
         </div>
         [{block name="widget_product_listitem_infogrid_tobasket"}]

                     <a class="btn btn-primary btn-block" href="[{$_productLink}]">[{oxmultilang ident="DETAILS"}]</a>
         [{/block}]
      </div>
   </div></div>
[{/block}]
