[{if $oView->isFieldRequired($_field)}][{assign var="_req" value="required"}][{/if}]
[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if !isset($prefix) || !$prefix }]
   [{assign var="inputname" value=$_field}]
   [{assign var="adr" value=$invadr}]
   [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "invadr"}]
   [{assign var="inputname" value='invadr['|cat:$_field|cat:']'}]
   [{assign var="adr" value=$invadr}]
   [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "deladr"}]
   [{assign var="inputname" value='deladr['|cat:$_field|cat:']'}]
   [{assign var="adr" value=$aDeliveryAddress}]
   [{assign var="fallback" value=$oAddress}]
[{/if}]

<div class="form-group [{if $aErrors.$_field}]text-danger[{/if}]">
   <label class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>
   <div class="col-sm-8">
      <input type="[{$_type|default:'text'}]" maxlength="64" name="[{$name|default:$inputname}]" id="[{$prefix}]_[{$_field}]" class="form-control"
             value="[{if $value !== NULL}][{$value}][{elseif $adr && isset($adr.$_field)}][{$adr.$_field}][{elseif $fallback && isset($fallback->$_field) }][{$fallback->$_field->value }][{/if}]" [{$_req}]>
      [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$_field}]
      <div class="help-block"></div>
   </div>
</div>