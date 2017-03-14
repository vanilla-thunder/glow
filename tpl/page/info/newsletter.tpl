[{capture append="oxidBlock_content"}]
    <h1 class="page-header">[{oxmultilang ident="STAY_INFORMED"}]</h1>
    [{if $oView->getNewsletterStatus() == 4 || !$oView->getNewsletterStatus()}]
        <!-- nix -->
    [{elseif $oView->getNewsletterStatus() == 1}]
        <div class="alert alert-info" role="alert">
            <h2>[{oxmultilang ident="MESSAGE_THANKYOU_FOR_SUBSCRIBING_NEWSLETTERS"}]</h2>
            <p>[{oxmultilang ident="MESSAGE_SENT_CONFIRMATION_EMAIL"}]</p>
        </div>
    [{elseif $oView->getNewsletterStatus() == 2}]
        <div class="alert alert-success" role="alert">
            <h2>[{oxmultilang ident="MESSAGE_NEWSLETTER_CONGRATULATIONS"}]</h2>
            <p>[{oxmultilang ident="MESSAGE_NEWSLETTER_SUBSCRIPTION_ACTIVATED"}]</p>
        </div>
    [{elseif $oView->getNewsletterStatus() == 3}]
        <div class="alert alert-success" role="alert">
            <h2>[{oxmultilang ident="SUCCESS"}]</h2>
            <p>[{oxmultilang ident="MESSAGE_NEWSLETTER_SUBSCRIPTION_CANCELED"}]</p>
        </div>
    [{/if}]
    <div class="row">
        <div class="col-xs-12 col-lg-5">
            [{block name="newsletter_info"}]
                <article>
                    [{oxifcontent ident="oxnewstlerinfo" object="oCont"}]
                    [{$oCont->oxcontents__oxcontent->value}]
                    [{/oxifcontent}]
                </article>
                [{oxifcontent ident="oxsecurityinfo" object="oCont"}]
                    <p class="alert alert-info">
                        [{oxmultilang ident="GLOW_CONTACT_SECURITY"}] <a data-fancybox-href="[{$oCont->getLink()}]?plain=1" href="[{$oCont->getLink()}]" class="ajax" target="_blank"
                                                                         rel="nofollow">[{$oCont->oxcontents__oxtitle->value}]</a>
                    </p>
                [{/oxifcontent}]
            [{/block}]
        </div>
        <div class="col-xs-12 visible-xs">
            <hr/>
        </div>
        <div class="col-xs-12 col-lg-7">
            <form class="form-horizontal" action="[{$oViewConf->getSslSelfLink()}]" method="post" role="form" novalidate="novalidate">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="fnc" value="send">
                    <input type="hidden" name="cl" value="newsletter">
                    <input type="hidden" name="editval[oxuser__oxcountryid]" value="[{$oView->getHomeCountryId()}]">
                </div>
                [{block name="newsletter_form"}]
                    [{assign var="prefix" value="editval"}]
                    [{include file="form/inc/select.tpl" _label="TITLE" _field="oxuser__oxsal" _options="MRS|MR"}]
                    [{include file="form/inc/input.tpl" _label="FIRST_NAME" _field="oxuser__oxfname" _type="text" _req=false}]
                    [{include file="form/inc/input.tpl" _label="LAST_NAME"  _field="oxuser__oxlname" _type="text" _req=false}]
                    [{include file="form/inc/input.tpl" _label="EMAIL" _field="oxuser__oxusername" _type="text" _req="required"}]
                [{/block}]

                [{block name="newsletter_buttons"}]
                    <div class="form-group">
                        <div class="col-xs-6 col-sm-offset-2 col-sm-5">
                            <button class="btn btn-block btn-success btn-lg" type="submit" name="subscribeStatus" value="1">[{oxmultilang ident="SUBSCRIBE"}]</button>
                        </div>
                        <div class="col-xs-6 col-sm-5">
                            <button class="btn btn-block btn-danger btn-lg" type="submit" name="subscribeStatus" value="0">[{oxmultilang ident="UNSUBSCRIBE"}]</button>
                        </div>
                    </div>
                [{/block}]
            </form>
        </div>
    </div>
    [{insert name="oxid_tracker"}]
[{/capture}]

[{include file="layout/page.tpl" sidebar="left"}]