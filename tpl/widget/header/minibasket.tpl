<a class="dropdown-toggle" data-toggle="dropdown" href="#" data-href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]">
   [{block name="dd_layout_page_header_icon_menu_minibasket_button"}]
      <i class="fa fa-shopping-cart" aria-hidden="true"></i>
      [{if $oxcmp_basket->getItemsCount() > 0}][{ $oxcmp_basket->getItemsCount() }][{/if}]
   [{/block}]
</a>
<ul class="dropdown-menu dropdown-menu-right pull-right" role="menu">
   [{block name="dd_layout_page_header_icon_menu_minibasket_list"}]
      <li>
         <div class="row">
            <div class="col-xs-12 pull-right">
               <div class="minibasket-menu-box">
                  [{oxid_include_dynamic file="widget/minibasket/minibasket.tpl"}]
               </div>
            </div>
         </div>
      </li>
   [{/block}]
</ul>
