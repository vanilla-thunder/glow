[{capture append="oxidBlock_content"}]
    <h1 class="page-header">[{oxmultilang ident="DD_CONTACT_PAGE_HEADING"}]</h1>
    [{if $oView->getContactSendStatus()}]
        [{assign var="_statusMessage" value="DD_CONTACT_THANKYOU1"|oxmultilangassign|cat:" "|cat:$oxcmp_shop->oxshops__oxname->value}]
        [{assign var="_statusMessageSuffix" value="DD_CONTACT_THANKYOU2"|oxmultilangassign}]
        [{include file="message/notice.tpl" statusMessage=$_statusMessage|cat:$_statusMessageSuffix}]
    [{/if}]

    [{assign var="sGoogleMapsAddr" value=$oViewConf->getViewThemeParam('sGoogleMapsAddr')}]
    [{if $sGoogleMapsAddr}]
        <div class="row">
            <div class="col-xs-12">
                <div class="google-maps">
                    <figure>
                        <iframe width="100%" height="400" style="width:100%;" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
                                src="https://www.google.de/maps?t=m&amp;q=[{$sGoogleMapsAddr|urlencode}]&amp;ie=UTF8&amp;hq=[{$sGoogleMapsAddr|urlencode}]&amp;output=embed"></iframe>
                    </figure>
                </div>
            </div>
        </div>
    [{/if}]
    <div class="row">
        <div class="col-xs-12 col-md-4 pull-right">
            <div>
                <address>
                    <strong>[{$oxcmp_shop->oxshops__oxcompany->value}]</strong><br>
                    <span>
                      [{$oxcmp_shop->oxshops__oxstreet->value}]<br>
                        [{$oxcmp_shop->oxshops__oxzip->value}] [{$oxcmp_shop->oxshops__oxcity->value}]<br>
                        [{$oxcmp_shop->oxshops__oxcountry->value}]<br>
                        <span class="hidden">[{$oxcmp_shop->oxshops__oxcity->value}], [{$oxcmp_shop->oxshops__oxcountry->value}]</span>
                    </span>
                    [{if $oxcmp_shop->oxshops__oxtelefon->value}]
                        <strong>[{oxmultilang ident="PHONE" suffix="COLON"}]</strong>
                        [{$oxcmp_shop->oxshops__oxtelefon->value}]
                        <br>
                    [{/if}]
                    [{if $oxcmp_shop->oxshops__oxtelefax->value}]
                        <strong>[{oxmultilang ident="FAX" suffix="COLON"}]</strong>
                        [{$oxcmp_shop->oxshops__oxtelefax->value}]
                        <br>
                    [{/if}]
                    [{if $oxcmp_shop->oxshops__oxinfoemail->value}]
                        <strong>[{oxmultilang ident="EMAIL" suffix="COLON"}]</strong>
                        [{oxmailto address=$oxcmp_shop->oxshops__oxinfoemail->value}]
                        <br>
                    [{/if}]
                    <span class="hidden">[{$oViewConf->getHomeLink()}]</span>
                </address>
            </div>
        </div>
        <div class="col-xs-12 col-md-8">
            [{assign var="editval" value=$oView->getUserData()}]
            <form class="form-horizontal validate" action="[{$oViewConf->getSslSelfLink()}]" method="post" role="form">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="fnc" value="send"/>
                    <input type="hidden" name="cl" value="contact"/>
                </div>

                [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxfname}]

                [{assign var="prefix" value="editval"}]
                [{include file="form/inc/select.tpl" _label="TITLE" _field="oxuser__oxsal" _options="MRS|MR" value=$editval.oxuser__oxsal|default:$oxcmp_user->oxuser__oxsal}]
                [{include file="form/inc/input.tpl" _label="FIRST_NAME" _field="oxuser__oxfname" _type="text" _req="required"}]
                [{include file="form/inc/input.tpl" _label="LAST_NAME" _field="oxuser__oxlname" _type="text" _req="required"}]
                [{include file="form/inc/input.tpl" _label="EMAIL" _field="oxuser__oxusername" _type="email" _req="required"}]
                [{include file="form/inc/input.tpl" _label="SUBJECT" _field="c_subject" _type="text" prefix=false value=$oView->getContactSubject() _req="required"}]
                [{include file="form/inc/textarea.tpl" _label="MESSAGE" _field="c_message" prefix=false value=$oView->getContactMessage() _req="required"}]

                [{block name="captcha_form"}]
                    [{*
                    [{if $oViewConf->getViewThemeParam('sRecaptchaApiKey')|trim}]
                                [{oxscript include="https://www.google.com/recaptcha/api.js"}]
                                <div class="g-recaptcha" data-sitekey="[{$oViewConf->getViewThemeParam('sRecaptchaApiKey')|trim}]"></div>
                             [{else}]

                             [{/if}]
                    *}]
                    [{assign var="oCaptcha" value=$oView->getCaptcha()}]
                    <div class="form-group">
                        <label for="c_mac" class="control-label col-sm-4 required">[{oxmultilang ident="VERIFICATION_CODE"}]</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    [{if $oCaptcha->isImageVisible()}]<img src="[{$oCaptcha->getImageUrl()}]" alt="">
                                    [{else}][{$oCaptcha->getText()}][{/if}]
                                </div>
                                <input type="hidden" name="c_mach" value="[{$oCaptcha->getHash()}]"/>
                                <input type="hidden" id="c_text" name="c_text" value="[{$oCaptcha->getText()}]">
                                <input type="text" class="form-control" id="c_mac" name="c_mac" required autocomplete="off"
                                       value="[{if $oxcmp_user && ( $oxcmp_user->oxuser__oxrights->value == "malladmin" || $oxcmp_user->getOrderCount() )}][{$oCaptcha->getText()}][{/if}]">
                            </div>
                        </div>
                    </div>
                [{/block}]


                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-8">

                        [{oxifcontent ident="oxsecurityinfo" object="oCont"}]
                            <p class="alert alert-info">
                                [{oxmultilang ident="GLOW_CONTACT_SECURITY"}] <a data-fancybox-href="[{$oCont->getLink()}]?plain=1" href="[{$oCont->getLink()}]" class="ajax" target="_blank"
                                                                                 rel="nofollow">[{$oCont->oxcontents__oxtitle->value}]</a>
                            </p>
                        [{/oxifcontent}]

                        <button class="btn btn-success btn-lg btn-block" type="submit">
                            <i class="fa fa-envelope fa-fw"></i> [{oxmultilang ident="SEND"}]
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl"}]
