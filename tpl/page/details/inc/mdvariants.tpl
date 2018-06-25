[{elseif $aVariantSelections.selections|@count == 1}] [{* nur eine Ebene *}]


<input type="hidden" name="fnc" value="tobasket">
<input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
[{foreach from=$aVariantSelections.selections item=oList key=iKey}]
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
    <!--
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
                            -->

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
<!--
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
                        -->

[{* product stock *}]
<div class="text-center">
    [{block name="details_productmain_stockstatus"}]
        [{include file="page/details/inc/stock.tpl"}]
    [{/block}]
    &nbsp;
    [{block name="details_productmain_deliverytime"}]
        [{include file="page/details/inc/deliverytime.tpl"}]
    [{/block}]
</div>
[{elseif $aVariantSelections.selections|@count == 2}]

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
            <div id="variants[{$iKey}]" class="panel-collapse collapse [{* if $smarty.foreach.mdvariants.first}]in[{/if*}]" role="tabpanel" aria-labelledby="heading[{$iKey}]">
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
    &nbsp;
    [{block name="details_productmain_deliverytime"}]
        [{include file="page/details/inc/deliverytime.tpl"}]
    [{/block}]
</div>