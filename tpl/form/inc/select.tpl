[{assign var="prefix" value=$prefix|default:'invadr'}]
[{if $oView->isFieldRequired($_field)}]
    [{assign var="_req" value="required"}]
[{/if}]
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
    [{if $_label}]<label class="control-label col-sm-4 [{$_req}]">[{oxmultilang ident=$_label}]</label>[{/if}]
    <div class="[{if $_label}]col-sm-8[{/if}]">
        [{if $options|@count < 4 && $_type !== "select"}]
            <div class="row">
                [{foreach from=$_options item="option" name="options"}]

                    [{if $option|is_a:'oxcountry'}]
                        [{assign var="_value" value=$option->oxcountry__oxid->value}]
                        [{assign var="_title" value=$option->oxcountry__oxtitle->value}]
                    [{else}]
                        [{assign var="_value" value=$option}]
                        [{assign var="_title" value=$option|oxmultilangassign}]
                    [{/if}]
                    <div class="radiobtn col-xs-6">
                        <input type="radio" name="[{$prefix}][[{$_field}]]" id="[{$prefix}]_[{$_field}]_[{$_value}]" class="hidden"
                               [{if $_value == $_current || $smarty.foreach.options.first }]checked[{/if}] value="[{$_value}]">
                        <label for="[{$prefix}]_[{$_field}]_[{$_value}]" class="btn btn-label btn-block">[{$_title}]</label>
                    </div>
                [{/foreach}]
            </div>
        [{else}] 
            <select name="[{$prefix}][[{$_field}]]" class="form-control" id="[{$prefix}]_[{$_field}]">
                <option value="" disabled selected>[{oxmultilang ident=$_placeholder }]</option>

                [{foreach from=$_options item="option" name="options"}]

                    [{if $option|is_a:'oxcountry'}]
                        [{assign var="_value" value=$option->oxcountry__oxid->value}]
                        [{assign var="_title" value=$option->oxcountry__oxtitle->value}]
                    [{else}]
                        [{assign var="_value" value=$option}]
                        [{assign var="_title" value=$option|oxmultilangassign}]
                    [{/if}]
                    <option value="[{$_value}]" [{if $_value == $_current }]SELECTED[{/if}]>
                        [{$_title}]
                    </option>
                [{/foreach}]
            </select>
        [{/if}]
        [{include file="message/inputvalidation.tpl" aErrors=$aErrors.$_field}]
        <div class="help-block"></div>
    </div>
</div>