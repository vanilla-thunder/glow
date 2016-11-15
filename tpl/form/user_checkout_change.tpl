[{block name="user_checkout_change"}]
   [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
   <form class="form-horizontal" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post" novalidate="novalidate">
      [{block name="user_checkout_change_form"}]
         [{$oViewConf->getHiddenSid()}]
         [{$oViewConf->getNavFormParams()}]
         <input type="hidden" name="cl" value="user">
         <input type="hidden" name="option" value="[{$oView->getLoginOption()}]">
         <input type="hidden" name="fnc" value="changeuser">
         <input type="hidden" name="lgn_cook" value="0">
         <input type="hidden" name="blshowshipaddress" value="1">
         [{block name="user_checkout_change_next_step_top"}]
            <div class="well well-sm cart-buttons">
               <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]" class="btn btn-default pull-left prevStep submitButton largeButton" id="userBackStepTop">
                  <i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
               <button id="userNextStepTop" class="btn btn-primary pull-right submitButton largeButton nextStep" name="userform" type="submit">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]
                  <i class="fa fa-caret-right"></i></button>
               <div class="clearfix"></div>
            </div>
         [{/block}]
         <div class="row">
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  [{block name="user_checkout_billing"}]
                     <div class="panel-heading">[{block name="user_checkout_billing_head"}]<h3 class="panel-title">[{oxmultilang ident="BILLING_ADDRESS"}]</h3>[{/block}]</div>
                  [{/block}]
                  <div class="panel-body">
                     [{block name="user_checkout_billing_form"}]
                        <div id="billingAddressForm">[{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true}]</div>
                     [{/block}]

                     [{include file="form/fieldset/order_newsletter.tpl" blSubscribeNews=true}]
                     [{block name="user_checkout_billing_feedback"}][{/block}]
                  </div>
               </div>
            </div>
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  [{block name="user_checkout_shipping"}]
                     <div class="panel-heading">[{block name="user_checkout_shipping_head"}]<h3 class="panel-title">[{oxmultilang ident="SHIPPING_ADDRESS"}]</h3>[{/block}]</div>
                  [{/block}]
                  <div class="panel-body">
                        [{block name="user_checkout_shipping_change"}]
                           <div data-toggle="buttons">
                              #[{$oView->showShipAddress()}]#
                              [{* rechnungsadresse als Lieferadresse *}]
                              <label class="btn btn-default btn-block [{if !$oView->showShipAddress()}] active[{/if}]">
                                 <input type="checkbox" name="blshowshipaddress" id="blshowshipaddress" value="0" class="hidden" autocomplete="off" [{if !$oView->showShipAddress()}]checked[{/if}]>
                                 <input type="radio" name="oxaddressid" value="-1" class="hidden" autocomplete="off" [{if !$oView->showShipAddress()}]checked[{/if}]>
                                 [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]
                              </label>

                              [{if $oxcmp_user}]

                                 [{* Lieferadressen des Benutzers *}]
                                 [{assign var="aUserAddresses" value=$oxcmp_user->getUserAddresses()}]
                                 [{if $aUserAddresses|@count > 0}]

                                    [{block name="form_user_shipping_address_select"}]
                                       [{foreach from=$aUserAddresses item=address}]
                                          <label class="btn btn-default btn-block[{if $address->isSelected()}] active[{/if}]">
                                             <input type="radio" name="oxaddressid" value="[{$address->oxaddress__oxid->value}]" class="hidden" autocomplete="off" [{if $address->isSelected()}]checked[{/if}]>
                                             [{ $address }]
                                          </label>
                                          [{*
                                                      <div id="address_[{$address->oxaddress__oxid->value}]" class="">
                                                         [{include file="widget/address/shipping_address.tpl" delivadr=$address}]
                                                      </div> *}]
                                       [{/foreach}]
                                    [{/block}]
                                 [{/if}]

                                 [{* neue Adresse *}]
                                 <label class="btn btn-default btn-block ">
                                    <input type="radio" name="oxaddressid" value="[{$address->oxaddress__oxid->value}]" class="hidden" autocomplete="off" [{if $address->isSelected()}]checked[{/if}]>
                                    [{ $address }]
                                 </label>
                                 <label for="new_billingaddress">[{oxmultilang ident="DD_USER_SHIPPING_ADD_DELIVERY_ADDRESS"}]</label>
                                 <input type="radio" name="oxaddressid" id="new_billingaddress" value="-1">
                                 <div id="shippingAddress">
                                 </div>
                              [{/if}]
                           </div>
                        [{/block}]

                        [{block name="user_checkout_shipping_form"}]
                           <div id="shippingAddressForm" [{if $delivadr}]style="display: none;"[{/if}]>
                              [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true onChangeClass='user'}]
                           </div>
                        [{/block}]

                        [{block name="user_checkout_shipping_feedback"}]
                           [{include file="form/fieldset/order_remark.tpl" blOrderRemark=true}]
                        [{/block}]
                  </div>
               </div>
            </div>
         </div>
         [{block name="user_checkout_change_next_step_bottom"}]
            <div class="well well-sm cart-buttons">
               <button id="userNextStepBottom" class="btn btn-primary pull-right submitButton largeButton nextStep" name="userform" type="submit">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]
                  <i class="fa fa-caret-right"></i>
               </button>
               <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]" class="btn btn-default pull-left prevStep submitButton largeButton" id="userBackStepBottom">
                  <i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]
               </a>
               <div class="clearfix"></div>
            </div>
         [{/block}]
      [{/block}]
   </form>
[{/block}]