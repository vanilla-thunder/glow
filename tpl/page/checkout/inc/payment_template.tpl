<div class="radio">
   <!-- <div class="pull-right">
   [{* payment icon :: upload png icon into out/pictures/wyswiwigpro/paymenticons *}]
        <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/paymenticons/'|cat:$sPaymentID|cat:'.png'}]" alt="[{$paymentmethod->oxpayments__oxdesc->value}]">
    </div>
    -->

   <label for="payment_[{$sPaymentID}]">
      <input type="radio" name="paymentid" id="payment_[{$sPaymentID}]" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $sPaymentID}]checked[{/if}]>
      <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
      [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
   </label>

   <div class="paymentdescription">

      [{* payment method description from backend :: always visible*}]
      [{block name="checkout_payment_longdesc"}]
         [{if $paymentmethod->oxpayments__oxlongdesc->value}]
            <p>[{oxeval var=$paymentmethod->oxpayments__oxlongdesc->value}]</p>
         [{/if}]
      [{/block}]

      [{* if you have additional input fields or other stuff, place it inside the following container :: visible when checked *}]
      <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>

         [{if $paymentmethod->getDynValues()}]
            [{foreach from=$paymentmethod->getDynValues() item=value name=PaymentDynValues}]
               <div class="form-group">
                  <label class="control-label col-lg-3" for="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]">[{$value->name}]</label>
                  <div class="col-lg-9">
                     <input id="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]" type="text" class="form-control textbox" size="20" maxlength="64" name="dynvalue[[{$value->name}]]" value="[{$value->value}]">
                  </div>
               </div>
            [{/foreach}]
         [{/if}]

      </div>

   </div>
</div>