[{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
[{block name="user_checkout_registration"}]
    <form class="form-horizontal validate" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post">
        [{block name="user_checkout_registration_form"}]
            <div>
                [{$oViewConf->getHiddenSid()}]
                [{$oViewConf->getNavFormParams()}]
                <input type="hidden" name="cl" value="user">
                <input type="hidden" name="option" value="[{$oView->getLoginOption()}]">
                <input type="hidden" name="fnc" value="changeuser">
                <input type="hidden" name="lgn_cook" value="0">
                <input type="hidden" name="blshowshipaddress" value="1">
            </div>
            [{block name="user_checkout_registration_next_step_top"}]
                [{include file="page/checkout/inc/cart-buttons.tpl" prev=$oViewConf->getBasketLink() }]
            [{/block}]
            <div class="row">

                <div class="col-xs-12"><p class="alert alert-info text-center">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p></div>


                [{* Rechnungsadresse  *}]
                <div class="col-xs-12 col-md-6">
                    [{block name="user_checkout_billing"}]
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                [{block name="user_checkout_billing_head"}]
                                    <h3 class="panel-title">[{oxmultilang ident="BILLING_ADDRESS"}]</h3>
                                [{/block}]
                            </div>
                            <div class="panel-body">
                                [{block name="user_checkout_billing_form"}]
                                    <div id="billingAddressForm">[{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true}]</div>
                                [{/block}]
                                [{block name="user_checkout_billing_feedback"}][{/block}]
                            </div>
                        </div>
                    [{/block}]
                </div>

                [{* Lieferadresse *}]
                <div class="col-xs-12 col-md-6">
                    [{block name="user_checkout_shipping"}]
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                [{block name="user_checkout_shipping_head"}]
                                    <h3 class="panel-title">[{oxmultilang ident="SHIPPING_ADDRESS"}]</h3>
                                [{/block}]
                            </div>
                            <div class="panel-body">
                                [{block name="user_checkout_shipping_change"}]
                                    [{* rechnungsadresse als Lieferadresse *}]
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

                                [{block name="user_checkout_shipping_form"}]
                                    <div id="shippingAddress"
                                         [{if !$oView->showShipAddress()}]style="display:none;"[{/if}]>
                                        [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true onChangeClass='user'}]
                                    </div>
                                [{/block}]

                                [{block name="user_checkout_shipping_feedback"}]
                                    [{if $oViewConf->getViewThemeParam('blShowOrderRemark')}]
                                        [{include file="form/fieldset/order_remark.tpl" blOrderRemark=true}]
                                    [{/if}]
                                [{/block}]
                            </div>
                        </div>
                    [{/block}]
                </div>

                [{* Kontoinformationen *}]
                <div class="col-xs-12 col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">[{oxmultilang ident="ACCOUNT_INFORMATION"}]</h3>
                        </div>
                        <div class="panel-body">
                            [{include file="form/fieldset/user_account.tpl" blSubscribeNews=true}]

                            [{if !isset($oConfig)}]
                                [{assign var="oConfig" value=$oViewConf->getConfig()}]
                            [{/if}]
                            [{if $oView->getLoginOption() != 1 && true == $oConfig->getConfigParam('blOeGdprOptinUserRegistration')}]
                                <div class="form-group [{if $Errors.oegdproptin_userregistration}]has-error[{/if}]">
                                    <div class="col-sm-9 col-sm-offset-3">
                                        <div class="checkbox">
                                            <label for="oegdproptin_userregistration">
                                                *<input type="checkbox" name="oegdproptin_userregistration" id="oegdproptin_userregistration" value="1" required
                                                        data-bv-required="true" data-bv-message="[{oxmultilang ident='OEGDPROPTIN_CONFIRM_USER_REGISTRATION_OPTIN'}]">
                                                <b>[{oxmultilang ident="OEGDPROPTIN_USER_REGISTRATION_OPTIN"}]</b>
                                            </label>
                                        </div>
                                        [{if $Errors.oegdproptin_userregistration}]
                                            [{assign var=oError value=$Errors.oegdproptin_userregistration.0}]
                                            <div class="text-danger">[{$oError->getOxMessage()}]</div>
                                        [{/if}]
                                    </div>
                                </div>
                            [{/if}]
                        </div>
                    </div>
                </div>



            </div>
            [{block name="user_checkout_change_next_step_bottom"}]
                [{include file="page/checkout/inc/cart-buttons.tpl" next="CONTINUE_TO_NEXT_STEP" prev=$oViewConf->getBasketLink() }]
            [{/block}]
        [{/block}]
    </form>
[{/block}]