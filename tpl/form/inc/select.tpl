[{if $oView->isFieldRequired($_field)}][{assign var="_req" value="required"}][{/if}]
[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if $prefix == "invadr"}]
   [{assign var="adr" value=$invadr}]
   [{assign var="fallback" value=$oxcmp_user}]
[{elseif $prefix == "deladr"}]
   [{assign var="adr" value=$deladr}]
   [{assign var="fallback" value=$oAddress}]
[{/if}]
[{if $_options|is_string }][{assign var="_options" value='|'|explode:$_options}][{/if}]
[{assign var="_current" value=$value|default:$adr.$_field }]
[{assign var="_current" value=$value|default:$fallback->$_field->value }]

<div class="form-group [{if $aErrors.$_field}]text-danger[{/if}]">
   <label class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>
   <div class="col-sm-8">

      [{if $options|@count < 4}]
         <div class="row">
            [{foreach from=$_options item="option" name="options"}]

               [{if $option|is_a:'oxcountry'}]
                  [{assign var="_value" value=$option->oxcountry__oxid->value}]
                  [{assign var="_label" value=$option->oxcountry__oxtitle->value}]
               [{else}]
                  [{assign var="_value" value=$option}]
                  [{assign var="_label" value=$option|oxmultilangassign}]
               [{/if}]
               <div class="radio col-xs-6">
                  <input type="radio" name="[{$prefix}][[{$_field}]]" id="[{$prefix}]_[{$_field}]_[{$_value}]" class="hidden" [{if $_value == $_current || $smarty.foreach.options.first }]checked[{/if}] value="[{$_value}]">
                  <label for="[{$prefix}]_[{$_field}]_[{$_value}]" class="btn btn-label btn-block">[{$_label}]</label>
               </div>
            [{/foreach}]
         </div>
      [{else}]
         <select name="[{$name}]" [{if $class}]class="[{$class}]"[{/if}] [{if $id}]id="[{$id}]"[{/if}]>
            <option value="MRS" [{if $value|lower  == "mrs" or $value2|lower == "mrs"  || $smarty.foreach.options.first }]SELECTED[{/if}]>[{oxmultilang ident="MRS"}]</option>
            <option value="MR" [{if $value|lower  == "mr"  or $value2|lower == "mr"}]SELECTED[{/if}]>[{oxmultilang ident="MR" }]</option>
         </select>
      [{/if}]

      [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$_field}]
      <div class="help-block"></div>
   </div>
</div>