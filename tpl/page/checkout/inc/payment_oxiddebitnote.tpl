<div class="radio">
    <!-- <div class="pull-right">
        <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/paymenticons/'|cat:$sPaymentID|cat:'.png'}]" alt="[{$paymentmethod->oxpayments__oxdesc->value}]">
    </div> -->

    <label for="payent_[{$sPaymentID}]">
        <input type="radio" name="paymentid" id="payent_[{$sPaymentID}]" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $sPaymentID}]checked[{/if}]>
        <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
        [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice() currency=$currency }])[{/if}]
    </label>

    <div class="paymentdescription">
        [{block name="checkout_payment_longdesc"}]
            <p>[{$paymentmethod->oxpayments__oxlongdesc->value}]</p>
        [{/block}]

        <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>
            [{assign var="dynvalue" value=$oView->getDynValue()}]
            <div class="form-group">
                <label class="req control-label col-lg-3">[{oxmultilang ident="BANK"}]</label>
                <div class="col-lg-9">
                    <input id="payment_[{$sPaymentID}]_1" class="form-control js-oxValidate js-oxValidate_notEmpty" type="text" size="20" maxlength="64" name="dynvalue[lsbankname]" value="[{$dynvalue.lsbankname}]" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="req control-label col-lg-3">[{oxmultilang ident="BANK_CODE"}]</label>
                <div class="col-lg-9">
                    <input type="text" class="form-control js-oxValidate js-oxValidate_notEmpty" size="20" maxlength="64" name="dynvalue[lsblz]" value="[{$dynvalue.lsblz}]" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="req control-label col-lg-3">[{oxmultilang ident="IBAN"}]</label>
                <div class="col-lg-9">
                    <input type="text" class="form-control" size="20" maxlength="64" name="dynvalue[lsktonr]" value="[{$dynvalue.lsktonr}]" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="req control-label col-lg-3">[{oxmultilang ident="BANK_ACCOUNT_HOLDER"}]</label>
                <div class="col-lg-9">
                    <input type="text" class="form-control" size="20" maxlength="64" name="dynvalue[lsktoinhaber]" value="[{if $dynvalue.lsktoinhaber}][{$dynvalue.lsktoinhaber}][{else}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]" required="required">
                </div>
            </div>
        </div>
    </div>
</div>