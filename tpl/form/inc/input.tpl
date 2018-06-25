[{if $_req !== false && $oView->isFieldRequired($_field)}][{assign var="_req" value="required"}][{/if}]
[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if $prefix == "invadr"}]
    [{assign var="inputname" value='invadr['|cat:$_field|cat:']'}]
    [{assign var="adr" value=$invadr}]
    [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "deladr"}]
    [{assign var="inputname" value='deladr['|cat:$_field|cat:']'}]
    [{assign var="adr" value=$aDeliveryAddress}]
    [{assign var="fallback" value=$oAddress}]
[{elseif isset($prefix) && $prefix }]
    [{assign var="inputname" value=$prefix|cat:'['|cat:$_field|cat:']'}]
    [{assign var="adr" value=$invadr}]
    [{assign var="fallback" value=$oxcmp_user}]
[{else}]
    [{assign var="inputname" value=$_field}]
[{/if}]

<div class="form-group [{if $aErrors.$_field}]text-danger[{/if}]">
    [{if $_label}]<label for="[{$prefix}]_[{$_field}]" class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>[{/if}]
    <div class="[{if $_label}]col-sm-8[{/if}]">
        <input type="[{$_type|default:'text'}]" name="[{$name|default:$inputname}]" id="[{$prefix}]_[{$_field}]" class="form-control" maxlength="64" [{$_req}]
                [{if $_placeholder}]placeholder="[{$_placeholder|oxmultilangassign}][{if $_req}]*[{/if}]"[{/if}]
               value="[{if $value !== NULL}][{$value}][{elseif $adr && isset($adr.$_field)}][{$adr.$_field}][{elseif $fallback && isset($fallback->$_field) }][{$fallback->$_field->value }][{/if}]">
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$_field}]
        <div class="help-block"></div>
    </div>
</div>