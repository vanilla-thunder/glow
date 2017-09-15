[{assign var='oHeidelPaySettings' value=$oHeidelpayViewConfig->getSettings()}]
[{assign var='oHeidelPayment' value=$oHeidelPaySettings->getPayment($paymentmethod)}]
[{assign var="aBrands" value=$oHeidelpayViewConfig->getHeidelpayNgwBrands($paymentmethod, $oHeidelPayment, $oxcmp_user)}]
[{assign var="sImageUrl" value=$oViewConf->getModuleUrl('d3heidelpay','out/img/')}]

[{block name="heidelpay_cards"}]
   <div class="radio">
      [{if $aBrands}]
         <div class="pull-right">
            [{foreach from=$aBrands item='sBrandName' key='sBrandIdent'}]
               [{assign var="sFullImageUrl" value=$sImageUrl|cat:'logo_'|cat:$sBrandIdent|lower|cat:'.jpg'}]
               [{include file="d3_d3heidelpay_views_tpl_payment_img.tpl" sImageUrl=$sFullImageUrl sBrandIdent=$sBrandIdent}]
            [{/foreach}]
         </div>
      [{/if}]
      <label for="payment_[{$sPaymentID}]">
         <input type="radio" name="paymentid" id="payment_[{$sPaymentID}]" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $sPaymentID}]checked[{/if}]>
         <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
         [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
      </label>

      <div class="paymentdescription">
         <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>
            [{block name="checkout_payment_longdesc"}]
               [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                  <p>[{oxeval var=$paymentmethod->oxpayments__oxlongdesc->value}]</p>
               [{/if}]
            [{/block}]

            [{if $paymentmethod->getPrice() && $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge')}]
               [{assign var="oPaymentPrice" value=$paymentmethod->getPrice()}]
               [{oxprice price=$oPaymentPrice->getNettoPrice() currency=$currency}]
               [{if $oPaymentPrice->getVatValue() > 0}]
                  [{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oPaymentPrice->getVatValue() currency=$currency}]
               [{/if}]
            [{/if}]
            <div class="alert alert-danger">[{oxmultilang ident="D3PAYMENT_EXT_AFTERSTEP4_INFO_STEP4"}]</div>
         </div>
      </div>
   </div>
[{/block}]
