[{$smarty.block.parent}]
[{assign var="_price" value=$oDetailsProduct->getPrice() }]
[{assign var="_tprice" value=$oDetailsProduct->getTPrice() }]
[{if $_tprice && $_tprice->getBruttoPrice() > $_price->getBruttoPrice()}]
    <div>
        <b>
            [{if $oDetailsProduct->isParentNotBuyable() && $oDetailsProduct->isRangePrice() }][{oxmultilang ident="BLA_TPRICE_UP_TO"}] [{/if}] [{* bei Preisen "Ab ...€" kommt "bis zu XY%" *}]
            [{oxmultilang ident="BLA_TPRICE_PERCENT_CHEAPER" args=$oDetailsProduct->getSavingPercent()}], [{* XY% günstiger *}]
            [{oxmultilang ident="BLA_TPRICE_YOU_SAVE"}] [{oxprice price=$oDetailsProduct->getSaving() currency=$currency}] [{* Sie sparen XY € *}]
        </b>
    </div>
[{/if}]