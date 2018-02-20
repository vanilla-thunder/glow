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

                    <ul class="nav navbar-nav navbar-right hidden-xs">
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

                            [{foreach from=$oxcmp_categories item="oTopCat" key="catkey" name="root"}]

                                [{* cms Seiten vor der Kategorie *}]
                                [{foreach from=$oTopCat->getContentCats() item="oTopCont" name="MoreTopCms"}]
                                    <li [{if $cl == 'content' && $cms == $oTopCont->getId()}]class="active"[{/if}]>
                                        <a href="[{$oTopCont->getLink()}]">[{$oTopCont->oxcontents__oxtitle->value}]</a>
                                    </li>
                                [{/foreach}]

                                [{if $oTopCat->getIsVisible()}]
                                    <li class="[{if $oTopCat->expanded && $cat == $catkey}]active[{/if}][{if $oTopCat->getSubCats()}] dropdown[{/if}]">
                                        <a [{if $oTopCat->getSubCats()}]href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"
                                           [{else}]href="[{$oTopCat->getLink()}]"[{/if}]>
                                            [{if $oTopCat->getIconUrl()}]
                                                <img src="[{$oTopCat->getIconUrl()}]" style="max-height:50px; margin: -8px 0;"/>
                                            [{else}]
                                                [{$oTopCat->oxcategories__oxtitle->value}][{if $oTopCat->getSubCats()}]&nbsp;<i class="fa fa-angle-down"></i>[{/if}]
                                            [{/if}]
                                        </a>
                                        
                                        [{* Unterkategorien Dropdown *}]
                                        [{if $oTopCat->getSubCats()}]
                                            <ul class="dropdown-menu">
                                                [{foreach from=$oTopCat->getSubCats() item="oSubCat" key="subcatkey" name="SubCat"}]
                                                    [{foreach from=$oSubCat->getContentCats() item=oSubCont name=MoreCms}]
                                                        <li>
                                                            <a href="[{$oSubCont->getLink()}]">[{$oSubCont->oxcontents__oxtitle->value}]</a>
                                                        </li>
                                                    [{/foreach}]

                                                    [{if $oSubCat->getIsVisible()}]
                                                        <li [{if $oSubCat->expanded && $cat == $subcatkey }]class="active"[{/if}]>
                                                            <a [{if $oSubCat->expanded}]class="current"[{/if}] href="[{$oSubCat->getLink()}]">[{$oSubCat->oxcategories__oxtitle->value}]</a>
                                                        </li>

                                                        [{* Unter-Unterkategorien Auflistung*}]
                                                        [{assign var="deepcatlvl" value=0}]
                                                        [{defun name="deepcats" _cat=$oSubCat}]
                                                            [{assign var="deepcatlvl" value=$deepcatlvl+1}]
                                                            [{if $_cat->getSubCats()}]
                                                                [{foreach from=$_cat->getSubCats() item="_subCat" key="subsubcatkey" name="SubSubCat"}]
                                                                    [{if $_subCat->getIsVisible()}]
                                                                        <li [{if $_subCat->expanded && $cat == $subsubcatkey}]class="active"[{/if}]>
                                                                            <!-- [{$_subCat|@var_dump}]-->
                                                                            <a [{if $_subCat->expanded}]class="current"[{/if}] href="[{$_subCat->getLink()}]">
                                                                                [{oxmultilang ident="GLOW_MENULVL_"|cat:$deepcatlvl}][{$_subCat->oxcategories__oxtitle->value}]
                                                                            </a>
                                                                        </li>
                                                                        [{if $deepcatlvl < 4}][{fun name="deepcats" _cat=$_subCat}][{/if}]
                                                                    [{/if}]
                                                                [{/foreach}]
                                                            [{/if}]
                                                        [{/defun}]
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