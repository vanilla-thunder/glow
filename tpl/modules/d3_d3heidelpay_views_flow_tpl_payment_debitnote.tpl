[{assign var="dynvalue" value=$oView->getDynValue()}]
[{assign var="iPayError" value=$oView->getPaymentError()}]
[{assign var="sImageUrl" value=$oViewConf->getModuleUrl('d3heidelpay','out/img/')}]
[{assign var='oHeidelPaySettings' value=$oHeidelpayViewConfig->getSettings()}]
[{assign var='oHeidelPayment' value=$oHeidelPaySettings->getPayment($paymentmethod)}]
[{assign var="aBrands" value=$oHeidelpayViewConfig->getHeidelpayNgwBrands($paymentmethod, $oHeidelPayment, $oxcmp_user)}]
[{assign var="sBrandIdentELV" value='ELV'}]
[{assign var="sFullImageUrl" value=$sImageUrl|cat:'logo_elv.jpg'}]
[{assign var='blShowPaymentMethod' value=true}]
[{if $oHeidelPayment instanceof d3_d3heidelpay_models_payment_directdebit_secured}]
    [{assign var='blShowPaymentMethod' value=$blD3HeidelpayHasSameAdresses}]
[{/if}]

[{block name="heidelpay_debitnote"}]
    <div class="radio">
        <div class="pull-right">
            [{include file="d3_d3heidelpay_views_tpl_payment_img.tpl" sImageUrl=$sFullImageUrl sBrandIdent=$sBrandIdentELV}]
        </div>
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

                <div class="form-group">
                    <label class="req control-label col-sm-3" for="sCountrySelected_[{$sPaymentID}]">[{oxmultilang ident="D3HEIDELPAY_CC_INPUT_COUNTRY"}]</label>
                    <div class="col-sm-8">
                        <select name="dynvalue[lsland]" class="form-control" id="sCountrySelected_[{$sPaymentID}]" data-fv-notempty="true" required>
                            <option value="">[{oxmultilang ident="D3PAYMENT_EXT_SELECTPLEASE"}]</option>
                            [{foreach from=$aBrands item='sBrandName' key='sBrandIdent'}]
                                <option value="[{$sBrandIdent}]">[{$sBrandName}]</option>
                            [{/foreach}]
                        </select>
                        [{if !empty($dynvalue.lsland)}]
                            [{oxscript add="$('#sCountrySelected_$sPaymentID').val('`$dynvalue.lsland`').trigger('change');"}]
                        [{/if}]
                    </div>
                </div>

                [{* braucht man nicht mehr
                <div class="form-group" id="sBIC_[{$sPaymentID}]">
                    <label class="req control-label col-sm-3" for="sCountrySelected_[{$sPaymentID}]lsblz">[{oxmultilang ident="D3HEIDELPAY_PAYMENT_INPUT_BANK_BIC"}]</label>
                    <div class="col-sm-8">
                        <input type="text" name="dynvalue[lsblz]" id="sCountrySelected_[{$sPaymentID}]lsblz" class="form-control"
                               value="[{$dynvalue.lsblz}]" autocomplete="off" data-fv-notempty="true" required>
                    </div>
                </div> *}]

                <div class="form-group">
                    <label class="req control-label col-sm-3" for="sCountrySelected_[{$sPaymentID}]lsktonr">[{oxmultilang ident="D3HEIDELPAY_PAYMENT_INPUT_BANK_IBAN"}]</label>
                    <div class="col-sm-8">
                        <input type="text" name="dynvalue[lsktonr]" id="sCountrySelected_[{$sPaymentID}]lsktonr" class="form-control"
                               value="[{$dynvalue.lsktonr}]" autocomplete="off" data-fv-notempty="true" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="req control-label col-sm-3" for="sCountrySelected_[{$sPaymentID}]lsktoinhaber">[{oxmultilang ident="D3HEIDELPAY_PAYMENT_INPUT_BANK_ACCOUNTHOLDER"}]</label>
                    <div class="col-sm-8">
                        <input type="text" name="dynvalue[lsktoinhaber]" id="sCountrySelected_[{$sPaymentID}]lsktoinhaber" class="form-control" data-fv-notempty="true" required
                               value="[{if $dynvalue.lsktoinhaber}][{$dynvalue.lsktoinhaber}][{else}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]">
                    </div>
                </div>
            </div>
        </div>
    </div>
[{/block}]
