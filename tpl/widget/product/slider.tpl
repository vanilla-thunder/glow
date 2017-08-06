[{assign var="type" value=$type|default:"infogrid"}]

<div id="[{$listId}]" class="boxwrapper">
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


   <div class="slider">
      [{foreach from=$products item="_product" name="productlist"}]
         [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
         <div>
            [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$smarty.foreach.productlist.iteration blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
         </div>
      [{/foreach}]
   </div>
    <br>
    [{oxscript add="\$('#$listId .slider').slick({ arrows: true, dots:true, slidesToShow: 4, responsive: [
                {
                    breakpoint: 1200,
                    settings: { slidesToShow: 3 }
                },{
                    breakpoint: 800,
                    settings: { slidesToShow: 2 }
                },{
                    breakpoint: 560,
                    settings: { slidesToShow: 1 }
                }
            ]
        });"}]
</div>