[{if $oView->isFieldRequired($field)}][{assign var="_req" value="required"}][{/if}]
[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if $prefix == "invadr"}]
   [{assign var="adr" value=$invadr}]
   [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "deladr"}]
   [{assign var="adr" value=$aDeliveryAddress}]
   [{assign var="fallback" value=$oAddress}]
[{/if}]

<div class="form-group [{if $aErrors.$field}]text-danger[{/if}]">
   <label class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$label}]</label>
   <div class="col-sm-8">
      <input type="[{$type|default:'text'}]" maxlength="64" name="[{$prefix}][[{$field}]]" id="[{$prefix}]_[{$field}]" class="form-control"
             value="[{if $value}][{$value}][{elseif $adr && isset($adr.$field)}][{$adr.$field}][{elseif $fallback && isset($fallback->$field) }][{$fallback->$field->value }][{/if}]" [{$_req}]>
      [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$field}]
      <div class="help-block"></div>
   </div>
</div>