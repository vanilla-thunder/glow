[{assign var="sImageUrl" value=$oViewConf->getModuleUrl('d3heidelpay','out/img/')}]
[{assign var='oHeidelPaySettings' value=$oHeidelpayViewConfig->getSettings()}]
[{assign var='oHeidelPayment' value=$oHeidelPaySettings->getPayment($paymentmethod)}]
[{assign var="aBrands" value=$oHeidelpayViewConfig->getHeidelpayNgwBrands($paymentmethod, $oHeidelPayment, $oxcmp_user)}]
[{assign var="sBrandIdent" value=$aBrands.SOFORT}]
[{assign var="sFullImageUrl" value=$sBrandIdent|lower|oxtruncate:6:''}]
[{assign var="sFullImageUrl" value=$sImageUrl|cat:'logo_'|cat:$sFullImageUrl|cat:'.jpg'}]

[{block name="heidelpay_sofortueberweisung"}]
    <div class="radio">
        <div class="pull-right">
          [{include file="d3_d3heidelpay_views_tpl_payment_img.tpl" sImageUrl=$sFullImageUrl sBrandIdent=$sBrandIdent}]
        </div>
        <label for="payment_[{$sPaymentID}]">
            <input type="radio" name="paymentid" id="payment_[{$sPaymentID}]" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $sPaymentID}]checked[{/if}]>
            <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
            [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
        </label>

        <div class="paymentdescription">
            <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>
            
            [{block name="checkout_payment_longdesc"}]
                <p>[{$paymentmethod->oxpayments__oxlongdesc->value}]</p>
            [{/block}]

            </div>
        </div>
    </div>
[{/block}]
