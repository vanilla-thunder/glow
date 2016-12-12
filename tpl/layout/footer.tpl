[{block name="footer_main"}]
   [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
   [{$oView->setShowNewsletter($oViewConf->getViewThemeParam('blFooterShowNewsletterForm'))}]

   [{if $oxcmp_user}]
      [{assign var="force_sid" value=$oView->getSidForWidget()}]
   [{/if}]

   [{assign var="colSm" value="4"}]
   [{if $oViewConf->getViewThemeParam('blFooterManufacturer') && $oViewConf->getViewThemeParam('blFooterCattree')}]
      [{assign var="colSm" value="2"}]
   [{elseif $oViewConf->getViewThemeParam('blFooterManufacturer') || $oViewConf->getViewThemeParam('blFooterCattree')}]
      [{assign var="colSm" value="3"}]
   [{/if}]
   <footer id="footer">
      <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">
         <div class="row">
            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 pull-right">
               [{if $oView->isPriceCalculated()}]

                  [{block name="footer_deliveryinfo"}]
                  [{/block}]

                  [{block name="layout_page_vatinclude"}]
                     [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
                        <div class="text-right">*
                           [{if $oView->isVatIncluded()}][{oxmultilang ident="PLUS_SHIPPING"}][{else}][{oxmultilang ident="PLUS"}][{/if}]
                           <a href="[{$oCont->getLink()}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a>
                        </div>
                     [{/oxifcontent}]
                  [{/block}]
               [{/if}]
            </div>
            <div class="col-xs-12 col-sm-6 col-md-8 col-lg-9">
               [{* <<START>> Social Links *}]
               [{block name="dd_footer_social_links"}]
                  [{if $oViewConf->getViewThemeParam('sFacebookUrl') || $oViewConf->getViewThemeParam('sGooglePlusUrl') || $oViewConf->getViewThemeParam('sTwitterUrl') || $oViewConf->getViewThemeParam('sYouTubeUrl') || $oViewConf->getViewThemeParam('sBlogUrl')}]
                     <section class="text-left">
                        [{block name="dd_footer_social_links_inner"}]
                           <ul class="nav nav-pills">
                              [{block name="dd_footer_social_links_list"}]
                                 [{if $oViewConf->getViewThemeParam('sFacebookUrl')}]
                                    <li>
                                       <a target="_blank" href="[{$oViewConf->getViewThemeParam('sFacebookUrl')}]">
                                          <i class="fa fa-facebook"></i> <span>Facebook</span>
                                       </a>
                                    </li>
                                 [{/if}]
                                 [{if $oViewConf->getViewThemeParam('sGooglePlusUrl')}]
                                    <li>
                                       <a target="_blank" href="[{$oViewConf->getViewThemeParam('sGooglePlusUrl')}]">
                                          <i class="fa fa-google-plus-square"></i> <span>Google+</span>
                                       </a>
                                    </li>
                                 [{/if}]
                                 [{if $oViewConf->getViewThemeParam('sTwitterUrl')}]
                                    <li>
                                       <a target="_blank" href="[{$oViewConf->getViewThemeParam('sTwitterUrl')}]">
                                          <i class="fa fa-twitter"></i> <span>Twitter</span>
                                       </a>
                                    </li>
                                 [{/if}]
                                 [{if $oViewConf->getViewThemeParam('sYouTubeUrl')}]
                                    <li>
                                       <a target="_blank" href="[{$oViewConf->getViewThemeParam('sYouTubeUrl')}]">
                                          <i class="fa fa-youtube-square"></i> <span>YouTube</span>
                                       </a>
                                    </li>
                                 [{/if}]
                                 [{if $oViewConf->getViewThemeParam('sBlogUrl')}]
                                    <li>
                                       <a target="_blank" href="[{$oViewConf->getViewThemeParam('sBlogUrl')}]">
                                          <i class="fa fa-wordpress"></i> <span>Blog</span>
                                       </a>
                                    </li>
                                 [{/if}]
                              [{/block}]
                           </ul>
                        [{/block}]
                     </section>
                  [{/if}]
               [{/block}]
               [{* <<ENDE>> Social Links *}]
            </div>
            <div class="col-xs-12"><hr/></div>
            [{block name="dd_footer_servicelist"}]
               <section class="col-xs-12 col-sm-[{$colSm}] footer-box footer-box-service">
                  <div class="h4 footer-box-title">[{oxmultilang ident="SERVICES"}]</div>
                  <div class="footer-box-content">
                     [{block name="dd_footer_servicelist_inner"}]
                        [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1 force_sid=$force_sid}]
                     [{/block}]
                  </div>
               </section>
            [{/block}]
            [{block name="dd_footer_information"}]
               <section class="col-xs-12 col-sm-[{$colSm}] footer-box footer-box-information">
                  <div class="h4 footer-box-title">[{oxmultilang ident="INFORMATION"}]</div>
                  <div class="footer-box-content">
                     [{block name="dd_footer_information_inner"}]
                        [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1 force_sid=$force_sid}]
                     [{/block}]
                  </div>
               </section>
            [{/block}]
            [{if $oViewConf->getViewThemeParam('blFooterManufacturer')}]
               [{block name="dd_footer_manufacturerlist"}]
                  <section class="col-xs-12 col-sm-[{$colSm}] footer-box footer-box-manufacturers">
                     <div class="h4 footer-box-title">[{oxmultilang ident="OUR_BRANDS"}]</div>
                     <div class="footer-box-content">
                        [{block name="dd_footer_manufacturerlist_inner"}]
                           [{oxid_include_widget cl="oxwManufacturerList" _parent=$oView->getClassName() noscript=1 nocookie=1}]
                        [{/block}]
                     </div>
                  </section>
               [{/block}]
            [{/if}]
            [{if $oViewConf->getViewThemeParam('blFooterCattree')}]
               [{block name="dd_footer_categorytree"}]
                  <section class="col-xs-12 col-sm-[{$colSm}] footer-box footer-box-categories">
                     <div class="h4 footer-box-title">[{oxmultilang ident="CATEGORIES"}]</div>
                     <div class="footer-box-content">
                        [{block name="dd_footer_categorytree_inner"}]
                           [{oxid_include_widget cl="oxwCategoryTree" _parent=$oView->getClassName() sWidgetType="footer" noscript=1 nocookie=1}]
                        [{/block}]
                     </div>
                  </section>
               [{/block}]
            [{/if}]
            <div class="col-xs-12 col-sm-[{$colSm}]">
               [{if $oView->showNewsletter()}]
                  <section class="footer-box footer-box-newsletter">
                     <div class="h4 footer-box-title">[{oxmultilang ident="NEWSLETTER"}]</div>
                     <div class="footer-box-content">
                        [{block name="dd_footer_newsletter"}]
                           <p class="small">[{oxmultilang ident="FOOTER_NEWSLETTER_INFO"}]</p>
                           [{include file="widget/footer/newsletter.tpl"}]
                        [{/block}]
                     </div>
                  </section>
               [{/if}]
               [{if ($oView->isActive('FbLike') && $oViewConf->getFbAppId())}]
                  <section class="footer-box footer-box-facebook">
                     [{block name="footer_fblike"}]
                        [{if $oView->isActive('FbLike') && $oViewConf->getFbAppId()}]
                           <div class="facebook pull-left" id="footerFbLike">
                              [{include file="widget/facebook/enable.tpl" source="widget/facebook/like.tpl" ident="#footerFbLike" parent="footer"}]
                           </div>
                        [{/if}]
                     [{/block}]
                  </section>
               [{/if}]
            </div>
         </div>
      </div>
   </footer>
   <div class="spacer"></div>
   <div class="legal">
      <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">
         <div class="legal-box">
            <div class="row">
               <section class="col-sm-12">
                  [{block name="sidebar_trustedshopsratings"}]
                     [{block name="dd_footer_servicelist_trustedshopsratings"}]
                        [{if $oViewConf->showTs("WIDGET") }]
                           [{include file="widget/trustedshops/ratings.tpl" }]
                        [{/if}]
                     [{/block}]
                  [{/block}]

                  [{block name="dd_footer_copyright"}]
                     [{oxifcontent ident="oxstdfooter" object="oCont"}]
                     [{$oCont->oxcontents__oxcontent->value}]
                     [{/oxifcontent}]
                  [{/block}]
               </section>
            </div>
         </div>
      </div>

   </div>
[{/block}]

[{if $oView->isRootCatChanged()}]
   <div id="scRootCatChanged" class="popupBox corners FXgradGreyLight glowShadow">
      [{include file="form/privatesales/basketexcl.tpl"}]
   </div>
[{/if}]