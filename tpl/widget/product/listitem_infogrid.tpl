[{block name="widget_product_listitem_infogrid"}]
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
    <div class="panel panel-default">

        <div class="row panel-body">
            <div class="col-xs-12 col-md-5">
                [{block name="widget_product_listitem_infogrid_gridpicture"}]
                    <a class="text-center btn-block" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                        <img [{* src="[{$oViewConf->getImageUrl('spinner.gif')}]" data- *}]
                                src="[{$product->getThumbnailUrl()}]" style="max-width: 100%; height: auto;"
                                alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                    </a>
                [{/block}]
            </div>

            <div class="col-xs-12 col-md-7">
                [{block name="widget_product_listitem_infogrid_titlebox"}]
                    <div class="title h3">
                        <a id="[{$testid}]" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                          [{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]
                        </a>
                    </div>
                [{/block}]

                [{block name="widget_product_listitem_infogrid_shortdesc"}]
                    <div class="shortdesc">[{$product->oxarticles__oxshortdesc->rawValue}]</div>
                [{/block}]

                <hr/>

                [{assign var="price"      value=$product->getPrice()}]
                [{assign var="tprice"     value=$product->getTPrice()}]
                [{assign var="oUnitPrice" value=$product->getUnitPrice()}]

                <div class="price text-center">
                    <link   href="http://schema.org/NewCondition"/>
                    [{block name="widget_product_listitem_infogrid_price"}]
                        [{assign var="sOnly" value=""}]
                        [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                            [{assign var="sOnly" value="NOW_ONLY"|oxmultilangassign}]
                            <div class="tprice">
                                [{oxmultilang ident="REDUCED_FROM"}]&nbsp;[{$product->getFTPrice()}]&nbsp;[{$currency->sign}]<br/>
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
                                <!-- <span class="price-only">[{$sOnly}]</span><br/> -->
                                <strong class="h2">
                                    <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                                        <span class="price-from">[{$sFrom}]</span>
                                        <span class="price">[{$fPrice}]</span>
                                        <span class="currency">[{$currency->sign}]</span>
                                    </a>
                                    <span class="price-markup">[{include file="page/details/inc/vatinfo.tpl"}]</span>
                                </strong>
                            [{/if}]
                        [{/block}]

                        [{if $oUnitPrice}]
                            <div id="productPricePerUnit_[{$testid}]" class="pricePerUnit">
                                [{$product->oxarticles__oxunitquantity->value}] [{$product->getUnitName()}] | [{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}]
                            </div>
                        [{elseif $product->oxarticles__oxweight->value }]
                            <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit">
                                <span title="weight">[{oxmultilang ident="WEIGHT"}]</span>
                                <span class="value">[{$product->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]</span>
                            </span>
                        [{/if}]
                    [{/block}]
                </div>
                [{block name="widget_product_listitem_infogrid_tobasket"}]
                    <a class="btn btn-success btn-block" href="[{$_productLink}]">[{oxmultilang ident="DETAILS"}]&nbsp;<i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                [{/block}]
            </div>
        </div>
    </div>
[{/block}]