[{assign var="oSelections" value=$oSelectionList->getSelections()}]
[{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]

[{if $oSelections}]
    <div class="form-group">
        [{if !$blHideLabel}]
            <label class="col-xs-12 col-sm-3 control-label"><strong>[{oxmultilang ident="COLON"}]</strong></label>
        [{/if}]
        <div class="col-xs-12 col-sm-9">
            [{if $editable !== false}]
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <td>[{$oSelectionList->getLabel()}]</td>
                        <td>Bestand</td>
                    </tr>
                    </thead>
                    <tbody>
                    [{foreach from=$oSelections item=oSelection}]
                    <tr class="[{if $oSelection->isActive()}]success[{elseif $oSelection->isDisabled()}][{/if}]">
                        <td>
                            [{$oSelection->getName()}]
                            <input type="radio" value="[{$oSelection->getName()}]" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" id="[{$sFieldName|default:"varselid"}]_[{$iKey}]">
                        </td>
                    </tr>
                    <div class="radio [{if $oSelection->isDisabled()}]disabled[{/if}]">
                        <label>

                            [{$oSelection->getName()}] [{if $oSelection->isDisabled()}]([{oxmultilang ident="NOT_AVAILABLE"}])[{/if}]
                        </label>
                    </div>
                [{/foreach}]
                    </tbody>
                </table>
            [{/if}]
        </div>
    </div>
[{/if}]