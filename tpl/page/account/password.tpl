[{capture append="oxidBlock_content"}]

    <h1 class="page-header">[{oxmultilang ident="CHANGE_PASSWORD"}]</h1>

    [{if $oView->isPasswordChanged()}]
        <div class="alert alert-success">
            [{oxmultilang ident="MESSAGE_PASSWORD_CHANGED"}]
        </div>
    [{/if}]
    [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxpassword}]
    <hr/>
    [{if count($Errors) > 0 && count($Errors.user) > 0}]
        <div class="alert alert-danger">
            [{foreach from=$Errors.user item=oEr key=key}]
                <p>[{$oEr->getOxMessage()}]</p>
            [{/foreach}]
        </div>
    [{/if}]

    <form class="form-horizontal validate" action="[{$oViewConf->getSelfActionLink()}]" name="changepassword" method="post" novalidate="novalidate">
        [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]

        <div class="hidden">
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="fnc" value="changePassword">
            <input type="hidden" name="cl" value="account_password">
            <input type="hidden" name="CustomError" value='user'>
            <input type="hidden" id="passwordLength" value="[{$oViewConf->getPasswordLength()}]">
        </div>

        [{assign var="prefix" value=false}]
        [{include file="form/inc/input.tpl" _label="OLD_PASSWORD"      _field="password_old" _type="password"  value="" _req="required"}]
        [{include file="form/inc/input.tpl" _label="NEW_PASSWORD"      _field="password_new" _type="password"  value="" _req="required"}]
        [{include file="form/inc/input.tpl" _label="CONFIRM_PASSWORD"  _field="password_new_confirm" _type="password"  value="" _req="required"}]

        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-8">
                <button id="savePass" type="submit" class="btn btn-success btn-lg" role="button">[{oxmultilang ident="SAVE"}]</button>
            </div>
        </div>
    </form>
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{capture append="oxidBlock_sidebar"}]
    <div class="box">[{include file="page/account/inc/account_menu.tpl" active_link="password"}]</div>
[{/capture}]

[{include file="layout/page.tpl" sidebar="Left"}]
