[{if $oView->isPriceCalculated()}]
    [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
        ([{if $oView->isVatIncluded()}][{oxmultilang ident="PLUS_SHIPPING"}][{else}][{oxmultilang ident="PLUS_VAT"}] [{oxmultilang ident="AND"}][{/if}]
        <a href="[{$oCont->getLink()}]" data-fancybox data-type="ajax" data-src="[{$oCont->getLink()|oxaddparams:'plain=1'}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a>)
    [{/oxifcontent}]
[{/if}]