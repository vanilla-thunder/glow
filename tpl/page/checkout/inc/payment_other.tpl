[{foreach from=$paymentmethod->getDynValues() item=value name=PaymentDynValues}]
   <div class="form-group">
      <label class="control-label col-lg-3" for="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]">[{$value->name}]</label>
      <div class="col-lg-9">
         <input id="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]" type="text" class="form-control textbox" size="20" maxlength="64" name="dynvalue[[{$value->name}]]" value="[{$value->value}]">
      </div>
   </div>
[{/foreach}]
