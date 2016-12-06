[{if $oView->isFieldRequired($_field)}][{assign var="_req" value="required"}][{/if}]
[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if isset($prefix) && $prefix }]
   [{assign var="inputname" value=$prefix|cat:'['|cat:$_field|cat:']'}]
[{else}]
   [{assign var="inputname" value=$_field}]
[{/if}]

<div class="form-group [{if $aErrors.$_field}]text-danger[{/if}]">
   <label for="[{$prefix}]_[{$_field}]" class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>
   <div class="col-sm-8">
      <textarea id="[{$prefix}]_[{$_field}]" rows="7" name="[{$name|default:$inputname}]" class="form-control"
                placeholder="[{oxmultilang ident=$_olaceholder|default:"HERE_YOU_CAN_ENETER_MESSAGE"}]">[{if $value !== NULL}][{$value}][{/if}]</textarea>
   </div>
</div>