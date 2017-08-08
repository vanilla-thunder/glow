[{if $sPaymentID == "oxidpaypal" && $oViewConf->isStandardCheckoutEnabled()}]
    [{oxstyle include=$oViewConf->getModuleUrl('oepaypal','out/src/css/paypal.css')}]
    <div class="radio">
    
        <div class="pull-right">
            <img src="[{$oViewConf->getModuleUrl('oepaypal','out/img/')}][{oxmultilang ident='OEPAYPAL_LOGO_IMG'}]" alt="[{oxmultilang ident='OEPAYPAL_PAYMENT_HELP_LINK_TEXT'}]">
        </div>
                                 
        <label for="payment_[{$sPaymentID}]">
            <input type="radio" id="payment_[{$sPaymentID}]" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() === $sPaymentID}]checked[{/if}]>
            <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
            [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice()  currency=$currency }])[{/if}]
        </label>

        <div class="paymentdescription">
            <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>
            
                [{block name="checkout_payment_longdesc"}]
                    <p>[{ oxeval var=$paymentmethod->oxpayments__oxlongdesc}]</p>
                [{/block}]
            
                [{assign var="paypalHelpLink" value="OEPAYPAL_PAYMENT_HELP_LINK"|oxmultilangassign}]
                [{oxscript add="$('.paypalPaymentImg, .paypalHelpIcon').click(function (){window.open('`$paypalHelpLink`','olcwhatispaypal','toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=500, height=450');return false;});"}]
                
                [{if $oViewConf->sendOrderInfoToPayPal()}]
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="displayCartInPayPal" value="1" [{if $oViewConf->sendOrderInfoToPayPalDefault()}]checked[{/if}]>
                            [{oxmultilang ident="OEPAYPAL_DISPLAY_BASKET_IN_PAYPAL"}]
                        </label>
                    </div>
                [{/if}]
            </div>
        </div>
    </div>
[{elseif $sPaymentID != "oxidpaypal"}]
    [{$smarty.block.parent}]
[{/if}]