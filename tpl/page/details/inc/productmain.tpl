[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="oParentProduct" value=$oDetailsProduct->getParentArticle() }]
[{assign var="oVaraintList" value=$oView->getVariantList() }]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{* logik, ob der Artikel gekauft werden kann *}]
[{assign var="blCanBuy" value=true}]
[{if $aVariantSelections && $aVariantSelections.selections}][{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}][{/if}]

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
        <h1 class="text-center">
            [{$oDetailsProduct->oxarticles__oxtitle->value}]
            [{if $oViewConf->getViewThemeParam('blProductShowVarselect')}][{$oDetailsProduct->oxarticles__oxvarselect->value}][{/if}]
        </h1>
    [{/block}]

    <div class="row">
        [{assign var="sProductPageLayout" value=$oViewConf->getViewThemeParam('sProductPageLayout')}]

        [{* article picture with zoom *}]
        <div class="col-xs-12 col-sm-[{if $sProductPageLayout == '33+66' }]4[{elseif $sProductPageLayout == '50+50' }]6[{else}]8[{/if}]">
            [{block name="details_productmain_zoom"}]
                <div class="picture">
                    <a href="[{$oPictureProduct->getZoomPictureUrl(1)}]" data-fancybox="produktbilder" id="zoom1" class="thumbnail">
                        <img src="[{$oView->getActPicture()}]" class="img-responsive" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
                    </a>
                </div>
            [{/block}]

            [{block name="details_productmain_morepics"}]
                [{include file="page/details/inc/morepics.tpl"}]
            [{/block}]

            [{block name="details_productmain_attributes"}]
                [{if $oView->getAttributes()}]
                    [{block name="details_productmain_attributes_heading"}]
                        <h4>[{oxmultilang ident="SPECIFICATION" suffix="COLON"}]</h4>
                    [{/block}]
                    <div>
                        [{block name="details_productmain_attributes_content"}][{include file="page/details/inc/attributes.tpl"}][{/block}]
                    </div>
                [{/if}]
            [{/block}]

            [{block name="details_productmain_media"}]
                [{assign var="aMediasUrls" value=$oDetailsProduct->getMediaUrls()}]
                [{if !$aMediasUrls|@count && $oParentProduct && $oParentProduct->getMediaUrls()}][{assign var="aMediasUrls" value=$oParentProduct->getMediaUrls()}][{/if}]
                [{if $aMediasUrls|@count > 0 }]
                    <div>
                        [{foreach from=$aMediasUrls item="oMediaUrl" name="mediaURLs"}]
                            <a target="_blank" href="[{$oMediaUrl->getLink()}]" class="btn btn-default">
                                [{assign var="_icon" value="file"}]
                                [{if $oMediaUrl->oxmediaurls__oxurl->value|substr:'-3' == 'pdf'}][{assign var="_icon" value="file-pdf-o"}]
                                [{elseif $oMediaUrl->oxmediaurls__oxurl->value|substr:'-4' == 'docx'}][{assign var="_icon" value="fa-file-word-o"}]
                                [{elseif $oMediaUrl->oxmediaurls__oxurl->value|substr:'-4' == 'xlsx'}][{assign var="_icon" value="fa-file-excel-o"}]
                                [{/if}]
                                <i class="text-danger fa fa-[{$_icon}] fa-lg fa-fw" aria-hidden="true"></i>
                                [{$oMediaUrl->oxmediaurls__oxdesc->rawValue}]
                            </a>
                        [{/foreach}]
                    </div>
                [{/if}]
            [{/block}]
        </div>

        [{* product info *}]
        <div class="col-xs-12 col-sm-[{if $sProductPageLayout == '33+66' }]8[{elseif $sProductPageLayout == '50+50' }]6[{else}]4[{/if}]">

            [{* article number *}]
            [{block name="details_productmain_artnumber"}]
                <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</span>
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
                    <p class="shortdesc">[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
                [{/if}]
            [{/block}]

            [{* weight *}]
            [{if $oDetailsProduct->oxarticles__oxweight->value}]
                <div class="weight">
                    [{block name="details_productmain_weight"}]
                        [{oxmultilang ident="WEIGHT" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]
                    [{/block}]
                </div>
            [{/if}]

            <hr/>

            [{* Preis *}]
            [{assign var=price  value=$oDetailsProduct->getPrice()}]
            [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
            [{if !$tprice && $oParentProduct && $oParentProduct->getTPrice()}]
                [{assign var=tprice value=$oParentProduct->getTPrice()}]
            [{/if}]

            <div class="text-center">
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
                        <strong class="h1">
                            <span class="price-from">[{$sFrom}]</span>
                            <span class="price">[{$fPrice}]</span>
                            <span class="currency">[{$currency->sign}]</span>
                        </strong>
                        <div class="price-markup">[{include file="page/details/inc/vatinfo.tpl"}]</div>
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
                                    <td>[{oxmultilang ident="PRICE_FROM"}] <b>[{$priceItem->oxprice2article__oxamount->value}]</b> [{oxmultilang ident="PCS"}]</td>
                                    <td>
                                        [{if $priceItem->oxprice2article__oxaddperc->value}]
                                            [{$priceItem->oxprice2article__oxaddperc->value}]% [{oxmultilang ident="DISCOUNT"}]
                                        [{else}]
                                            [{$priceItem->fbrutprice}] [{$currency->sign}]
                                            <small>( -[{math equation="(a-b)/a*100" a=$fPrice|replace:',':'.' b=$priceItem->oxprice2article__oxaddabs->value format="%.1f" }]%)</small>
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

            <hr/>

            <form class="js-oxProductForm form-horizontal" action="[{$oViewConf->getSelfActionLink()}]" method="post">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                    <input type="hidden" name="parentid" value="[{$oDetailsProduct->oxarticles__oxparentid->value|default:$oDetailsProduct->oxarticles__oxid->value}]">
                    <input type="hidden" name="panid" value="">
                </div>

                [{* pers params *}]
                [{block name="details_productmain_persparams"}]
                    [{if $oView->isPersParam()}]
                        <div id="persparam" class="form-group">
                            <label for="persistentParam" class="col-xs-12 col-sm-3 control-label"><strong>[{oxmultilang ident="YOUR_MESSAGE" suffix="COLON"}]</strong></label>
                            <div class="col-xs-12 col-sm-9">
                                <input id="persistentParam" class="form-control" type="text" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35">
                            </div>
                        </div>
                    [{/if}]
                [{/block}]

                [{* Varianten Darstellung Konfig *}]
                [{assign var="aTableVariatns"  value=$oViewConf->getViewThemeParam('aProductPageTableVarselect') }]
                [{assign var="aRadioVariatns"  value=$oViewConf->getViewThemeParam('aProductPageRadioVarselect') }]
                [{assign var="aButtonVariatns" value=$oViewConf->getViewThemeParam('aProductPageButtonVarselect') }]
                [{assign var="aImageVariatns"  value=$oViewConf->getViewThemeParam('aProductPageImageVarselect') }]

                [{* selection lists *}]
                [{block name="details_productmain_selectlists"}]
                    [{if $oViewConf->showSelectLists()}]
                        <div id="selectionlists">
                            [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                            [{if $oSelections}]
                                <div>
                                    [{foreach from=$oSelections item=oList name=selections}]
                                        [{if $oList->oxselectlist__oxtitle->rawValue|in_array:$aRadioVariatns }]
                                            [{include file="page/details/inc/varselect_radio.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                        [{else}]
                                            [{include file="page/details/inc/varselect_dropdown.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                        [{/if}]
                                    [{/foreach}]
                                </div>
                            [{/if}]
                        </div>
                    [{/if}]
                [{/block}]

                [{capture name="tobasketbtn"}]
                [{block name="details_productmain_tobasket"}]
                    [{if $oViewConf->getViewThemeParam('blProductPageShow2BasketAmount')}]
                        <div class="input-group input-group-lg">
                            <input id="amountToBasket" class="form-control text-center large" type="number" name="am" value="1" min="1" autocomplete="off" style="padding: 5px;">
                            <span class="input-group-btn">
                                <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary">
                                    <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]
                                </button>
                            </span>
                        </div>
                    [{else}]
                        <input id="amountToBasket" type="hidden" name="am" value="1" min="1" autocomplete="off">
                        <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary btn-block btn-lg">
                            <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]
                        </button>
                    [{/if}]
                [{/block}]
                [{/capture}]

                <div id="variants">
                    [{if $aVariantSelections.selections|@count == 1}]
                        [{* nur eine Ebene Varianten *}]
                        <input type="hidden" name="fnc" value="tobasket">
                        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
                        <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">

                        [{if $oDetailsProduct->oxarticles__oxvarname->value|in_array:$aTableVariatns }]

                            <input type="hidden" name="am" value="1" min="1" autocomplete="off" id="amountToBasket">
                            <table class="table table-striped">
                                <colgroup>
                                    <col width="*">
                                    <col width="*">
                                    <col width="200">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>[{$oDetailsProduct->oxarticles__oxvarname->value}]</th>
                                    [{* <th>[{oxmultilang ident="STOCK"}]</th> *}]
                                    <th>[{oxmultilang ident="PRICE"}]</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                [{foreach from=$oView->getVariantList() item="_variant" name="variants"}]
                                    <tr>
                                        <td>[{$_variant->oxarticles__oxvarselect->value}]</td>
                                        [{* <td>[{if $_variant->isBuyable() && $_variant->oxarticles__oxstock->value > 0}][{$_variant->oxarticles__oxstock->value}][{else}]-[{/if}]</td> *}]
                                        <td>[{if $_variant->isBuyable()}][{oxprice price=$_variant->getPrice()}][{else}]-[{/if}]</td>
                                        <td>
                                            [{if $_variant->isBuyable()}]
                                                <button type="submit" name="aid" value="[{$_variant->oxarticles__oxid->value}]" class="btn btn-primary btn-block" style="min-width: 0;">
                                                    <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]
                                                </button>
                                            [{else}]
                                                <button class="btn btn-danger btn-block disabled" disabled style="min-width: 0;">[{oxmultilang ident="NOT_AVAILABLE"}]</button>
                                            [{/if}]
                                        </td>
                                    </tr>
                                [{/foreach}]
                                </tbody>
                            </table>

                        [{elseif $oDetailsProduct->oxarticles__oxvarname->value|in_array:$aRadioVariatns }]

                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label"><strong>[{$oDetailsProduct->oxarticles__oxvarname->value}][{oxmultilang ident="COLON"}]</strong></label>
                                <div class="col-xs-12 col-sm-9">
                                    [{foreach from=$oView->getVariantList() item="_variant" name="variants"}]
                                        <div class="radio [{if !$_variant->isBuyable()}]disabled[{/if}]">
                                            <label>
                                                <input type="radio" [{if !$_variant->isBuyable()}]disabled[{/if}] [{if $oDetailsProduct->oxarticles__oxid->value == $_variant->oxarticles__oxid->value}]checked[{/if}]
                                                       id="varselid_[{$_variant->oxarticles__oxid->value}]"
                                                       name="anid" value="[{$_variant->oxarticles__oxid->value}]">
                                                [{$_variant->oxarticles__oxvarselect->value}] [{if !$_variant->isBuyable()}]([{oxmultilang ident="NOT_AVAILABLE"}])[{/if}]
                                            </label>
                                        </div>
                                    [{/foreach}]
                                </div>
                            </div>
                            [{$smarty.capture.tobasketbtn}]

                        [{elseif $oDetailsProduct->oxarticles__oxvarname->value|in_array:$aButtonVariatns }]

                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label"><strong>[{$oDetailsProduct->oxarticles__oxvarname->value}][{oxmultilang ident="COLON"}]</strong></label>
                                <div class="col-xs-12 col-sm-9">
                                    [{foreach from=$oView->getVariantList() item="_variant" name="variants"}]
                                        <div class="radiobtn col-xs-12 col-sm-6">
                                            <input type="radio" name="anid" value="[{$_variant->oxarticles__oxid->value}]" class="hidden" id="varselid_[{$_variant->oxarticles__oxid->value}]"
                                                   [{if !$_variant->isBuyable()}]disabled title="[{oxmultilang ident='NOT_AVAILABLE'}]"[{/if}]
                                                   [{if $oDetailsProduct->oxarticles__oxid->value == $_variant->oxarticles__oxid->value}]checked[{/if}]>
                                            <label for="varselid_[{$_variant->oxarticles__oxid->value}]" [{if !$_variant->isBuyable()}]disabled title="[{oxmultilang ident='NOT_AVAILABLE'}]"[{/if}] class="btn btn-label btn-block">
                                                [{$_variant->oxarticles__oxvarselect->value}][{if !$_variant->isBuyable()}] <small>([{oxmultilang ident="NOT_AVAILABLE"}])</small>[{/if}]
                                            </label>
                                        </div>
                                    [{/foreach}]
                                </div>
                            </div>
                            [{$smarty.capture.tobasketbtn}]

                        [{elseif $oDetailsProduct->oxarticles__oxvarname->value|in_array:$aImageVariatns }]

                        [{else}]
                            <div class="form-group">
                                <label class="col-xs-12 col-sm-3 control-label"><strong>[{$oDetailsProduct->oxarticles__oxvarname->value}][{oxmultilang ident="COLON"}]</strong></label>
                                <div class="col-xs-12 col-sm-9">
                                    <select name="anid" id="varselid_0" class="form-control">
                                        [{foreach from=$oView->getVariantList() item="_variant" name="variants"}]
                                            <option value="[{$_variant->oxarticles__oxid->value}]" id="varselid_[{$_variant->oxarticles__oxid->value}]"
                                                    [{if !$_variant->isBuyable()}]disabled title="[{oxmultilang ident='NOT_AVAILABLE'}]"[{/if}]
                                                    [{if $oDetailsProduct->oxarticles__oxid->value == $_variant->oxarticles__oxid->value}]selected[{/if}]>
                                                [{$_variant->oxarticles__oxvarselect->value}][{if !$_variant->isBuyable()}] <small>([{oxmultilang ident="NOT_AVAILABLE"}])</small>[{/if}]
                                            </option>
                                        [{/foreach}]
                                    </select>
                                </div>
                            </div>
                            [{$smarty.capture.tobasketbtn}]
                        [{/if}]

                    [{elseif $oViewConf->getViewThemeParam("blProductPageMdVarList")}]
                        [{* mehrdimensionale Tabelle *}]
                        [{include file="page/details/inc/mdvariants.tpl"}]

                    [{else}]
                        [{* reguläre Darstellung *}]

                        <input type="hidden" name="fnc" value="tobasket">
                        <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
                        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">

                        [{assign var="blHasActiveSelections" value=false}]
                        [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                            [{assign var="blHasActiveSelections" value=$oList->getActiveSelection()|@boolval}]

                            [{if $oList->getLabel()|in_array:$aTableVariatns }]
                                [{include file="page/details/inc/varselect_table.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{elseif $oList->getLabel()|in_array:$aRadioVariatns }]
                                [{include file="page/details/inc/varselect_radio.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{elseif $oList->getLabel()|in_array:$aButtonVariatns }]
                                [{include file="page/details/inc/varselect_button.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{elseif $oList->getLabel()|in_array:$aImageVariatns }]
                                [{include file="page/details/inc/varselect_image.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{else}]
                                [{include file="page/details/inc/varselect_dropdown.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            [{/if}]
                        [{/foreach}]


                        [{if $oDetailsProduct->isBuyable()}]
                            [{* product stock *}]
                            <div class="text-center">
                                <p>
                                [{block name="details_productmain_stockstatus"}]
                                    [{include file="page/details/inc/stock.tpl"}]
                                [{/block}]
                                &nbsp;
                                [{block name="details_productmain_deliverytime"}]
                                    [{include file="page/details/inc/deliverytime.tpl"}]
                                [{/block}]
                                </p>
                            </div>
                            [{$smarty.capture.tobasketbtn}]
                        [{else}]
                            <div class="alert alert-warning text-center">[{oxmultilang ident="DETAILS_CHOOSEVARIANT"}]</div>
                        [{/if}]
                    [{/if}]

                </div>
            </form>

            [{block name="details_productmain_vpe"}]
                [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                    <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                    <br>
                [{/if}]
            [{/block}]

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