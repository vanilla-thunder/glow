[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if $prefix == "invadr"}]
   [{assign var="adr" value=$invadr}]
   [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "deladr"}]
   [{assign var="adr" value=$aDeliveryAddress}]
   [{assign var="fallback" value=$oAddress}]
[{/if}]

[{assign var="fields" value='|'|explode:$_fields}]

[{math equation="12/x" x=$fields|@count assign="defaultXS"}]
[{math equation="8/x"  x=$fields|@count assign="defaultSM"}]
[{if $xs}][{assign var="xs" value='|'|explode:$xs}][{/if}]
[{if $sm}][{assign var="sm" value='|'|explode:$sm}][{/if}]
[{if $md}][{assign var="md" value='|'|explode:$md}][{/if}]
[{if $lg}][{assign var="lg" value='|'|explode:$lg}][{/if}]

[{if $oView->isFieldRequired($fields[0]) || $oView->isFieldRequired($fields[1]) }][{assign var="_req" value="required"}][{/if}]

<div class="form-group [{if $aErrors.$field}]text-danger[{/if}]">
   <label class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>
   <div class="clear display-xs-block"></div>
   [{foreach from=$fields key="index" item="field" name="fields"}]
      [{* assign var="xs" value=$xs[1] *}]
      <div class="col-xs-[{$xs[$index]|default:$defaultXS}] col-sm-[{$sm[$index]|default:$defaultSM}] col-md-[{$md[$index]|default:$sm[$index]}] col-lg-[{$lg[$index]|default:$sm[$index]}]">
         <input type="[{$type|default:'text'}]" maxlength="64" name="[{$prefix}][[{$field}]]" id="[{$prefix}]_[{$field}]" class="form-control"
                value="[{if $adr && isset($adr.$field)}][{$adr.$field}][{elseif $fallback && isset($fallback->$field) }][{$fallback->$field->value }][{/if}]" [{$_req}]>
         [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$field}]
         <div class="help-block"></div>
      </div>
   [{/foreach}]
</div>