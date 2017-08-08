[{assign var='oHeidelPaySettings' value=$oHeidelpayViewConfig->getSettings()}]
[{assign var='oHeidelPayment' value=$oHeidelPaySettings->getPayment($paymentmethod)}]
[{assign var='blShowPaymentMethod' value=true}]
[{if $oHeidelPayment instanceof d3_d3heidelpay_models_payment_invoice_secured}]
    [{assign var='blShowPaymentMethod' value=$blD3HeidelpayHasSameAdresses}]
[{/if}]

[{block name="heidelpay_invoice"}]
    [{assign var="iBirthdayMonth" value=0}]
    [{assign var="iBirthdayDay" value=0}]
    [{assign var="iBirthdayYear" value=0}]

    [{if $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
        [{assign var="iBirthdayMonth" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]/":""|regex_replace:"/[-]([0-9]{1,2})$/":""}]
        [{assign var="iBirthdayDay" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]([0-9]{1,2})[-]/":""}]
        [{assign var="iBirthdayYear" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/[-]([0-9]{1,2})[-]([0-9]{1,2})$/":""}]
    [{/if}]
    <div class="radio">
        <label for="payment_[{$sPaymentID}]">
            <input type="radio" [{if false == $blShowPaymentMethod}]disabled[{else}]
                   id="payment_[{$sPaymentID}]" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() === $sPaymentID}]checked[{/if}][{/if}]>
            <b class="h3">[{$paymentmethod->oxpayments__oxdesc->value}]</b>
            [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;(+[{oxprice price=$paymentmethod->getPrice()  currency=$currency }])[{/if}]
        </label>

        <div class="paymentdescription">
            [{if false == $blShowPaymentMethod}]
                <sup class="alert alert-danger">[{oxmultilang ident="D3HEIDELPAY_PAYMENT_NOTSAMEADDRESS_NOTICE"}]</sup>
            [{/if}]

            <div id="payment_details_[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() !== $sPaymentID}]class="collapse"[{/if}]>
            [{block name="checkout_payment_longdesc"}]
                <p>[{$paymentmethod->oxpayments__oxlongdesc->value}]</p>
            [{/block}]

                <div class="form-group oxDate">
                    <label class="req control-label col-sm-3">
                        [{oxmultilang ident="BIRTHDATE"}]
                        [{if $oView->getPaymentError() == 1}]*[{/if}]
                    </label>

                    <div class="col-xs-3 col-sm-2">
                        <input id="oxDay" class="oxDay form-control" name="d3birthdate[[{$sPaymentID}]][day]" type="text" maxlength="2" value="[{if $iBirthdayDay > 0}][{$iBirthdayDay}][{/if}]" placeholder="[{oxmultilang ident="DAY"}]" required>
                    </div>
                    <div class="col-xs-4 col-sm-3">
                        <select class="oxMonth form-control" name="d3birthdate[[{$sPaymentID}]][month]" required>
                            <option value="" label="[{oxmultilang ident="MONTH"}]">[{oxmultilang ident="MONTH"}]</option>
                            [{section name="month" start=1 loop=13}]
                                <option value="[{$smarty.section.month.index}]" label="[{$smarty.section.month.index}]" [{if $iBirthdayMonth == $smarty.section.month.index}] selected="selected" [{/if}]>
                                    [{oxmultilang ident="MONTH_NAME_"|cat:$smarty.section.month.index}]
                                </option>
                            [{/section}]
                        </select>
                    </div>
                    <div class="col-xs-4 col-sm-3 col-md-2">
                        <input id="oxYear" class="oxYear form-control" name="d3birthdate[[{$sPaymentID}]][year]" type="text" maxlength="4" value="[{if $iBirthdayYear}][{$iBirthdayYear}][{/if}]" placeholder="[{oxmultilang ident="YEAR"}]" required>
                    </div>
                </div>
            </div>
        </div>
    </div>
[{/block}]
