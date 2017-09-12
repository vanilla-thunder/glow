[{capture append="oxidBlock_content"}]
   [{assign var="currency" value=$oView->getActCurrency()}]

   [{* ordering steps *}]
   [{include file="page/checkout/inc/steps.tpl" active=3}]

   [{if $oView->isLowOrderPrice()}]
      <div class="alert alert-danger text-center">
         <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</b>
      </div>
   [{/if}]

   [{block name="checkout_payment_main"}]
      <div class="row">

         <div class="col-md-4">
            [{block name="change_shipping"}]
               [{if $oView->getAllSets()}]
                  <!-- save shipsets count to cookie for final step [{'shipsetscount'|setcookie:$oView->getAllSetsCnt()}] -->

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
                                       [{oxifcontent ident="shipset_"|cat:$sPaymentID object="oCont"}]
                                          <div>[{$oCont->oxcontents__oxcontent->value}]</div>
                                       [{/oxifcontent}]
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
                              <hr/>
                              <div id="shipSetCost" class="h4">
                                 <b>[{oxmultilang ident="CHARGES" suffix="COLON"}]
                                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                                       [{oxprice price=$oDeliveryCostPrice->getNettoPrice() currency=$currency}] ([{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oDeliveryCostPrice->getVatValue() currency=$currency}])
                                    [{else}]
                                       [{oxprice price=$oDeliveryCostPrice->getBruttoPrice() currency=$currency}]
                                    [{/if}]
                                 </b>
                              </div>
                           [{/if}]
                        </div>
                     </div>
                  </form>
               [{/if}]
            [{/block}]
         </div>


         <div class="col-md-8">
            <form action="[{$oViewConf->getSslSelfLink()}]" class="form-horizontal validate payment" id="payment" name="order" method="post">
               <div class="hidden">
                  [{$oViewConf->getHiddenSid()}]
                  [{$oViewConf->getNavFormParams()}]
                  <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                  <input type="hidden" name="fnc" value="validatepayment">
               </div>

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
                  [{elseif $iPayError >= 6}]
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
                  <!-- save payment methods count to cookie for final step [{'paymentscount'|setcookie:$oView->getPaymentCnt()}] -->
                  <div class="panel panel-default">
                     <div class="panel-heading">
                        <h3 id="paymentHeader" class="panel-title">[{oxmultilang ident="PAYMENT_METHOD"}] :: [{$oView->getCheckedPaymentId()}]</h3>
                     </div>
                     <div class="panel-body">
                        [{if $oView->getPaymentList()}]

                           [{if $oViewConf->getViewThemeParam('blPPPstyledPayment')}]

                           [{else}]
                              [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                                 [{block name="select_payment"}]
                                    [{if $sPaymentID == "oxidcreditcard"}]
                                       [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                    [{elseif $sPaymentID == "oxiddebitnote"}]
                                       [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                    [{else}]
                                       [{include file="page/checkout/inc/payment_other.tpl"}]
                                    [{/if}]
                                 [{/block}]
                                 [{if !$smarty.foreach.PaymentSelect.last}]
                                    <hr/>
                                 [{/if}]
                              [{/foreach}]
                           [{/if}]


                        [{elseif $oView->getEmptyPayment()}]
                           <input type="hidden" name="paymentid" value="oxempty">
                           [{block name="checkout_payment_nopaymentsfound"}]
                              [{oxcontent ident="oxnopaymentmethod"}]
                           [{/block}]
                        [{/if}]
                     </div>
                  </div>
               [{/block}]

               [{block name="checkout_payment_nextstep"}]
                  [{if !$oView->isLowOrderPrice()}]
                     <button type="submit" id="paymentNextStepBottom" class="btn btn-success pull-right btn-lg">
                        [{oxmultilang ident="CONTINUE_TO_NEXT_STEP" }] <i class="fa fa-caret-right"></i>
                     </button>
                  [{/if}]
               [{/block}]
            </form>
         </div>
      </div>
   [{/block}]
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]
[{if $smarty.get.ajax=="1"}]
   [{include file="layout/popup.tpl"}]
[{else}]
   [{include file="layout/page.tpl"}]
[{/if}]
