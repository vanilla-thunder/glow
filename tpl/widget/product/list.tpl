[{assign var="type" value=$type|default:"infogrid"}]

[{if $type == 'infogrid'}]
   [{assign var="size" value=$size|default:"col-xs-12 col-sm-6"}]
[{elseif $type == 'grid'}]
   [{assign var="size" value=$size|default:"col-xs-12 col-sm-4"}]
[{elseif $type == 'line'}]
   [{assign var="size" value=$size|default:"col-xs-12"}]
[{elseif $type == 'mini'}]
   [{math equation="12/x" x=$products|count assign="sm"}]
   [{assign var="size" value=$size|default:"col-xs-12 col-sm-`$sm`"}]
[{/if}]

<div class="boxwrapper" id="boxwrapper_[{$listId}]">
   [{if $head}]
      <div class="page-header">
         [{if $header == "light"}]
            <span class="h3">[{$head}]</span>
         [{else}]
            <h2>
               [{$head}]
               [{if $rsslink}]
                  <a class="rss" id="[{$rssId}]" href="[{$rsslink.link}]" target="_blank">
                     <i class="fa fa-rss"></i>
                  </a>
               [{/if}]
            </h2>
         [{/if}]
         [{if $subhead}]
            <small class="subhead">[{$subhead}]</small>
         [{/if}]
      </div>
   [{/if}]


   <div class="list-container" id="[{$listId}]">
      [{foreach from=$products item="_product" name="productlist"}]
         [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
         <div class="[{$type}] [{$size}] productBox">
            [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
         </div>
      [{/foreach}]
   </div>
   [{if $type !== "line"}][{oxscript add='$(".panel-body","#'|cat:$listId|cat:'").matchHeight();'}][{/if}]
</div>