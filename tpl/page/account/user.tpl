[{capture append="oxidBlock_content"}]
   [{block name="account_user_form"}]
      <form class="form-horizontal" action="[{$oViewConf->getSelfActionLink()}]" name="order" method="post">
         <div class="hidden">
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="fnc" value="changeuser_testvalues">
            <input type="hidden" name="cl" value="account_user">
            <input type="hidden" name="CustomError" value='user'>
            <input type="hidden" name="blshowshipaddress" value="1">
         </div>

         [{block name="user_form"}]
            [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
            <div class="row">

               [{* Rechnungsadresse *}]
               <div class="col-xs-12">
                  [{block name="user_billing_address"}]
                     <div class="panel panel-default">
                        <div class="panel-heading">
                           [{block name="user_billing_address_head"}]
                              <h3 class="panel-title">[{oxmultilang ident="BILLING_ADDRESS"}]</h3>
                           [{/block}]
                        </div>
                        <div class="panel-body">
                           [{block name="user_billing_address_form"}]
                              <div id="billingAddressForm">
                                 [{if $oViewConf->getViewThemeParam("blAllowEmailChange")}]
                                    [{* include file="form/fieldset/user_email.tpl" *}]
                                    [{include file="form/inc/input.tpl" _label="EMAIL_ADDRESS" _field="oxuser__oxusername" _type="email" value=$oView->getActiveUsername() _req="required"}]
                                 [{/if}]
                                 [{include file="form/fieldset/user_billing.tpl" noFormSubmit=true}]
                              </div>
                           [{/block}]
                        </div>
                     </div>
                  [{/block}]
               </div>

               [{* Lieferadresse *}]
               <div class="col-xs-12">
                  [{block name="user_shipping_address"}]
                     <div class="panel panel-default">
                        <div class="panel-heading">
                           [{block name="user_shipping_address_head"}]
                              <h3 class="panel-title">[{oxmultilang ident="SHIPPING_ADDRESSES"}]</h3>
                           [{/block}]
                        </div>
                        <div class="panel-body">
                           [{* rechnungsadresse als Lieferadresse *}]
                           [{block name="user_shipping_change"}]
                              <div class="form-group">
                                 <div class="col-sm-9 col-sm-offset-3">
                                    <div class="checkbox">
                                       <label for="blshowshipaddress" id="blshowshipaddresslabel">
                                          <input type="checkbox" name="blshowshipaddress" id="blshowshipaddress" value="0" autocomplete="off" [{if !$oView->showShipAddress()}]checked[{/if}]>
                                          [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]
                                       </label>
                                    </div>
                                 </div>
                              </div>
                           [{/block}]

                           [{block name="user_shipping_address_form"}]
                              <div id="shippingAddress" [{if !$oView->showShipAddress()}] style="display: none;" [{/if}]>
                                 [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true}]
                              </div>
                           [{/block}]
                        </div>
                     </div>
                  [{/block}]
               </div>
            </div>
            [{block name="account_user_next_step_bottom"}]
               [{include file="page/checkout/inc/cart-buttons.tpl" next="SAVE" }]
            [{/block}]
         [{/block}]
      </form>
   [{/block}]
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]
[{capture append="oxidBlock_sidebar"}]
   [{include file="page/account/inc/account_menu.tpl" active_link="billship"}]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left"}]