[{assign var="prefix" value="invadr"}]
[{assign var="invadr" value=$oView->getInvoiceAddress()}]
[{assign var="blBirthdayRequired" value=$oView->isFieldRequired(oxuser__oxbirthdate)}]

[{if isset( $invadr.oxuser__oxbirthdate.month )}]
    [{assign var="iBirthdayMonth" value=$invadr.oxuser__oxbirthdate.month}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayMonth" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]/":""|regex_replace:"/[-]([0-9]{1,2})$/":""}]
[{else}]
    [{assign var="iBirthdayMonth" value=0}]
[{/if}]

[{if isset( $invadr.oxuser__oxbirthdate.day )}]
    [{assign var="iBirthdayDay" value=$invadr.oxuser__oxbirthdate.day}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayDay" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/^([0-9]{4})[-]([0-9]{1,2})[-]/":""}]
[{else}]
    [{assign var="iBirthdayDay" value=0}]
[{/if}]

[{if isset( $invadr.oxuser__oxbirthdate.year )}]
    [{assign var="iBirthdayYear" value=$invadr.oxuser__oxbirthdate.year}]
[{elseif $oxcmp_user->oxuser__oxbirthdate->value && $oxcmp_user->oxuser__oxbirthdate->value != "0000-00-00"}]
    [{assign var="iBirthdayYear" value=$oxcmp_user->oxuser__oxbirthdate->value|regex_replace:"/[-]([0-9]{1,2})[-]([0-9]{1,2})$/":""}]
[{else}]
    [{assign var="iBirthdayYear" value=0}]
[{/if}]

[{include file="form/inc/input.tpl" _label="COMPANY" _field="oxuser__oxcompany" _type="text"}]

[{include file="form/inc/select.tpl" _label="TITLE" _field="oxuser__oxsal" _options="MRS|MR"}]

[{include file="form/inc/input.tpl" _label="FIRST_NAME" _field="oxuser__oxfname" _type="text"}]

[{include file="form/inc/input.tpl" _label="LAST_NAME" _field="oxuser__oxlname" _type="text"}]

[{include file="form/inc/inputgroup.tpl" _label="STREET_AND_STREETNO" _fields="oxuser__oxstreet|oxuser__oxstreetnr" xs="8|4" sm="5|3" _type="text"}]

[{include file="form/inc/input.tpl" _label="ADDITIONAL_INFO" _field="oxuser__oxaddinfo" _type="text"}]

[{include file="form/inc/inputgroup.tpl" _label="POSTAL_CODE_AND_CITY" _fields="oxuser__oxzip|oxuser__oxcity" xs="4|8" sm="3|5" _type="text"}]

[{block name="form_user_billing_country"}]
    [{include file="form/inc/select.tpl" _label="COUNTRY" _field="oxuser__oxcountryid" _options=$oViewConf->getCountryList() }]
[{/block}]

[{include file="form/inc/input.tpl" _label="VAT_ID_NUMBER" _field="oxuser__oxustid" _type="text"}]

[{include file="form/inc/input.tpl" _label="PHONE" _field="oxuser__oxfon" _type="text"}]

[{include file="form/inc/input.tpl" _label="FAX" _field="oxuser__oxfax" _type="text"}]

[{include file="form/inc/input.tpl" _label="CELLUAR_PHONE" _field="oxuser__oxmobfon" _type="text"}]

[{include file="form/inc/input.tpl" _label="PERSONAL_PHONE" _field="oxuser__oxprivfon" _type="text"}]


[{if $oViewConf->showBirthdayFields()}]
    <div class="form-group oxDate[{if $aErrors.oxuser__oxbirthdate}] text-danger[{/if}]">
        <label class="control-label col-sm-4 [{if $oView->isFieldRequired(oxuser__oxbirthdate)}]required[{/if}]">[{oxmultilang ident="BIRTHDATE"}]</label>

        <div class="clear display-xs-block"></div>
        <div class="col-xs-3 col-sm-2">
            <input id="oxDay" class="oxDay form-control" name="invadr[oxuser__oxbirthdate][day]" type="text" maxlength="2" value="[{if $iBirthdayDay > 0}][{$iBirthdayDay}][{/if}]" placeholder="[{oxmultilang ident="DAY"}]"[{if $oView->isFieldRequired(oxuser__oxbirthdate)}] required=""[{/if}]>
        </div>
        <div class="col-xs-4 col-sm-3">
            <select class="oxMonth form-control" name="invadr[oxuser__oxbirthdate][month]"[{if $oView->isFieldRequired(oxuser__oxbirthdate)}] required=""[{/if}]>
                <option value="" label="[{oxmultilang ident="MONTH"}]">[{oxmultilang ident="MONTH"}]</option>
                [{section name="month" start=1 loop=13}]
                    <option value="[{$smarty.section.month.index}]" label="[{$smarty.section.month.index}]" [{if $iBirthdayMonth == $smarty.section.month.index}] selected="selected" [{/if}]>
                        [{oxmultilang ident="MONTH_NAME_"|cat:$smarty.section.month.index}]
                    </option>
                [{/section}]
            </select>
        </div>
        <div class="col-xs-4 col-sm-3">
            <input id="oxYear" class="oxYear form-control" name="invadr[oxuser__oxbirthdate][year]" type="text" maxlength="4" value="[{if $iBirthdayYear}][{$iBirthdayYear}][{/if}]" placeholder="[{oxmultilang ident="YEAR"}]"[{if $oView->isFieldRequired(oxuser__oxbirthdate)}] required=""[{/if}]>
        </div>
        <div class="col-sm-offset-3 col-sm-9 col-xs-12">
            [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxbirthdate}]
            <div class="help-block"></div>
        </div>
    </div>
[{/if}]

[{if !$noFormSubmit}]
    <div class="form-group">
        <div class="col-sm-offset-3 col-sm-9 col-xs-12">
            <button id="accUserSaveTop" type="submit" name="save" class="btn btn-primary">[{oxmultilang ident="SAVE"}]</button>
        </div>
    </div>
[{/if}]