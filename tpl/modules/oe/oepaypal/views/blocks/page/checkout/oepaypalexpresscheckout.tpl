[{capture name="paypalExpressCheckoutFormContent"}]
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="oepaypalexpresscheckoutdispatcher">
    <input type="hidden" name="fnc" value="setExpressCheckout">
    <input type="hidden" name="oePayPalRequestedControllerKey" value="[{$oView->getClassName()}]">
    <input type="image" name="paypalExpressCheckoutButtonECS" class="pull-right"
        src="[{$oViewConf->getModuleUrl('oepaypal','out/img/')}][{$oViewConf->getActLanguageAbbr()}]-btn-expresscheckout.png" title="[{$oViewConf->getPayPalPaymentDescription()|strip_tags:false|trim|oxescape}]">
    
    <div class="pull-right">
        [{if $oViewConf->sendOrderInfoToPayPal()}]
            <input type="checkbox" name="displayCartInPayPal" value="1" [{if $oViewConf->sendOrderInfoToPayPalDefault()}]checked[{/if}]>
            [{oxmultilang ident="OEPAYPAL_DISPLAY_BASKET_IN_PAYPAL"}]
        [{/if}]
    </div>
[{/capture}]

[{if $oViewConf->isExpressCheckoutEnabled() && (('user' != $oView->getClassName()) || (('user' == $oView->getClassName() && !$oxcmp_user)))}]
    [{$smarty.block.parent}]
    [{if 'user' == $oView->getClassName()}]
        <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
                    [{$smarty.capture.paypalExpressCheckoutFormContent}]
        </form>
    [{else}]
        <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
            [{$smarty.capture.paypalExpressCheckoutFormContent}]
        </form>
    [{/if}]
    <div class="clearfix"></div>
[{else}]
    [{$smarty.block.parent}]
[{/if}]