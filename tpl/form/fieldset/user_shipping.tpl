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
   [{include file="form/inc/input.tpl" _label="COMPANY" _field="oxaddress__oxcompany" _type="text"}]

   [{include file="form/inc/select.tpl" _label="TITLE" _field="oxaddress__oxsal" _options="MRS|MR"}]

   [{include file="form/inc/input.tpl" _label="FIRST_NAME" _field="oxaddress__oxfname" _type="text"}]

   [{include file="form/inc/input.tpl" _label="LAST_NAME" _field="oxaddress__oxlname" _type="text"}]

   [{include file="form/inc/inputgroup.tpl" _label="STREET_AND_STREETNO" _fields="oxaddress__oxstreet|oxaddress__oxstreetnr" xs="8|4" sm="5|3" _type="text"}]

   [{include file="form/inc/input.tpl" _label="ADDITIONAL_INFO" _field="oxaddress__oxaddinfo" _type="text"}]

   [{include file="form/inc/inputgroup.tpl" _label="POSTAL_CODE_AND_CITY" _fields="oxaddress__oxzip|oxaddress__oxcity" xs="4|8" sm="3|5" _type="text"}]

   [{block name="form_user_shipping_country"}]
      [{include file="form/inc/select.tpl" _label="COUNTRY" _field="oxaddress__oxcountryid" _options=$oViewConf->getCountryList() }]
   [{/block}]

   [{include file="form/inc/input.tpl" _label="PHONE" _field="oxaddress__oxfon" _type="text"}]

   [{include file="form/inc/input.tpl" _label="FAX" _field="oxaddress__oxfax" _type="text"}]
</div>

[{if !$noFormSubmit}]
   <div class="form-group">
      <div class="col-lg-offset-3 col-lg-9 col-xs-12">
         <p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
         <button id="accUserSaveBottom" type="submit" class="submitButton" name="save">[{oxmultilang ident="SAVE"}]</button>
      </div>
   </div>
[{/if}]