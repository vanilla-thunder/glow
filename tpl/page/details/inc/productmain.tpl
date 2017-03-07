[{oxscript include="js/pages/details.min.js" priority=10}]

[{assign var="oParentProduct" value=$oDetailsProduct->getParentArticle() }]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
        [{assign var="_sSelectionHash" value=""}]
        [{foreach from=$oSelectionList item=oListItem key=iPos}]
            [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
        [{/foreach}]
        [{if $_sSelectionHash}]
            [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
            [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
        [{/if}]
    [{/foreach}]
    [{oxscript add="oxVariantSelections  = [`$_sSelectionHashCollection`];"}]
    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        <div>
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
            <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
            <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
            <input type="hidden" name="nocookie" value="1">
            <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
            <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
            <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
        </div>
    </form>
[{/if}]

<div class="detailsInfo clear">

    [{block name="details_productmain_title"}]
        <h1 class="text-center">[{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]</h1>
    [{/block}]

    <div class="row">
        [{* article picture with zoom *}]
        <div class="col-xs-12 col-sm-5">
            [{block name="details_productmain_zoom"}]
                <div class="picture">
                    <a href="[{$oPictureProduct->getZoomPictureUrl(1)}]" id="zoom1" class="thumbnail"
                       rel="produktbilder">
                        <img src="[{$oView->getActPicture()}]"
                             alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
                    </a>
                </div>
                [{oxscript add='$(".thumbnail").fancybox();'}]
            [{/block}]

            [{block name="details_productmain_morepics"}]
                [{include file="page/details/inc/morepics.tpl"}]
            [{/block}]
        </div>

        [{* product info *}]
        <div class="col-xs-12 col-sm-7">
            [{* article number *}]
            [{block name="details_productmain_artnumber"}]
                <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}]
                  [{$oDetailsProduct->oxarticles__oxartnum->value}]</span>
            [{/block}]

            [{* ratings *}]
            <div class="star-ratings">
                [{if $oView->ratingIsActive()}]
                    [{block name="details_productmain_ratings"}]
                        [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
                    [{/block}]
                [{/if}]
            </div>

            [{* short description *}]
            [{block name="details_productmain_shortdesc"}]
                [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
                    <p class="shortdesc"
                       id="productShortdesc">[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
                [{/if}]
            [{/block}]

            [{if $oDetailsProduct->oxarticles__oxweight->value}]
                <div class="weight">
                    [{block name="details_productmain_weight"}]
                        [{oxmultilang ident="WEIGHT" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]
                    [{/block}]
                </div>
            [{/if}]

            <hr/>

            <form class="js-oxProductForm form-horizontal" action="[{$oViewConf->getSelfActionLink()}]" method="post">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                    <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
                    <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
                    <input type="hidden" name="parentid"
                           value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
                    <input type="hidden" name="panid" value="">
                    [{if !$oDetailsProduct->isNotBuyable()}]
                        <input type="hidden" name="fnc" value="tobasket">
                    [{/if}]
                </div>

                [{assign var="blCanBuy" value=true}]

                [{* variants | md variants *}]
                [{block name="details_productmain_variantselections"}]
                    [{if $aVariantSelections && $aVariantSelections.selections}]
                        [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                        [{if !$blHasActiveSelections}]
                            [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                                [{assign var="blCanBuy" value=true}]
                            [{/if}]
                        [{/if}]
                        <div id="variants">
                            [{assign var="blHasActiveSelections" value=false}]
                            [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                                [{if $oList->getActiveSelection()}]
                                    [{assign var="blHasActiveSelections" value=true}]
                                [{/if}]
                                [{include file="page/details/inc/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{/foreach}]
                        </div>
                    [{/if}]
                [{/block}]

                [{* selection lists *}]
                [{block name="details_productmain_selectlists"}]
                    [{if $oViewConf->showSelectLists()}]
                        <div id="selectionlists">
                            [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                            [{if $oSelections}]
                                <div>
                                    [{foreach from=$oSelections item=oList name=selections}]
                                        [{include file="page/details/inc/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                    [{/foreach}]
                                </div>
                            [{/if}]
                        </div>
                    [{/if}]
                [{/block}]

                [{* pers params *}]
                [{block name="details_productmain_persparams"}]
                    [{if $oView->isPersParam()}]
                        <div id="persparam" class="form-group">
                            <label for="persistentParam"
                                   class="col-xs-12 col-sm-3 control-label"><strong>[{oxmultilang ident="YOUR_MESSAGE" suffix="COLON"}]</strong></label>
                            <div class="col-xs-12 col-sm-9">
                                <input id="persistentParam" class="form-control" type="text" name="persparam[details]"
                                       value="[{$oDetailsProduct->aPersistParam.text}]" size="35">
                            </div>
                        </div>
                    [{/if}]
                [{/block}]

                [{block name="details_productmain_vpe"}]
                    [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                        <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                        <br>
                    [{/if}]
                [{/block}]

                <div class="row">
                    <div class="col-xs-12 col-md-6">


                        [{assign var=price  value=$oDetailsProduct->getPrice()}]
                        [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                        [{if !$tprice && $oParentProduct && $oParentProduct->getTPrice()}]
                            [{assign var=tprice value=$oParentProduct->getTPrice()}]
                        [{/if}]

                        <div class="priceinfo [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]reduced[{/if}] text-center">
                            [{block name="details_productmain_tprice"}]
                                [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                    <div class="tprice">
                                        <span class="h4">[{oxmultilang ident="REDUCED_FROM"}] [{oxprice price=$tprice currency=$currency}]</span><br/>
                                        <em>[{oxmultilang ident="OUR_REGULAR_PRICE"}]</em>
                                    </div>
                                [{/if}]
                            [{/block}]

                            [{block name="details_productmain_price"}]
                                [{block name="details_productmain_price_value"}]
                                [{if $oDetailsProduct->getFPrice()}]
                                    [{assign var="sFrom" value=""}]
                                    [{assign var="fPrice" value=$oDetailsProduct->getFPrice()}]

                                    [{if $oDetailsProduct->isParentNotBuyable()}]
                                        [{assign var="fPrice" value=$oDetailsProduct->getFVarMinPrice()}]
                                        [{if $oDetailsProduct->isRangePrice()}]
                                            [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                        [{/if}]
                                    [{/if}]
                                    <strong class="h2">
                                        <span class="price-from">[{$sFrom}]</span>
                                        <span class="price">[{$fPrice}]</span>
                                        <span class="currency">[{$currency->sign}]</span>
                                        <span class="price-markup">[{include file="page/details/inc/vatinfo.tpl"}]</span>
                                    </strong>
                                [{/if}]

                                    [{* amount prices *}]
                                [{if $oDetailsProduct->loadAmountPriceInfo()}]
                                    <div class="unitprice" style="display: none;">[{oxmultilang ident="UNIT_PRICE" suffix="COLON"}] <span></span> [{$currency->sign}]*</div>
                                    <script>
                                        var einzelpreis = [{$fPrice|replace:',':'.'}];
                                        var staffelpreise = [
                                            [{foreach from=$oDetailsProduct->loadAmountPriceInfo() item=priceItem name=amountPrice}]
                                            {
                                                'from': [{$priceItem->oxprice2article__oxamount->value}],
                                                [{if $priceItem->oxprice2article__oxaddperc->value}]
                                                'perc':[{$priceItem->oxprice2article__oxaddperc->value}],
                                                [{else}]
                                                'abs':[{$priceItem->fbrutprice|replace:',':'.'}]
                                                [{/if}]
                                            },
                                            [{/foreach}]
                                        ];
                                        staffelpreise.reverse();
                                    </script>
                                <hr/>
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th colspan="2">[{oxmultilang ident="BLOCK_PRICE" suffix="COLON"}]</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        [{foreach from=$oDetailsProduct->loadAmountPriceInfo() item=priceItem name=amountPrice}]
                                            <tr>
                                                <td>[{oxmultilang ident="FROM"}] [{$priceItem->oxprice2article__oxamount->value}] [{oxmultilang ident="PCS"}]</td>
                                                <td>
                                                    [{if $priceItem->oxprice2article__oxaddperc->value}]
                                                        [{$priceItem->oxprice2article__oxaddperc->value}]% [{oxmultilang ident="DISCOUNT"}]
                                                    [{else}]
                                                        [{$priceItem->fbrutprice}] [{$currency->sign}]
                                                    [{/if}]
                                                </td>
                                            </tr>
                                        [{/foreach}]
                                        </tbody>
                                    </table>
                                [{/if}]
                                [{/block}]
                            [{/block}]

                            [{* price per unit *}]
                            [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                            [{block name="details_productmain_priceperunit"}]
                                [{if $oUnitPrice}]
                                    [{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]
                                [{/if}]
                            [{/block}]

                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        [{block name="details_productmain_tobasket"}]
                            [{if !$oDetailsProduct->isNotBuyable()}]
                                [{if $blCanBuy}]
                                    <div class="input-group input-group-lg">
                                        <input id="amountToBasket" class="form-control text-center large" type="number" name="am" value="1" min="1" autocomplete="off" style="padding: 5px;">
                                        <span class="input-group-btn">
                                 <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}]
                                         class="btn btn-primary">
                                    <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]
                                 </button>
                              </span>
                                    </div>
                                [{else}]
                                    <div class="alert alert-warning text-center">[{oxmultilang ident="DETAILS_CHOOSEVARIANT"}]</div>
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{* product stock *}]
                        [{if $blCanBuy}]
                            <div>
                                [{block name="details_productmain_stockstatus"}]
                                    [{include file="page/details/inc/stock.tpl"}]
                                [{/block}]
                            </div>
                        [{/if}]
                        [{if $oDetailsProduct->isBuyable()}]
                            <div>
                                [{block name="details_productmain_deliverytime"}]
                                    [{include file="page/details/inc/deliverytime.tpl"}]
                                [{/block}]
                            </div>
                        [{/if}]

                    </div>
                </div>

            </form>
            <!--
            <hr/>
            blCanBuy: [{$blCanBuy|var_dump}]<br/>
            isBuyable: [{$oDetailsProduct->isBuyable()|var_dump}]
            <hr/> -->

            [{block name="details_productmain_watchlist"}][{/block}]

            [{block name="details_productmain_social"}][{/block}]


        </div>
    </div>
</div>