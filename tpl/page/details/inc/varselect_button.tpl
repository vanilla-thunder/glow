[{assign var="oSelections" value=$oSelectionList->getSelections()}]
[{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]

[{if $oSelections}]
    <div class="form-group">
        [{if !$blHideLabel}]
            <label class="col-xs-12 col-sm-3 control-label"><strong>[{$oSelectionList->getLabel()}][{oxmultilang ident="COLON"}]</strong></label>
        [{/if}]
        <div class="col-xs-12 col-sm-9">
            [{if $editable !== false}]
                <div class="row">
                    [{foreach from=$oSelections item=oSelection}]
                        <div class="radiobtn col-xs-12 col-sm-6">
                            <input type="radio" name="varselid[[{$iKey}]]" value="[{$oSelection->getValue()}]" class="hidden" id="varselid_[{$iKey}]_[{$oSelection->getValue()}]"
                                   [{if $oSelection->isActive()}]checked[{/if}] [{if $oSelection->isDisabled()}]disabled title="[{oxmultilang ident='NOT_AVAILABLE'}]"[{/if}]>
                            <label for="varselid_[{$iKey}]_[{$oSelection->getValue()}]" [{if $oSelection->isDisabled()}]disabled title="[{oxmultilang ident='NOT_AVAILABLE'}]"[{/if}] class="btn btn-label btn-block">
                                [{$oSelection->getName()}][{if $oSelection->isDisabled()}]<small>( [{oxmultilang ident='NOT_AVAILABLE'}] )</small>[{/if}]
                            </label>
                        </div>
                    [{/foreach}]
                </div>
            [{/if}]
        </div>
    </div>
[{/if}]