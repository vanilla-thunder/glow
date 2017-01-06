[{$smarty.block.parent}]
[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
    <div><b>
            [{if $oDetailsProduct->isParentNotBuyable() && $oDetailsProduct->isRangePrice() }][{oxmultilang ident="BLA_TPRICE_UP_TO"}] [{/if}] [{* bei Preisen "Ab ...€" kommt "bis zu XY%" *}]
            [{oxmultilang ident="BLA_TPRICE_PERCENT_CHEAPER" args=$oDetailsProduct->getSavingPercent()}], [{* XY% günstiger *}]
            [{oxmultilang ident="BLA_TPRICE_YOU_SAVE"}] [{oxprice price=$oDetailsProduct->getSaving() currency=$currency}] [{* Sie sparen XY € *}]
        </b>
    </div>
[{/if}]