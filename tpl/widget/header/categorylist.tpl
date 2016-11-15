[{block name="dd_widget_header_categorylist"}]
   [{if $oxcmp_categories}]
      [{assign var="cl" value=$oViewConf->getTopActionClassName()}]
      [{assign var="cat" value=$oViewConf->getActCatId() }]
      [{assign var="cms" value=$oViewConf->getContentId()}]
      <nav id="mainnav" class="navbar navbar-default container" role="navigation" data-spy="affix" data-offset-top="147" data-offset-bottom="200">

         [{block name="dd_widget_header_categorylist_navbar_list"}]
            <div class="navbar-header">
               [{block name="dd_widget_header_categorylist_navbar_header"}]
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                     <i class="fa fa-bars fa-fw" aria-hidden="true"></i>
                  </button>
                  <span class="visible-xs-inline" data-toggle="collapse" data-target=".navbar-ex1-collapse">[{oxmultilang ident="DD_ROLES_BEMAIN_UIROOTHEADER"}]</span>
               [{/block}]

               <button type="button" class="navbar-toggle" data-toggle="dropdown" data-target=".minibasket-menu-box">
                     <i class="fa fa-shopping-cart fa-fw" aria-hidden="true"></i>
                     [{if $oxcmp_basket->getItemsCount() > 0}][{ $oxcmp_basket->getItemsCount() }][{/if}]
               </button>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
               <ul id="navigation" class="nav navbar-nav">
                  [{block name="dd_widget_header_categorylist_navbar_list"}]
                     <li [{if $cl == 'start'}]class="active"[{/if}]>
                        <a href="[{$oViewConf->getHomeLink()}]">[{oxmultilang ident="HOME"}]</a>
                     </li>
                     [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]

                        [{if $ocat->getIsVisible()}]

                           [{foreach from=$ocat->getContentCats() item="oTopCont" name="MoreTopCms"}]
                              <li [{if $cl == 'content' && $cms == $oTopCont->getId()}]class="active"[{/if}]>
                                 <a href="[{$oTopCont->getLink()}]">[{$oTopCont->oxcontents__oxtitle->value}]</a>
                              </li>
                           [{/foreach}]
                           <li class="[{if $homeSelected == 'false' && $ocat->expanded}]active[{/if}][{if $ocat->getSubCats()}] dropdown[{/if}]">
                              <a href="[{$ocat->getLink()}]"[{if $ocat->getSubCats()}] class="dropdown-toggle" data-toggle="dropdown"[{/if}]>
                                 [{$ocat->oxcategories__oxtitle->value}][{if $ocat->getSubCats()}]&nbsp;<i class="fa fa-angle-down"></i>[{/if}]
                              </a>

                              [{if $ocat->getSubCats()}]
                                 <ul class="dropdown-menu">
                                    [{foreach from=$ocat->getSubCats() item="osubcat" key="subcatkey" name="SubCat"}]
                                       [{if $osubcat->getIsVisible()}]
                                          [{foreach from=$osubcat->getContentCats() item=ocont name=MoreCms}]
                                             <li>
                                                <a href="[{$ocont->getLink()}]">[{$ocont->oxcontents__oxtitle->value}]</a>
                                             </li>
                                          [{/foreach}]

                                          [{if $osubcat->getIsVisible()}]
                                             <li [{if $homeSelected == 'false' && $osubcat->expanded}]class="active"[{/if}]>
                                                <a [{if $homeSelected == 'false' && $osubcat->expanded}]class="current"[{/if}] href="[{$osubcat->getLink()}]">[{$osubcat->oxcategories__oxtitle->value}]</a>
                                             </li>
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

               [{block name="widget_header_search_form"}]
                  [{if $oView->showSearch()}]
                     <form class="navbar-form navbar-right" role="form" action="[{$oViewConf->getSelfActionLink()}]" method="get" name="search">
                        [{$oViewConf->getHiddenSid()}]
                        <input type="hidden" name="cl" value="search">
                        [{block name="dd_widget_header_search_form_inner"}]
                           <div class="input-group">
                              [{block name="header_search_field"}]
                                 <input type="text" class="form-control" value="[{$oView->getSearchParamForHtml()}]" placeholder="[{oxmultilang ident="SEARCH"}]" id="searchParam" name="searchparam">
                              [{/block}]
                              <span class="input-group-btn">
                                 [{block name="dd_header_search_button"}]
                                    <button type="submit" class="btn btn-default" title="[{oxmultilang ident="SEARCH_SUBMIT"}]"><i class="fa fa-search"></i></button>
                                 [{/block}]
                              </span>
                           </div>
                        [{/block}]
                     </form>
                  [{/if}]
               [{/block}]
               <ul class="nav navbar-nav navbar-right fixed-header-actions">

                  <li>
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" rel="nofollow">
                        <i class="fa fa-shopping-cart"></i>
                        [{if $oxcmp_basket->getItemsCount() > 0}][{$oxcmp_basket->getItemsCount()}][{/if}]
                     </a>
                  </li>

                  <li>
                     <a href="javascript:void(null)" class="search-toggle" rel="nofollow">
                        <i class="fa fa-search"></i>
                     </a>
                  </li>

               </ul>

               [{if $oView->isDemoShop()}]
                  <a href="[{$oViewConf->getBaseDir()}]admin/" class="btn btn-sm btn-danger navbar-btn navbar-right visible-lg">
                     [{oxmultilang ident="DD_DEMO_ADMIN_TOOL"}]
                     <i class="fa fa-external-link" style="font-size: 80%;"></i>
                  </a>
               [{/if}]

            </div>
         [{/block}]

      </nav>
   [{/if}]
[{/block}]