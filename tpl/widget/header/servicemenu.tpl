[{if $oxcmp_user}]
    [{assign var="noticeListCount" value=$oxcmp_user->getNoticeListArtCnt()}]
    [{assign var="wishListCount" value=$oxcmp_user->getWishListArtCnt()}]
    [{assign var="recommListCount" value=$oxcmp_user->getRecommListsCount()}]
[{else}]
    [{assign var="noticeListCount" value="0"}]
    [{assign var="wishListCount" value="0"}]
    [{assign var="recommListCount" value="0"}]
[{/if}]
[{math equation="a+b+c+d" a=$oView->getCompareItemsCnt() b=$noticeListCount c=$wishListCount d=$recommListCount assign="notificationsCounter"}]

<button type="button" class="btn btn-default btn-block" data-toggle="modal" data-target="#loginmodal">
    [{block name="dd_layout_page_header_icon_menu_account_button"}]
        [{if !$oxcmp_user}]
            [{oxmultilang ident="LOGIN"}]
        [{else}]
            [{oxmultilang ident="MY_ACCOUNT"}]
        [{/if}]
        [{if $notificationsCounter > 0}]
            <span class="badge">[{$notificationsCounter}]</span>
        [{/if}]
    [{/block}]
</button>

<div class="modal fade" id="loginmodal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header text-left">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">[{if !$oxcmp_user}][{oxmultilang ident="LOGIN"}][{else}][{oxmultilang ident="MY_ACCOUNT"}][{/if}]</h4>
            </div>
            <div class="modal-body">

                [{if !$oxcmp_user->oxuser__oxpassword->value}]

                    [{assign var="bIsError" value=0}]
                    [{capture name="loginErrors"}]
                        [{foreach from=$Errors.loginBoxErrors item=oEr key=key}]
                            <p id="errorBadLogin" class="alert alert-danger">[{$oEr->getOxMessage()}]</p>
                            [{assign var="bIsError" value=1}]
                        [{/foreach}]
                    [{/capture}]
                    <form class="form" id="login" name="login" action="[{$oViewConf->getSslSelfLink()}]" method="post">
                        <div id="loginBox" class="loginBox" [{if $bIsError}]style="display: block;"[{/if}]>
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="fnc" value="login_noredirect">
                            <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                            [{if $oViewConf->getTopActiveClassName() eq "content"}]
                                <input type="hidden" name="oxcid" value="[{$oViewConf->getContentId()}]">
                            [{/if}]
                            <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]">
                            <input type="hidden" name="CustomError" value="loginBoxErrors">
                            [{if $oViewConf->getActArticleId()}]
                                <input type="hidden" name="anid" value="[{$oViewConf->getActArticleId()}]">
                            [{/if}]


                            <div class="form-group">
                                <input id="loginEmail" type="email" name="lgn_usr" value="" class="form-control" placeholder="[{oxmultilang ident="EMAIL_ADDRESS"}]">
                            </div>

                            <div class="form-group">
                                <div class="input-group">
                                    <input id="loginPasword" type="password" name="lgn_pwd" class="form-control" value="" placeholder="[{oxmultilang ident="PASSWORD"}]">
                                    <span class="input-group-btn">
                        <a class="forgotPasswordOpener btn btn-default" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=forgotpwd"}]" title="[{oxmultilang ident="FORGOT_PASSWORD"}]">?</a>
                    </span>
                                </div>
                            </div>

                            [{if $oViewConf->isFunctionalityEnabled( "blShowRememberMe" )}]
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" class="checkbox" value="1" name="lgn_cook" id="remember"> [{oxmultilang ident="REMEMBER_ME"}]
                                    </label>
                                </div>
                            [{/if}]

                            <button type="submit" class="btn btn-primary">[{oxmultilang ident="LOGIN"}]</button>

                            [{if !$oxcmp_user}]
                                <a class="btn" id="registerLink" role="button" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=register"}]" title="[{oxmultilang ident="REGISTER"}]">[{oxmultilang ident="REGISTER"}]</a>
                            [{/if}]
                        </div>
                    </form>
                [{else}]
                    <!-- mein Konto + Links -->
                    <div class="text-left">
                        [{include file="page/account/inc/account_menu.tpl"}]
                    </div>
                    <a class="btn btn-danger" role="button" href="[{$oViewConf->getLogoutLink()}]" title="[{oxmultilang ident="LOGOUT"}]">
                        <i class="fa fa-power-off"></i> [{oxmultilang ident="LOGOUT"}]
                    </a>
                [{/if}]
            </div>
        </div>
    </div>
</div>

