[{if $oxcmp_basket->getProductsCount() gte 5}]
   [{assign var="blScrollable" value=true}]
[{/if}]

[{block name="widget_minibasket"}]
   [{assign var="currency" value=$oView->getActCurrency()}]

   [{capture name="minibasketcontents"}]
      [{if $oxcmp_basket->getProductsCount()}]
         <div id="[{$_prefix}]basketFlyout" class="basketFlyout">
            <div class="">
               <table class="table table-striped">
                  <thead>
                  <tr>
                     <th>[{oxmultilang ident="DD_MINIBASKET_MODAL_TABLE_TITLE"}]</th>
                     <th class="text-right">[{oxmultilang ident="DD_MINIBASKET_MODAL_TABLE_PRICE"}]</th>
                  </tr>
                  </thead>
                  <tbody>
                  [{foreach from=$oxcmp_basket->getContents() name=miniBasketList item=_product}]
                     [{block name="widget_minibasket_product"}]
                        [{assign var="minibasketItemTitle" value=$_product->getTitle()}]
                        <tr>
                           <td>
                              <a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">
                                 <span class="item">[{if $_product->getAmount() > 1}][{$_product->getAmount()}]&times; [{/if}][{$minibasketItemTitle|strip_tags}]</span>
                              </a>
                           </td>
                           <td class="text-right">
                              [{oxprice price=$_product->getPrice() currency=$currency}]<em>*</em>
                           </td>
                        </tr>
                     [{/block}]
                  [{/foreach}]
                  </tbody>
                  <tfoot>
                  <tr>
                     [{block name="widget_minibasket_total"}]
                        <td><strong>[{oxmultilang ident="TOTAL" suffix="COLON"}]</strong></td>
                        <td class="text-right">
                           <strong class="price">
                              [{if $oxcmp_basket->isPriceViewModeNetto()}]
                                 [{$oxcmp_basket->getProductsNetPrice()}]
                              [{else}]
                                 [{$oxcmp_basket->getFProductsPrice()}]
                              [{/if}]
                              [{$currency->sign}]<em>*</em>
                           </strong>
                        </td>
                     [{/block}]
                  </tr>
                  </tfoot>
               </table>
            </div>
            [{include file="widget/minibasket/countdown.tpl"}]
         </div>
      [{else}]
         [{block name="widget_minibasket_empty"}]
            <div class="alert alert-info">[{oxmultilang ident="BASKET_EMPTY"}]</div>
         [{/block}]
      [{/if}]
   [{/capture}]

   [{if $_prefix == 'modal' || $_prefix == 'popup'}]
      <div class="modal fade basketFlyout" id="basketModal" tabindex="-1" role="dialog" aria-labelledby="basketModalLabel">
         <div class="modal-dialog">
            <div class="modal-content">
               [{if $oxcmp_basket->getProductsCount()}]
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">[{oxmultilang ident="CLOSE"}]</span></button>
                     [{block name="widget_minibasket_modal_title"}]
                        <h4 class="modal-title" id="basketModalLabel">[{$oxcmp_basket->getItemsCount()}] [{oxmultilang ident="ITEMS_IN_BASKET"}]</h4>
                     [{/block}]
                  </div>
               [{/if}]
               <div class="modal-body">

                  [{$smarty.capture.minibasketcontents}]

               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">[{oxmultilang ident="DD_MINIBASKET_CONTINUE_SHOPPING"}]</button>
                  [{if $oxcmp_basket->getItemsCount() > 0}]
                     <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="[{oxmultilang ident="DISPLAY_BASKET"}]">
                        <i class="fa fa-shopping-cart"></i>
                     </a>
                  [{/if}]
               </div>
            </div>
         </div>
      </div>
      [{if $_prefix == 'modal'}][{oxscript add="$('#basketModal').modal('show');"}][{/if}]
   [{else}]
      [{block name="widget_minibasket_dropdown_title"}]
         <p class="title">
            <strong>[{$oxcmp_basket->getItemsCount()}] [{oxmultilang ident="ITEMS_IN_BASKET"}]</strong>
         </p>
      [{/block}]
      <div id="[{$_prefix}]basketFlyout" class="basketFlyout[{if $blScrollable}] scrollable[{/if}]">
         [{block name="dd_layout_page_header_icon_menu_minibasket_table"}]

            [{$smarty.capture.minibasketcontents}]

            [{*
            <table class="table table-bordered table-striped">
               [{foreach from=$oxcmp_basket->getContents() name=miniBasketList item=_product}]
                  [{block name="widget_minibasket_product"}]
                     [{assign var="minibasketItemTitle" value=$_product->getTitle()}]
                     <tr>
                        <td class="picture text-center">
                           <span class="badge">[{$_product->getAmount()}]</span>
                           <a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">
                              <img src="[{$_product->getIconUrl()}]" alt="[{$minibasketItemTitle|strip_tags}]"/>
                           </a>
                        </td>
                        <td class="title">
                           <a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">[{$minibasketItemTitle|strip_tags}]</a>
                        </td>
                        <td class="price text-right">[{$_product->getFTotalPrice()}]&nbsp;[{$currency->sign}]</td>
                     </tr>
                  [{/block}]
               [{/foreach}]
               <tr>
                  <td class="total_label" colspan="2">
                     <strong>[{oxmultilang ident="TOTAL"}]</strong>
                  </td>
                  <td class="total_price text-right">
                     <strong>
                        [{if $oxcmp_basket->isPriceViewModeNetto()}]
                           [{$oxcmp_basket->getProductsNetPrice()}]
                        [{else}]
                           [{$oxcmp_basket->getFProductsPrice()}]
                        [{/if}]
                        &nbsp;[{$currency->sign}]
                     </strong>
                  </td>
               </tr>
            </table>
            *}]
         [{/block}]
      </div>
      [{include file="widget/minibasket/countdown.tpl"}]

      [{if $oxcmp_basket->getItemsCount() > 0}]
         [{block name="widget_minibasket_dropdown_functions"}]
            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" class="btn btn-success btn-block">[{oxmultilang ident="DISPLAY_BASKET"}]</a>
         [{/block}]
      [{/if}]
   [{/if}]
[{/block}]