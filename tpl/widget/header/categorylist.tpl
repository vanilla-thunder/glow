[{block name="dd_widget_header_categorylist"}]
   [{if $oxcmp_categories}]
      <nav id="mainmenu" class="navbar navbar-default" role="navigation" [{* data-spy="affix" data-offset-top="147" data-offset-bottom="200" *}]>

         [{block name="dd_widget_header_categorylist_navbar_list"}]
            <div class="navbar-header">
               [{block name="header_categorylist_logo"}]
                  <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]" class="pull-left visible-xs navbar-brand">
                     <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/'|cat:$oViewConf->getViewThemeParam('sLogoFile')}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]" style="height: 30px;">
                  </a>
               [{/block}]

               [{block name="dd_widget_header_categorylist_navbar_header"}]
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainmenu-collapse">
                     <i class="fa fa-bars fa-fw" aria-hidden="true"></i>
                  </button>
               [{/block}]

               <button type="button" class="navbar-toggle" data-toggle="modal" data-target="#basketModal">
                  <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i>
                  [{if $oxcmp_basket->getItemsCount() > 0}][{ $oxcmp_basket->getItemsCount() }][{/if}]
               </button>
               [{ oxid_include_dynamic file="widget/minibasket/minibasket.tpl" prefix="popup" }]
            </div>
            <div class="collapse navbar-collapse" id="mainmenu-collapse">


               <ul class="nav navbar-nav navbar-right">
                  <li class="minibasket-menu">
                     [{ oxid_include_widget cl="oxwMiniBasket" prefix="dropdown" nocookie=$blAnon force_sid=$force_sid }]
                  </li>
               </ul>

               [{include file="widget/header/search.tpl"}]

               [{* logik für aktive Katerie / cms Seite *}]
               [{assign var="cl" value=$oViewConf->getTopActionClassName()}]
               [{assign var="cat" value=$oViewConf->getActCatId() }]
               [{assign var="cms" value=$oViewConf->getContentId()}]

               <ul id="categories" class="nav navbar-nav">
                  [{block name="dd_widget_header_categorylist_navbar_list"}]
                     [{* <li [{if $cl == 'start'}]class="active"[{/if}]><a href="[{$oViewConf->getHomeLink()}]">[{oxmultilang ident="HOME"}]</a></li> *}]

                     [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]

                        [{* cms Seiten vor der Kategorie *}]
                        [{foreach from=$ocat->getContentCats() item="oTopCont" name="MoreTopCms"}]
                           <li [{if $cl == 'content' && $cms == $oTopCont->getId()}]class="active"[{/if}]>
                              <a href="[{$oTopCont->getLink()}]">[{$oTopCont->oxcontents__oxtitle->value}]</a>
                           </li>
                        [{/foreach}]

                        [{if $ocat->getIsVisible()}]
                           <li class="[{if $ocat->expanded}]active[{/if}][{if $ocat->getSubCats()}] dropdown[{/if}]">
                              <a [{if $ocat->getSubCats()}]href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" [{else}]href="[{$ocat->getLink()}]"[{/if}]>
                                 [{$ocat->oxcategories__oxtitle->value}][{if $ocat->getSubCats()}]&nbsp;<i class="fa fa-angle-down"></i>[{/if}]
                              </a>

                              [{* Unterkategorien Dropdown *}]
                              [{if $ocat->getSubCats()}]
                                 <ul class="dropdown-menu">
                                    [{foreach from=$ocat->getSubCats() item="osubcat" key="subcatkey" name="SubCat"}]
                                       [{foreach from=$osubcat->getContentCats() item=ocont name=MoreCms}]
                                          <li>
                                             <a href="[{$ocont->getLink()}]">[{$ocont->oxcontents__oxtitle->value}]</a>
                                          </li>
                                       [{/foreach}]

                                       [{if $osubcat->getIsVisible()}]
                                          <li [{if $osubcat->expanded}]class="active"[{/if}]>
                                             <a [{if $osubcat->expanded}]class="current"[{/if}] href="[{$osubcat->getLink()}]">[{$osubcat->oxcategories__oxtitle->value}]</a>
                                          </li>
                                          [{* Unter-Unterkategorien Auflistung*}]
                                          [{if $osubcat->getSubCats()}]
                                             [{foreach from=$osubcat->getSubCats() item="osubsubcat" key="subsubcatkey" name="SubSubCat"}]
                                                [{if $osubsubcat->getIsVisible()}]
                                                   <li [{if $osubsubcat->expanded}]class="active"[{/if}]>
                                                      <a [{if $osubsubcat->expanded}]class="current"[{/if}] href="[{$osubsubcat->getLink()}]"> - [{$osubsubcat->oxcategories__oxtitle->value}]</a>
                                                   </li>
                                                   [{foreach from=$osubcat->getSubCats() item="osubsubcat" key="subcatkey"}]
                                                      [{if $osubsubcat->getIsVisible()}]
                                                         <li [{if $homeSelected == 'false' && $osubsubcat->expanded}]class="active"[{/if}]>
                                                            <a [{if $homeSelected == 'false' && $osubsubcat->expanded}]class="current"[{/if}] href="[{$osubsubcat->getLink()}]"><i class="fa fa-angle-right fa-fw"></i> [{$osubsubcat->oxcategories__oxtitle->value}]</a>
                                                         </li>
                                                      [{/if}]
                                                   [{/foreach}]
                                                [{/if}]
                                             [{/foreach}]
                                          [{/if}]
                                       [{/if}]
                                    [{/foreach}]
                                 </ul>
                              [{/if}]
                           </li>
                        [{/if}]
                     [{/foreach}]
                  [{/block}]
               </ul>

               <!--
               [{if $oView->isDemoShop()}]
                  <a href="[{$oViewConf->getBaseDir()}]admin/" class="btn btn-sm btn-danger navbar-btn navbar-right visible-lg">
                     [{oxmultilang ident="DD_DEMO_ADMIN_TOOL"}]
                     <i class="fa fa-external-link" style="font-size: 80%;"></i>
                  </a>
               [{/if}]
-->

            </div>
         [{/block}]

      </nav>
   [{/if}]
[{/block}]