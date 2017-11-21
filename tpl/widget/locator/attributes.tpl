[{block name="widget_locator_attributes"}]
    [{if $attributes}]
        <div class="row">
            <form method="get" action="[{$oViewConf->getSelfActionLink()}]" name="_filterlist" id="filterList">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                    <input type="hidden" name="tpl" value="[{$oViewConf->getActTplName()}]">
                    <input type="hidden" name="oxloadid" value="[{$oViewConf->getActContentLoadId()}]">
                    <input type="hidden" name="fnc" value="executefilter">
                    <input type="hidden" name="fname" value="">
                </div>
                <div class="list-filter">
                    <div class="row">
                        <div class="col-xs-12 col-md-2">
                            <strong>Produkt-Filter:</strong>:
                        </div>
                        <div class="col-xs-12 col-md-10">
                            <div class="row">
                                [{foreach from=$attributes item=oFilterAttr key=sAttrID name=attr}]
                                    [{assign var="sActiveValue" value=$oFilterAttr->getActiveValue()}]
                                    <div class="col-xs-6 col-md-4">
                                        <select name="attrfilter[[{$sAttrID}]]" style="min-width: 150px;" class="form-control">
                                            [{if $sActiveValue}]
                                                <option value="[{$sActiveValue}]" selected>[{$oFilterAttr->getTitle()}] - [{$sActiveValue}]</option>
                                                <option value="">- zurücksetzen -</option>
                                            [{else}]
                                                <option value="">[{$oFilterAttr->getTitle()}]</option>
                                                [{foreach from=$oFilterAttr->getValues() item=sValue}]
                                                    <option value="[{$sValue}]" [{if $sActiveValue == $sValue}]selected[{/if}]>
                                                        &nbsp;&nbsp;[{$sValue}]
                                                    </option>
                                                [{/foreach}]

                                            [{/if}]
                                        </select>
                                    </div>
                                [{/foreach}]
                            </div>
                        </div>
                    </div>
                </div>
                [{*
                <p>
                    <strong>Produkt-Filter:</strong>
                    [{foreach from=$attributes item=oFilterAttr key=sAttrID name=attr}]
                        [{if $oFilterAttr->getActiveValue()}][{$oFilterAttr->getTitle()}]: [{$oFilterAttr->getActiveValue()}][{/if}]
                    [{/foreach}]
                    <button class="btn btn-default btn-md" type="button" data-toggle="collapse" data-target="#attributefilter" aria-expanded="false" aria-controls="attributefilter">

                        <small>(zum Aufklappen hier klicken)</small>
                    </button>
                </p>

                <div class="list-filter collapse in" id="attributefilter">

                    [{foreach from=$attributes item=oFilterAttr key=sAttrID name=attr}]
                        [{assign var="sActiveValue" value=$oFilterAttr->getActiveValue()}]
                        <div class="row">
                            <div class="col-md-4 col-lg-2">
                                <strong>[{$oFilterAttr->getTitle()}]:</strong>
                            </div>
                            [{foreach from=$oFilterAttr->getValues() item=sValue}]
                                <button type="submit" name="attrfilter[[{$sAttrID}]]" value="[{$sValue}]"
                                        class="btn btn-[{if $sActiveValue == $sValue}]success[{else}]default}[{/if}] col-xs-6 col-sm-4 col-md-3 col-lg-2">
                                    [{$sValue}]
                                </button>
                            [{/foreach}]
                            [{if $sActiveValue}]
                                <button type="submit" name="attrfilter[[{$sAttrID}]]" value="" class="btn btn-danger col-xs-6 col-sm-4 col-md-3 col-lg-2">
                                    <small>[{oxmultilang ident="RESET_SELECTION"}]</small>
                                </button>
                            [{/if}]

                        </div>
                    [{/foreach}]
                </div>
                *}]

            </form>
        </div>
    [{/if}]
[{/block}]