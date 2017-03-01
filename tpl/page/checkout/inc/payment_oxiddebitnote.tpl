[{assign var="dynvalue" value=$oView->getDynValue()}]
<div class="form-group">
   <label class="req control-label col-lg-3">[{oxmultilang ident="BANK"}]</label>
   <div class="col-lg-9">
      <input id="payment_[{$sPaymentID}]_1" class="form-control js-oxValidate js-oxValidate_notEmpty" type="text" size="20" maxlength="64" name="dynvalue[lsbankname]" value="[{$dynvalue.lsbankname}]" required="required">
   </div>
</div>
<div class="form-group">
   <label class="req control-label col-lg-3">[{oxmultilang ident="BANK_CODE"}]</label>
   <div class="col-lg-9">
      <input type="text" class="form-control js-oxValidate js-oxValidate_notEmpty" size="20" maxlength="64" name="dynvalue[lsblz]" value="[{$dynvalue.lsblz}]" required="required">
   </div>
</div>
<div class="form-group">
   <label class="req control-label col-lg-3">[{oxmultilang ident="IBAN"}]</label>
   <div class="col-lg-9">
      <input type="text" class="form-control" size="20" maxlength="64" name="dynvalue[lsktonr]" value="[{$dynvalue.lsktonr}]" required="required">
   </div>
</div>
<div class="form-group">
   <label class="req control-label col-lg-3">[{oxmultilang ident="BANK_ACCOUNT_HOLDER"}]</label>
   <div class="col-lg-9">
      <input type="text" class="form-control" size="20" maxlength="64" name="dynvalue[lsktoinhaber]" value="[{if $dynvalue.lsktoinhaber}][{$dynvalue.lsktoinhaber}][{else}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]" required="required">
   </div>
</div>

[{block name="checkout_payment_longdesc"}]
  <div>
    [{oxifcontent ident="payment_"|cat:$sPaymentID object="oCont"}]
      [{$oCont->oxcontents__oxcontent->value}]
    [{/oxifcontent}]
  </div>
  <hr/>
[{/block}]