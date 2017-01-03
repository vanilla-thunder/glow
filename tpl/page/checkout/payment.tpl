[{capture append="oxidBlock_content"}]
   [{assign var="currency" value=$oView->getActCurrency()}]

   [{* ordering steps *}]
   [{include file="page/checkout/inc/steps.tpl" active=3}]

   [{if $oView->isLowOrderPrice()}]
      <div class="alert alert-warning text-center">
         <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</b>
      </div>
   [{/if}]

   [{block name="checkout_payment_main"}]
      <div class="row">
         <div class="col-md-6">
            [{block name="change_shipping"}]
               [{if $oView->getAllSets()}]
                  [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
                  <form action="[{$oViewConf->getSslSelfLink()}]" name="shipping" id="shipping" method="post">
                     <div class="hidden">
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                        <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                        <input type="hidden" name="fnc" value="changeshipping">
                     </div>

                     <div class="panel panel-default">
                        <div class="panel-heading">
                           <h3 class="panel-title">[{oxmultilang ident="SHIPPING"}]</h3>
                        </div>
                        <div class="panel-body">
                           [{block name="act_shipping"}]
                              <div class="form-group">

                                 [{foreach key=sShipID from=$oView->getAllSets() item=oShippingSet name=ShipSetSelect}]
                                    <div class="checkbox">
                                       <label>
                                          <input type="radio" name="sShipSet" id="sShipSet_[{$sShipID}]" [{if $oShippingSet->blSelected}]checked[{/if}] value="[{$sShipID}]">
                                          [{$oShippingSet->oxdeliveryset__oxtitle->value}]
                                       </label>
                                    </div>
                                    [{block name="checkout_shipset_longdesc"}]
                                       <div>
                                          [{oxifcontent ident="shipset_"|cat:$sPaymentID object="oCont"}]
                                          [{$oCont->oxcontents__oxcontent->value}]
                                          [{/oxifcontent}]
                                       </div>
                                       <hr/>
                                    [{/block}]
                                 [{/foreach}]

                              </div>
                              <noscript>
                                 <div class="form-group">
                                    <button type="submit" class="btn btn-success submitButton largeButton">[{oxmultilang ident="UPDATE_SHIPPING_CARRIER"}]</button>
                                 </div>
                              </noscript>
                           [{/block}]

                           [{assign var="oDeliveryCostPrice" value=$oxcmp_basket->getDeliveryCost()}]
                           [{if $oDeliveryCostPrice && $oDeliveryCostPrice->getPrice() > 0}]
                              [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                                 <div id="shipSetCost">
                                    <b>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getNettoPrice() currency=$currency}]
                                       ([{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oDeliveryCostPrice->getVatValue() currency=$currency}])
                                    </b>
                                 </div>
                              [{else}]
                                 <div id="shipSetCost">
                                    <b>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getBruttoPrice() currency=$currency}]</b>
                                 </div>
                              [{/if}]
                           [{/if}]
                        </div>
                     </div>
                  </form>
               [{/if}]
            [{/block}]
         </div>
         <div class="col-md-6">

            [{block name="checkout_payment_errors"}]
               [{assign var="iPayError" value=$oView->getPaymentError()}]

               [{if $iPayError == 1}]
                  <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_COMPLETE_FIELDS_CORRECTLY"}]</div>
               [{elseif $iPayError == 2}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
               [{elseif $iPayError == 4}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_UNAVAILABLE_SHIPPING_METHOD"}]</div>
               [{elseif $iPayError == 5}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
               [{elseif $iPayError == 6}]
                  <div class="alert alert-danger">[{oxmultilang ident="TRUSTED_SHOP_UNAVAILABLE_PROTECTION"}]</div>
               [{elseif $iPayError > 6}]
                  <!--Add custom error message here-->
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
               [{elseif $iPayError == -1}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT_ERROR"}] "[{$oView->getPaymentErrorText()}]").</div>
               [{elseif $iPayError == -2}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_NO_SHIPPING_METHOD_FOUND"}]</div>
               [{elseif $iPayError == -3}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_SELECT_ANOTHER_PAYMENT"}]</div>
               [{elseif $iPayError == -4}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_BANK_CODE_INVALID"}]</div>
               [{elseif $iPayError == -5}]
                  <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_ACCOUNT_NUMBER_INVALID"}]</div>
               [{/if}]
            [{/block}]

            [{block name="change_payment"}]

               [{if $oView->getPaymentList()}]
                  <div class="panel panel-default">
                     <div class="panel-heading">
                        <h3 id="paymentHeader" class="panel-title">[{oxmultilang ident="PAYMENT_METHOD"}]</h3>
                     </div>
                     <div class="panel-body">

                        <div class="panel-group" id="paymentaccordion" role="tablist" aria-multiselectable="true">
                           [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                              <div class="panel panel-default">
                                 <div class="panel-heading" role="tab" id="heading_[{$sPaymentID}]" role="button" href="#payment_[{$sPaymentID}]"
                                      data-toggle="collapse" data-parent="#paymentaccordion" aria-expanded="true" aria-controls="payment_[{$sPaymentID}]">
                                    <h4 class="panel-title">[{$paymentmethod->oxpayments__oxdesc->value}]
                                       [{if $paymentmethod->oxpayments__oxaddsum->value}]&nbsp;([{oxprice price=$paymentmethod->getPrice()  currency=$currency }])[{/if}]
                                    </h4>
                                    <small>[{$paymentmethod->oxpayments__oxlongdesc->value}]</small>
                                 </div>
                                 <div id="payment_[{$sPaymentID}]" class="panel-collapse collapse [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]in[{/if}]" role="tabpanel" aria-labelledby="heading_[{$sPaymentID}]">
                                    <div class="panel-body">

                                       [{if $paymentmethod->getPrice() && $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge')}]
                                          [{assign var="oPaymentPrice" value=$paymentmethod->getPrice()}]
                                          [{oxprice price=$oPaymentPrice->getNettoPrice() currency=$currency}]
                                          [{if $oPaymentPrice->getVatValue() > 0}]
                                             [{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oPaymentPrice->getVatValue() currency=$currency}]
                                          [{/if}]
                                       [{/if}]

                                       <form action="[{$oViewConf->getSslSelfLink()}]" class="form-horizontal validate payment" id="payment" name="order" method="post">
                                          <div class="hidden">
                                             [{$oViewConf->getHiddenSid()}]
                                             [{$oViewConf->getNavFormParams()}]
                                             <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                                             <input type="hidden" name="fnc" value="validatepayment">
                                          </div>

                                          [{block name="select_payment"}]
                                             [{if $sPaymentID == "oxidcreditcard"}]
                                                [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                             [{elseif $sPaymentID == "oxiddebitnote"}]
                                                [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                             [{else}]
                                                [{include file="page/checkout/inc/payment_other.tpl"}]
                                             [{/if}]
                                          [{/block}]

                                          [{block name="checkout_payment_longdesc"}]
                                             <div>
                                                [{oxifcontent ident="payment_"|cat:$sPaymentID object="oCont"}]
                                                [{$oCont->oxcontents__oxcontent->value}]
                                                [{/oxifcontent}]
                                             </div>
                                             <hr/>
                                          [{/block}]

                                          [{if !$oView->isLowOrderPrice()}]
                                             <button type="submit" name="paymentid" value="[{$sPaymentID}]" class="btn btn-success pull-right btn-lg">
                                                [{oxmultilang ident="GLOW_PAY_WITH" args=$paymentmethod->oxpayments__oxdesc->value }] <i class="fa fa-caret-right"></i>
                                             </button>
                                          [{/if}]
                                       </form>
                                    </div>
                                 </div>
                              </div>
                           [{/foreach}]
                        </div>
                     </div>
                  </div>
                  [{block name="checkout_payment_nextstep"}][{/block}]
               [{elseif $oView->getEmptyPayment()}]
                  [{block name="checkout_payment_nopaymentsfound"}]
                     <div class="lineBlock"></div>
                     <h3 id="paymentHeader" class="blockHead">[{oxmultilang ident="PAYMENT_INFORMATION"}]</h3>
                     [{oxifcontent ident="oxnopaymentmethod" object="oCont"}]
                     [{$oCont->oxcontents__oxcontent->value}]
                     [{/oxifcontent}]
                     <form action="[{$oViewConf->getSslSelfLink()}]" class="form-horizontal validate payment" id="payment" name="order" method="post">
                        <div class="hidden">
                           [{$oViewConf->getHiddenSid()}]
                           [{$oViewConf->getNavFormParams()}]
                           <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                           <input type="hidden" name="fnc" value="validatepayment">
                        </div>
                        <input type="hidden" name="paymentid" value="oxempty">
                        <div class="lineBox clear">
                           <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]" class="btn btn-default pull-left prevStep submitButton largeButton">
                              <i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
                           <button type="submit" name="userform" class="btn btn-primary pull-right submitButton nextStep largeButton" id="paymentNextStepBottom">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]
                              <i class="fa fa-caret-right"></i></button>
                        </div>
                     </form>
                  [{/block}]
               [{/if}]
            [{/block}]

         </div>
      </div>
   [{/block}]
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl"}]