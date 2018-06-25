[{assign var="oSelections" value=$oSelectionList->getSelections()}]
[{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]

[{if $oSelections}]
    <div class="form-group">
        [{if !$blHideLabel}]
            <label class="col-xs-12 col-sm-3 control-label"><strong>[{$oSelectionList->getLabel()}][{oxmultilang ident="COLON"}]</strong></label>
        [{/if}]
        <div class="col-xs-12 col-sm-9">
            [{if $editable !== false}]
                [{foreach from=$oSelections item=oSelection name="varselradios"}]
                    <!--
                        [{$oSelection|@var_dump}]
                        -->
                    <div class="radio [{if $oSelection->isDisabled()}]disabled[{/if}]">
                        <label>
                            <input type="radio" [{if $oSelection->isDisabled()}]disabled[{/if}] [{if $oSelection->isActive()}]checked[{/if}]
                                   name="[{$sFieldName|default:"varselid"}][[{$iKey}]]"
                                   id="[{$sFieldName|default:"varselid"}]_[{$iKey}]_[{$smarty.foreach.varselradios.index}]"
                                   value="[{$oSelection->getValue()}]">
                            [{$oSelection->getName()}] [{if $oSelection->isDisabled()}]([{oxmultilang ident="NOT_AVAILABLE"}])[{/if}]
                        </label>
                    </div>
                [{/foreach}]
            [{/if}]
        </div>
    </div>
[{/if}]