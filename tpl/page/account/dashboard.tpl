[{assign var="template_title" value="MY_ACCOUNT"|oxmultilangassign}]
[{capture append="oxidBlock_content"}]
   <div class="accountDashboardView">
      <h1 id="accountMain" class="page-header">[{oxmultilang ident="MY_ACCOUNT"}] "[{$oxcmp_user->oxuser__oxusername->value}]"</h1>

      <div class="row">

         <div class="col-xs-12 col-md-6">
            <div class="panel panel-default">
               <div class="panel-heading">
                  <a id="linkAccountBillship" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_user"}]">[{oxmultilang ident="BILLING_SHIPPING_SETTINGS"}]</a>
                  <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_user"}]" class="btn btn-default btn-xs pull-right">
                     <i class="fa fa-arrow-right"></i>
                  </a>
               </div>
               <div class="panel-body">[{oxmultilang ident="UPDATE_YOUR_BILLING_SHIPPING_SETTINGS"}]</div>
            </div>
         </div>

         <div class="col-xs-12 col-md-6">
            <div class="panel panel-default">
               <div class="panel-heading">
                  <a id="linkAccountPassword" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_password"}]">[{oxmultilang ident="CHANGE_PASSWORD"}]</a>
                  <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_password"}]" class="btn btn-default btn-xs pull-right">
                     <i class="fa fa-arrow-right"></i>
                  </a>
               </div>
               <div class="panel-body">[{oxmultilang ident="CHANGE_PASSWORD"}]</div>
            </div>
         </div>

         [{if $oViewConf->getViewThemeParam('blShowNewsletter')}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a id="linkAccountNewsletter" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_newsletter"}]">[{oxmultilang ident="NEWSLETTER_SETTINGS"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_newsletter"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="NEWSLETTER_SUBSCRIBE_CANCEL"}]</div>
               </div>
            </div>
         [{/if}]


         <div class="col-xs-12 col-md-6">
            <div class="panel panel-default">
               <div class="panel-heading">
                  <a id="linkAccountOrder" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order"}]">[{oxmultilang ident="ORDER_HISTORY"}]</a>
                  <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_order"}]" class="btn btn-default btn-xs pull-right">
                     <i class="fa fa-arrow-right"></i>
                  </a>
               </div>
               <div class="panel-body">[{oxmultilang ident="ORDERS"}] [{$oView->getOrderCnt()}]</div>
            </div>
         </div>

         [{if $oView->isEnabledDownloadableFiles()}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a id="linkAccountDownloads" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_downloads"}]">[{oxmultilang ident="MY_DOWNLOADS"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_downloads"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="MY_DOWNLOADS_DESC"}]</div>
               </div>
            </div>
         [{/if}]

         [{if $oViewConf->getViewThemeParam('blShowNoticelist')}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist"}]">[{oxmultilang ident="MY_WISH_LIST"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_noticelist"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="PRODUCT"}] [{if $oxcmp_user}][{$oxcmp_user->getNoticeListArtCnt()}][{else}]0[{/if}]</div>
               </div>
            </div>
         [{/if}]
         [{if $oViewConf->getShowWishlist()}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_wishlist"}]">[{oxmultilang ident="MY_GIFT_REGISTRY"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_wishlist"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="PRODUCT"}] [{if $oxcmp_user}][{$oxcmp_user->getWishListArtCnt()}][{else}]0[{/if}]</div>
               </div>
            </div>
         [{/if}]
         [{if $oViewConf->getShowCompareList()}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=compare"}]">[{oxmultilang ident="MY_PRODUCT_COMPARISON"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=compare"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="PRODUCT"}] [{if $oView->getCompareItemsCnt()}][{$oView->getCompareItemsCnt()}][{else}]0[{/if}]</div>
               </div>
            </div>
         [{/if}]

         [{if $oViewConf->getShowListmania()}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_recommlist"}]">[{oxmultilang ident="MY_LISTMANIA"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account_recommlist"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="LISTS"}] [{if $oxcmp_user->getRecommListsCount()}][{$oxcmp_user->getRecommListsCount()}][{else}]0[{/if}]</div>
               </div>
            </div>
         [{/if}]

         [{if $oView|method_exists:"oeGdprBaseIsUserAllowedToManageOwnReviews" && $oView->oeGdprBaseIsUserAllowedToManageOwnReviews()}]
            <div class="col-xs-12 col-md-6">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=oegdprbaseaccountreviewcontroller"}]">[{oxmultilang ident="OEGDPRBASE_MY_REVIEWS"}]</a>
                     <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=oegdprbaseaccountreviewcontroller"}]" class="btn btn-default btn-xs pull-right">
                        <i class="fa fa-arrow-right"></i>
                     </a>
                  </div>
                  <div class="panel-body">[{oxmultilang ident="OEGDPRBASE_MY_REVIEWS"}] [{if $oView->oeGdprBaseGetReviewAndRatingItemsCount()}][{$oView->oeGdprBaseGetReviewAndRatingItemsCount()}][{else}]0[{/if}]</div>
               </div>
            </div>
         [{/if}]
      </div>
   </div>
   <div class="row">
      <div class="col-xs-12 text-right">

         [{if $oView|method_exists:"oeGdprBaseIsUserAllowedToDeleteOwnAccount" && $oView->oeGdprBaseIsUserAllowedToDeleteOwnAccount()}]
            [{block name="oegdprbase_account_delete_my_account"}]
               <button id="oegdprbase_delete_my_account_button"
                       class="btn btn-danger pull-left"
                       data-toggle="modal"
                       data-target="#oegdprbase_delete_my_account_confirmation">
                  <i class="fa fa-trash"></i>
                  [{oxmultilang ident="OEGDPRBASE_DELETE_MY_ACCOUNT"}]
               </button>
               [{include file="oegdprbasedeletemyaccountconfirmation_flow_modal.tpl"}]
            [{/block}]
         [{/if}]

         <a href="[{$oViewConf->getLogoutLink()}]" class="btn btn-danger" role="getLogoutLink">
            <i class="fa fa-off"></i> [{oxmultilang ident="LOGOUT"}]
         </a>

      </div>
      <p></p>
   </div>
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]


[{capture append="oxidBlock_sidebar"}]
   [{include file="page/account/inc/account_menu.tpl"}]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left"}]