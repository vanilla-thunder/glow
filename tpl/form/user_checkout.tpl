[{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
[{block name="user_checkout"}]
    <form class="form-horizontal validate" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post">
        [{block name="user_checkout_form"}]
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="user">
            <input type="hidden" name="option" value="[{$oView->getLoginOption()}]">
            [{if !$oxcmp_user}]
                <input type="hidden" name="fnc" value="createuser">
            [{else}]
                <input type="hidden" name="fnc" value="changeuser">
            [{/if}]
            <input type="hidden" name="lgn_cook" value="0">
            <input type="hidden" name="blshowshipaddress" value="1">
            [{block name="user_checkout_steps_top"}]
                [{include file="page/checkout/inc/cart-buttons.tpl" prev=$oViewConf->getBasketLink() }]
            [{/block}]
            <div class="row">
                <div class="col-xs-12">
                    <p class="alert alert-info text-center">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
                </div>

                <div class="col-xs-12 col-md-6">
                    [{* Rechnungsadresse  *}]
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

                <div class="col-xs-12 col-md-6">
                    [{if !$oxcmp_user}]
                        [{* Kontoinformationen *}]
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">[{oxmultilang ident="ACCOUNT_INFORMATION"}]</h3>
                            </div>
                            <div class="panel-body">
                                [{include file="form/fieldset/user_account.tpl" blSubscribeNews=true}]
                            </div>
                        </div>
                    [{/if}]

                    [{* Lieferadresse *}]
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
            </div>
            [{block name="user_checkout_change_next_step_bottom"}]
                [{include file="page/checkout/inc/cart-buttons.tpl" next="CONTINUE_TO_NEXT_STEP" prev=$oViewConf->getBasketLink() }]
            [{/block}]
        [{/block}]
    </form>
[{/block}]