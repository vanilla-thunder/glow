[{assign var="oSelections" value=$oSelectionList->getSelections()}]
[{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]

[{if $oSelections}]
    <div class="form-group">
        [{if !$blHideLabel}]
            <label class="col-sm-12 col-md-6 col-lg-3 control-label" for="disabledTextInput"><strong>[{$oSelectionList->getLabel()}][{oxmultilang ident="COLON"}]</strong></label>
        [{/if}]
        <div class="col-sm-12 col-md-6 col-lg-9">
            [{if $editable !== false}]
                [{* <input type="hidden" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" class="activeselection" value="[{if $oActiveSelection}][{$oActiveSelection->getValue()}][{/if}]"> *}]
                <select name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" id="[{$sFieldName|default:"varselid"}]_[{$iKey}]" class="form-control variants">

                    [{if !$oActiveSelection}]
                        <option value="">[{oxmultilang ident="CHOOSE_VARIANT"}]</option>[{/if}]

                    [{foreach from=$oSelections item=oSelection}]
                        <option value="[{$oSelection->getValue()}]" class="[{if $oSelection->isDisabled()}]not-available[{/if}]" [{if $oSelection->isActive()}]selected[{/if}]
                                data-href="[{$oSelection->getLink()}]">
                            [{$oSelection->getName()}] [{if $oSelection->isDisabled()}]([{oxmultilang ident="NOT_AVAILABLE"}])[{/if}]
                        </option>
                    [{/foreach}]
                </select>
            [{/if}]
        </div>
    </div>
[{/if}]