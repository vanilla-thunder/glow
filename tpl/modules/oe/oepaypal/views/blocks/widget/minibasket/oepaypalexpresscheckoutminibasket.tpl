[{$smarty.block.parent}]

[{if $oViewConf->isExpressCheckoutEnabledInMiniBasket()}]
<tr>
    <td colspan="2">
        <div id="paypalExpressCheckoutMiniBasketBox" class="paypalExpressCheckoutBox">
        <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
            <div>
                [{$oViewConf->getHiddenSid()}]
                <input type="hidden" name="cl" value="oePayPalExpressCheckoutDispatcher"/>
                <input type="hidden" name="fnc" value="setExpressCheckout"/>
                <input type="hidden" name="oePayPalCancelURL" value="[{$oViewConf->getCurrentURL()}]"/>
                <input type="image" name="paypalExpressCheckoutButton" src="[{$oViewConf->getModuleUrl('oepaypal','out/img/')}][{$oViewConf->getActLanguageAbbr()}]-btn-expresscheckout.png" title="[{$oViewConf->getPayPalPaymentDescription()|strip_tags:false|trim|oxescape}]">
                [{if $oViewConf->sendOrderInfoToPayPal()}]
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="displayCartInPayPal" value="1" [{if $oViewConf->sendOrderInfoToPayPalDefault()}]checked[{/if}]>
                        [{oxmultilang ident="OEPAYPAL_DISPLAY_BASKET_IN_PAYPAL"}]
                    </label>
                </div>
                [{/if}]
            </div>
        </form>
        </div>        
    </td>
</tr>
[{oxstyle include=$oViewConf->getModuleUrl('oepaypal','out/src/css/paypal.css')}]

[{/if}]
