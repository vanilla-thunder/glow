[{oxscript include="js/pages/details.min.js" priority=10}]

[{assign var="oManufacturer" value=$oView->getManufacturer()}]

[{assign var="oParentProduct" value=$oDetailsProduct->getParentArticle() }]

[{assign var="oVaraintList" value=$oView->getVariantList() }]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]


[{* logik, ob der Artikel gekauft werden kann *}]
[{assign var="blCanBuy" value=true}]
<div>oxArticle->isBuyable() :: [{$oDetailsProduct->isBuyable()|@var_dump}]</div>
<div>$oDetailsProduct->isParentNotBuyable() :: [{$oDetailsProduct->isParentNotBuyable()|@var_dump}]</div>
<div>$aVariantSelections.blPerfectFit :: [{$aVariantSelections.blPerfectFit|@var_dump}]</div>
[{* <div><pre>[{ $aVariantSelections.selections|@var_export:true|@highlight_string:true}]</pre></div> *}]

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

            [{* Varianten *}]

            [{* 1d variant selection lists *}]
            [{assign var="aRadioVariatns" value=$oViewConf->getViewThemeParam('aProductPageRadioVarselect') }]
            [{assign var="aTableVariatns" value=$oViewConf->getViewThemeParam('aProductPageTableVarselect') }]
            [{assign var="aButtonVariatns" value=$oViewConf->getViewThemeParam('aProductPageButtonVarselect') }]
            [{assign var="aImageVariatns" value=$oViewConf->getViewThemeParam('aProductPageImageVarselect') }]
            [{* combined 2d *}]
            [{assign var="a2dTableVariatns" value=$oViewConf->getViewThemeParam('aProductPage2dTableVarselect') }]
            [{assign var="a2dPanelsVariatns" value=$oViewConf->getViewThemeParam('aProductPage2dPanelsVarselect') }]

            <hr/>

            <form class="js-oxProductForm form-horizontal" action="[{$oViewConf->getSelfActionLink()}]" method="post">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                    <input type="hidden" name="parentid" value="[{$oDetailsProduct->oxarticles__oxparentid->value|default:$oDetailsProduct->oxarticles__oxid->value}]">
                    <input type="hidden" name="panid" value="">
                </div>

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

                <div id="variants">

                    [{if $aVariantSelections.selections|@count == 1}] [{* nur eine Ebene *}]
                        <input type="hidden" name="fnc" value="tobasket">
                        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
                        <input id="amountToBasket" type="hidden" name="am" value="1" min="1" autocomplete="off">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <td><b>[{$oDetailsProduct->oxarticles__oxvarname->value}]</b></td>
                                <td><b>[{oxmultilang ident="PRICE"}]</b></td>
                                <td width="100"></td>
                            </tr>
                            </thead>
                            <tbody>
                            [{*
                            [{if !$oDetailsProduct->isParentNotBuyable()}]
                                <tr>
                                    <td valign="middle" style="vertical-align:middle;">
                                        [{$oDetailsProduct->oxarticles__oxvarselect->value}]asdasdasd[{$oDetailsProduct->isNotBuyable()|@var_dump}]
                                    </td>
                                    <td valign="middle" style="vertical-align:middle;"><b>[{oxprice price=$oDetailsProduct->getPrice()}]</b>
                                        [{if $oDetailsProduct->getUnitPrice()}]
                                            [{math equation="x/y" x=$oDetailsProduct->getBasePrice() y=$oDetailsProduct->getUnitQuantity() format="%.3f" assign="_ppu"}]
                                            <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/[{$_oVariant->getUnitName()}])</em>
                                        [{elseif $oDetailsProduct->oxarticles__oxvarname->value === "Menge"}]
                                            [{math equation="x/y" x=$oDetailsProduct->getBasePrice() y=$oDetailsProduct->oxarticles__oxvarselect->value format="%.3f" assign="_ppu"}]
                                            <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/Stück)</em>
                                        [{/if}]
                                    </td>
                                    <td>
                                        <button type="submit" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]" class="btn btn-primary btn-sm">
                                            <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i> [{oxmultilang ident="TO_CART"}]
                                        </button>
                                    </td>
                                </tr>
                            [{/if}]
                            *}]

                            [{foreach from=$oView->getVariantList() item="_oVariant" key="_vOxid"}]
                                <tr>
                                    <td valign="middle" style="vertical-align:middle;">
                                        [{if $_oVariant->oxarticles__oxvarselect->value|is_numeric  && $_oVariant->oxarticles__oxvarselect->value|intval == $_oVariant->oxarticles__oxvarselect->value}]
                                            [{$_oVariant->oxarticles__oxvarselect->value|number_format:0:',':'.' }]
                                        [{else}]
                                            [{$_oVariant->oxarticles__oxvarselect->value}]
                                        [{/if}]
                                    </td>
                                    <td valign="middle" style="vertical-align:middle;"><b>[{oxprice price=$_oVariant->getPrice()}]</b>
                                        [{if $_oVariant->getUnitPrice()}]
                                            [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->getUnitQuantity() format="%.3f" assign="_ppu"}]
                                            <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/[{$_oVariant->getUnitName()}])</em>
                                        [{elseif $oDetailsProduct->oxarticles__oxvarname->value === "Menge"}]
                                            [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->oxarticles__oxvarselect->value format="%.3f" assign="_ppu"}]
                                            <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/Stück)</em>
                                        [{/if}]
                                    </td>
                                    <td>
                                        [{if !$_oVariant->isNotBuyable()}]
                                            <button type="submit" name="aid" value="[{$_vOxid}]" class="btn btn-primary btn-sm">
                                                <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i> [{oxmultilang ident="TO_CART"}]
                                            </button>
                                        [{/if}]
                                    </td>
                                </tr>
                            [{/foreach}]
                            </tbody>
                        </table>
                        [{*
                        <h3>[{$oDetailsProduct->oxarticles__oxvarname->value}]</h3>
                        <div class="list-group">
                            [{foreach from=$oView->getVariantList() item="_oVariant" key="_vOxid"}]
                              <a href="[{$_oVariant->getLink()}]" class="list-group-item [{if $oDetailsProduct->oxarticles__oxid->value === $_vOxid}]active[{/if}]">
                                <h4 class="list-group-item-heading">[{$_oVariant->oxarticles__oxvarselect->value}]</h4>
                                <p class="list-group-item-text">
                                    [{oxprice price=$_oVariant->getPrice()}]
                                </p>
                              </a>
                            [{/foreach}]
                        </div>
                        *}]

                        [{* product stock *}]
                        <div class="text-center">
                            [{block name="details_productmain_stockstatus"}]
                                [{include file="page/details/inc/stock.tpl"}]
                            [{/block}]
                            &nbsp;|&nbsp;
                            [{block name="details_productmain_deliverytime"}]
                                [{include file="page/details/inc/deliverytime.tpl"}]
                            [{/block}]
                        </div>
                    [{elseif $aVariantSelections.selections|@count == 2}] [{* 2D Panels *}]

                        [{if $oDetailsProduct->isParentNotBuyable()}]<h3>[{oxmultilang ident="DETAILS_CHOOSEVARIANT" suffix="COLON"}]</h3>[{/if}]
                        [{*
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                                        <td><b>[{$oList->getLabel()}]</b></td>
                                    [{/foreach}]
                                      <td><b>[{oxmultilang ident="PRICE"}]</b></td>
                                      <td width="180"></td>
                                </tr>
                            </thead>
                            <tbody>
                                [{foreach from=$oDetailsProduct->getMdSubvariants() item=_mdVar key=iKey}]
                                    [{foreach from=$_mdVar->getMdSubvariants() item=_mdSubVar key=iSubKey name="mdsubvariants"}]
                                        [{assign var="_oVariant" value=$oVaraintList->offsetGet($_mdSubVar->getArticleId()) }]
                                        <tr>
                                            [{if $smarty.foreach.mdsubvariants.first}]
                                                <td valign="middle" style="vertical-align:middle;" rowspan="[{$_mdVar->getMdSubvariants()|@count}]">[{$_mdVar->getName()}]</td>
                                            [{/if}]
                                            <td>[{$_mdSubVar->getName()}]</td>
                                            <td>[{oxprice price=$_mdSubVar->getDPrice()}]
                                                [{if $_oVariant->getUnitPrice()}]
                                                    [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->getUnitQuantity() format="%.3f" assign="_ppu"}]
                                                    <em>([{$_ppu|replace:'.':','}] [{$currency->sign}]/[{$_oVariant->getUnitName()}])</em>
                                                [{elseif $oDetailsProduct->oxarticles__oxvarname->value === "Menge"}]
                                                    [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->oxarticles__oxvarselect->value format="%.3f" assign="_ppu"}]
                                                    <em>([{$_ppu|replace:'.':','}] [{$currency->sign}]/Stück)</em>
                                                [{/if}]
                                            </td>
                                            <td>
                                                <a href="[{$_oVariant->getToBasketLink()|oxaddparams:'am=1' }]" class="btn btn-primary">
                                                    <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i> [{oxmultilang ident="TO_CART"}]
                                                </a>
                                            </td>
                                        </tr>
                                    [{/foreach}]
                                [{/foreach}]
                            </tbody>
                        </table>
                        *}]
                        <div class="panel-group" id="variantz" role="tablist" aria-multiselectable="true">
                            [{foreach from=$oDetailsProduct->getMdSubvariants() item=_mdVar key=iKey name="mdvariants"}]
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="heading[{$iKey}]">
                                        <h4 class="panel-title">
                                            <a role="button" class="center-block" data-toggle="collapse" data-parent="#variantz" href="#variants[{$iKey}]" aria-expanded="true" aria-controls="variants[{$iKey}]">
                                                [{$aVariantSelections.selections[0]->getLabel()}] [{$_mdVar->getName()}]
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="variants[{$iKey}]" class="panel-collapse collapse [{if $smarty.foreach.mdvariants.first}]in[{/if}]" role="tabpanel" aria-labelledby="heading[{$iKey}]">
                                        <div class="panel-body">

                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <td><b>[{$aVariantSelections.selections[1]->getLabel()}]</b></td>
                                                    <td><b>[{oxmultilang ident="PRICE"}]</b></td>
                                                    <td width="100"></td>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                [{foreach from=$_mdVar->getMdSubvariants() item=_mdSubVar key=iSubKey name="mdsubvariants"}]
                                                    [{assign var="_oVariant" value=$oVaraintList->offsetGet($_mdSubVar->getArticleId()) }]
                                                    <tr>
                                                        <td valign="middle" style="vertical-align:middle;">
                                                            [{if $_mdSubVar->getName()|is_numeric  && $_mdSubVar->getName()|intval == $_mdSubVar->getName()}]
                                                                [{$_mdSubVar->getName()|number_format:0:',':'.' }]
                                                            [{else}]
                                                                [{$_mdSubVar->getName()}]
                                                            [{/if}]
                                                        </td>
                                                        <td valign="middle" style="vertical-align:middle;"><b>[{oxprice price=$_mdSubVar->getDPrice()}]</b>
                                                            [{if $_oVariant->getUnitPrice()}]
                                                                [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->getUnitQuantity() format="%.3f" assign="_ppu"}]
                                                                <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/[{$_oVariant->getUnitName()}])</em>
                                                            [{elseif $oDetailsProduct->oxarticles__oxvarname->value === "Menge"}]
                                                                [{math equation="x/y" x=$_oVariant->getBasePrice() y=$_oVariant->oxarticles__oxvarselect->value format="%.3f" assign="_ppu"}]
                                                                <em>([{$_ppu|replace:'.':','}]&nbsp;[{$currency->sign}]/Stück)</em>
                                                            [{/if}]
                                                        </td>
                                                        <td>
                                                            <a href="[{$_oVariant->getToBasketLink()|oxaddparams:'am=1' }]" class="btn btn-primary btn-sm">
                                                                <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i> [{oxmultilang ident="TO_CART"}]
                                                            </a>
                                                        </td>
                                                    </tr>
                                                [{/foreach}]
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            [{/foreach}]
                        </div>
                        [{* product stock *}]
                        <div class="text-center">
                            [{block name="details_productmain_stockstatus"}]
                                [{include file="page/details/inc/stock.tpl"}]
                            [{/block}]
                            &nbsp;|&nbsp;
                            [{block name="details_productmain_deliverytime"}]
                                [{include file="page/details/inc/deliverytime.tpl"}]
                            [{/block}]
                        </div>
                    [{else}]

                        [{* variants | md variants *}]
                        [{block name="details_productmain_variantselections"}]
                            [{assign var="blHasActiveSelections" value=false}]
                            [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                                [{if $oList->getActiveSelection()}]
                                    [{assign var="blHasActiveSelections" value=true}]
                                [{/if}]
                                [{if $oList->getLabel()|in_array:$aRadioVariatns }]
                                    [{include file="page/details/inc/varselect_radio.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                                [{elseif $oList->getLabel()|in_array:$aTableVariatns }]
                                    [{include file="page/details/inc/varselect_table.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                                [{elseif $oList->getLabel()|in_array:$aButtonVariatns }]
                                    [{include file="page/details/inc/varselect_button.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                                [{else}]
                                    [{include file="page/details/inc/varselect_dropdown.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                                [{/if}]
                            [{/foreach}]
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

                        [{block name="details_productmain_tobasket"}]
                            [{if !$oDetailsProduct->isNotBuyable()}]
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
                                <!-- <div class="alert alert-warning text-center">[{oxmultilang ident="DETAILS_CHOOSEVARIANT"}]</div> -->
                            [{/if}]
                        [{/block}]
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