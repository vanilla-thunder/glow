[{assign var="sImageUrl" value=$oViewConf->getModuleUrl('d3heidelpay','out/img/')}]
[{assign var='oHeidelPaySettings' value=$oHeidelpayViewConfig->getSettings()}]
[{assign var='oHeidelPayment' value=$oHeidelPaySettings->getPayment($paymentmethod)}]
[{assign var="aBrands" value=$oHeidelpayViewConfig->getHeidelpayNgwBrands($paymentmethod, $oHeidelPayment, $oxcmp_user)}]
[{assign var="sBrandIdent" value=$aBrands.PAYPAL}]
[{assign var="sFullImageUrl" value=$sImageUrl|cat:'logo_'|cat:$sBrandIdent|lower|cat:'.png'}]

[{block name="heidelpay_paypal"}]
   <div class="radio">
      <div class="pull-right">
         [{include file="d3_d3heidelpay_views_tpl_payment_img.tpl" sImageUrl=$sFullImageUrl sBrandIdent=$sBrandIdent}]
      </div>
      <label for="payment_[{$sPaymentID}]">
         <input type="radio" id="payment_[{$sPaymentID}]" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() === $sPaymentID}]checked[{/if}]
                 [{if !$blD3HeidelpayHasSameAdresses}]disabled[{/if}]>
         <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
         [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
      </label>

      <div class="paymentdescription">
         [{if false == $blD3HeidelpayHasSameAdresses}]
            <sup class="alert alert-danger">[{oxmultilang ident="D3HEIDELPAY_PAYMENT_NOTSAMEADDRESS_NOTICE"}]</sup>
         [{/if}]

         <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>

            [{block name="checkout_payment_longdesc"}]
               [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                  <p>[{oxeval var=$paymentmethod->oxpayments__oxlongdesc->value}]</p>
               [{/if}]
            [{/block}]

         </div>
      </div>
   </div>
[{/block}]
