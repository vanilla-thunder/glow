<div class="radio">
    <!-- <div class="pull-right">
        <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/paymenticons/'|cat:$sPaymentID|cat:'.png'}]" alt="[{$paymentmethod->oxpayments__oxdesc->value}]">
    </div> -->

    <label for="payment_[{$sPaymentID}]">
        <input type="radio" name="paymentid" id="payment_[{$sPaymentID}]" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $sPaymentID}]checked[{/if}]>
        <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
        [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
    </label>

    <div class="paymentdescription">
        [{block name="checkout_payment_longdesc"}]
            <p>[{$paymentmethod->oxpayments__oxlongdesc->value}]</p>
        [{/block}]

        <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>

            [{foreach from=$paymentmethod->getDynValues() item=value name=PaymentDynValues}]
                <div class="form-group">
                    <label class="control-label col-lg-3" for="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]">[{$value->name}]</label>
                    <div class="col-lg-9">
                        <input id="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]" type="text" class="form-control textbox" size="20" maxlength="64" name="dynvalue[[{$value->name}]]" value="[{$value->value}]">
                    </div>
                </div>
            [{/foreach}]

        </div>
    </div>
</div>