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
                    [{block name="dd_header_search_button"}]
                        <span class="input-group-btn">
                  <button type="submit" class="btn btn-default" title="[{oxmultilang ident="SEARCH_SUBMIT"}]"><i class="fa fa-search"></i></button>
                </span>
                    [{/block}]
                </div>
            [{/block}]
        </form>
    [{/if}]
[{/block}]