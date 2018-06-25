[{$smarty.block.parent}]
[{if !isset($oConfig)}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]
[{/if}]
[{if $oxcmp_user && true == $oConfig->getConfigParam('blOeGdprOptinDeliveryAddress')}]
    <div class="clearfix"></div>
    <div id="GdprShippingAddressOptin" class="form-group">
        <div class="col-lg-12">
            <div class="checkbox">
                <label class="req">
                    <input type="hidden" class="hidden" id="oegdproptin_changeDelAddress" name="oegdproptin_changeDelAddress" value="0">
                    <input type="checkbox" name="oegdproptin_deliveryaddress" id="oegdproptin_deliveryaddress" value="1">
                    <strong>[{oxmultilang ident="OEGDPROPTIN_STORE_DELIVERY_ADDRESS"}]</strong>
                </label>
            </div>
            <div id="oegdproptin_deliveryaddress_error" style="display:none;" class="text-danger">[{oxmultilang ident="OEGDPROPTIN_CONFIRM_USER_REGISTRATION_OPTIN" }]</div>
        </div>
    </div>
[{/if}]
