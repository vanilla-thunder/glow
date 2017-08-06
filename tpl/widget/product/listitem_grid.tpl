[{block name="widget_product_listitem_grid"}]
    [{assign var="product"         value=$oView->getProduct()}]
    [{assign var="iIndex"          value=$oView->getIndex()}]
    [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
    [{assign var="showMainLink"    value=$oView->getShowMainLink()}]
    [{if $showMainLink}]
        [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
        [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]

    [{assign var="currency"   value=$oView->getActCurrency()}]
    [{assign var="price"      value=$product->getPrice()}]
    [{assign var="tprice"     value=$product->getTPrice()}]
    [{assign var="oUnitPrice" value=$product->getUnitPrice()}]

    <div class="panel panel-[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]success[{else}]default[{/if}]">

        <div class="panel-body listitem-grid">

            [{block name="widget_product_listitem_grid_gridpicture"}]
                <a class="btn-block text-center productpic" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]"
                style="background: url('[{$product->getThumbnailUrl()}]') center no-repeat transparent; background-size: cover;">
                    <img [{* src="[{$oViewConf->getImageUrl('spinner.gif')}]" data- *}]
                            src="[{$product->getThumbnailUrl()}]" style="max-width: 100%; height: auto; visibility:hidden;"
                            alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                </a>
            [{/block}]

            [{block name="widget_product_listitem_grid_titlebox"}]
                <div class="title h3 text-center">
                    <a id="[{$testid}]" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                      [{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]
                    </a>
                </div>
            [{/block}]

            <div class="price text-center">
                <link href="http://schema.org/NewCondition"/>

                [{block name="widget_product_listitem_grid_price"}]
                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                        <p class="tprice">
                            [{oxmultilang ident="REDUCED_FROM"}] [{$product->getFTPrice()}] [{$currency->sign}] [{oxmultilang ident="OUR_REGULAR_PRICE"}]
                        </p>
                    [{/if}]

                    [{block name="widget_product_listitem_grid_price_value"}]
                        [{if $product->getFPrice()}]
                            [{assign var="sFrom" value=""}]
                            [{assign var="fPrice" value=$product->getFPrice()}]

                            [{if $product->isParentNotBuyable()}]
                                [{assign var="fPrice" value=$product->getFVarMinPrice()}]
                                [{if $product->isRangePrice()}]
                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                [{/if}]
                            [{/if}]
                            <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                                <strong class="h2">
                                    <span class="price-from">[{$sFrom}]</span>
                                    <span class="price">[{$fPrice}]</span>
                                    <span class="currency">[{$currency->sign}]</span>
                                </strong>
                            </a>
                            <div class="price-markup h6">[{include file="page/details/inc/vatinfo.tpl"}]</div>
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

            [{block name="widget_product_listitem_grid_tobasket"}]
            [{/block}]
        </div>
    </div>
[{/block}]