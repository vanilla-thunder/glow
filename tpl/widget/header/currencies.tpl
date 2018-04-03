[{if $oView->loadCurrency()}]
    [{assign var="currency" value=$oView->getActCurrency()}]

    <div class="col-xs-6 btn-group">
        <button type="button" class="btn btn-link btn-block dropdown-toggle" data-toggle="dropdown">
            [{block name="dd_layout_page_header_icon_menu_currencies_button"}]
                [{$currency->name}]
            [{/block}]
        </button>
        <ul class="dropdown-menu dropdown-menu-right" role="menu">
            [{block name="dd_layout_page_header_icon_menu_currencies_list"}]
                [{foreach from=$oxcmp_cur item=_cur}]
                    [{if !$_cur->selected}]
                    <li>
                        <a href="[{$_cur->link|oxaddparams:$oView->getDynUrlParams()}]" title="[{$_cur->name}]">
                            [{$_cur->name}]
                        </a>
                    </li>
                    [{/if}]
                [{/foreach}]
            [{/block}]
        </ul>
    </div>
[{/if}]