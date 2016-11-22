[{if $oxcmp_user}]
   [{assign var="oAddress" value=$oxcmp_user->getSelectedAddress()}] [{* das ist die aktuell gültige Lieferadresse *}]
   <input type="hidden" class="hidden" name="changeClass" value="[{$onChangeClass|default:'account_user'}]">
   [{* Lieferadressen des Benutzers *}]
   [{assign var="aUserAddresses" value=$oxcmp_user->getUserAddresses()}]
   <div class="row">
   [{if $aUserAddresses|@count > 0}]
      [{oxscript add="var aShipAddr = {};"}]
      [{block name="form_user_shipping_address_select"}]
         [{foreach from=$aUserAddresses item=address}]
            <div class="col-xs-12 col-sm-6">
               <input type="radio" id="oxaddress_[{$address->oxaddress__oxid->value}]" class="hidden" autocomplete="off"
                      name="oxaddressid" value="[{$address->oxaddress__oxid->value}]" [{if $address->isSelected()}]checked[{/if}]>
               <label class="btn btn-label btn-block" for="oxaddress_[{$address->oxaddress__oxid->value}]">
                  [{include file="widget/address/shipping_address.tpl" delivadr=$address}]
               </label>
            </div>
         [{/foreach}]
      [{/block}]
   [{/if}]
   </div>
   <p></p>
      [{* neue Adresse *}]
      <input type="radio" id="oxaddress_new" class="hidden" name="oxaddressid" value="-1" autocomplete="off">
      <label class="btn btn-label btn-block" for="oxaddress_new">
         [{oxmultilang ident="DD_USER_SHIPPING_ADD_DELIVERY_ADDRESS"}]
      </label>
   <p></p>
[{/if}]

[{assign var="prefix" value="deladr"}]
[{assign var="aDeliveryAddress" value=$oView->getDeliveryAddress()}]

<div id="shippingAddressForm" [{if $oAddress}]style="display:none;"[{/if}]>
   [{include file="form/inc/input.tpl" label="COMPANY" field="oxaddress__oxcompany" type="text"}]

   [{include file="form/inc/select.tpl" label="TITLE" field="oxaddress__oxsal" options="MRS|MR"}]

   [{include file="form/inc/input.tpl" label="FIRST_NAME" field="oxaddress__oxfname" type="text"}]

   [{include file="form/inc/input.tpl" label="LAST_NAME" field="oxaddress__oxlname" type="text"}]

   [{include file="form/inc/inputgroup.tpl" label="STREET_AND_STREETNO" fields="oxaddress__oxstreet|oxaddress__oxstreetnr" xs="8|4" sm="5|3" type="text"}]

   [{include file="form/inc/input.tpl" label="ADDITIONAL_INFO" field="oxaddress__oxaddinfo" type="text"}]

   [{include file="form/inc/inputgroup.tpl" label="POSTAL_CODE_AND_CITY" fields="oxaddress__oxzip|oxaddress__oxcity" xs="4|8" sm="3|5" type="text"}]

   [{block name="form_user_shipping_country"}]
      [{include file="form/inc/select.tpl" label="COUNTRY" field="oxaddress__oxcountryid" options=$oViewConf->getCountryList() }]
   [{/block}]

   [{include file="form/inc/input.tpl" label="PHONE" field="oxaddress__oxfon" type="text"}]

   [{include file="form/inc/input.tpl" label="FAX" field="oxaddress__oxfax" type="text"}]
</div>

[{if !$noFormSubmit}]
   <div class="form-group">
      <div class="col-lg-offset-3 col-lg-9 col-xs-12">
         <p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
         <button id="accUserSaveBottom" type="submit" class="submitButton" name="save">[{oxmultilang ident="SAVE"}]</button>
      </div>
   </div>
[{/if}]