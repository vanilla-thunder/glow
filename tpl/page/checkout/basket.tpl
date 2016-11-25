[{capture append="oxidBlock_content"}]
   [{assign var="currency" value=$oView->getActCurrency()}]
   [{include file="page/checkout/inc/steps.tpl" active=1}]

   [{block name="checkout_basket_main"}]

      [{if $oView->isLowOrderPrice()}]
         [{block name="checkout_basket_loworderprice_top"}]
            <div class="alert alert-info">[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</div>
            <div class="spacer"></div>
         [{/block}]
      [{/if}]

      <hr/>
      <div class="spacer"></div>

      [{if !$oxcmp_basket->getProductsCount()}]
         [{block name="checkout_basket_emptyshippingcart"}]
            <div class="alert alert-danger text-center" id="empty-basket-warning">
               [{oxmultilang ident="BASKET_EMPTY"}]<br/><br/>
               <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]" class="btn btn-default">
                  <i class="fa fa-caret-left"></i> [{oxmultilang ident="DD_BASKET_BACK_TO_SHOP"}]</a>
            </div>
         [{/block}]
      [{else}]

         [{block name="checkout_basket_next_step_top"}]
            [{*
            <div class="clearfix">
               [{block name="checkout_basket_backtoshop_top"}]
                  [{if $oView->showBackToShop()}]
                     <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
                        <div class="hidden">
                           [{$oViewConf->getHiddenSid()}]
                           <input type="hidden" name="cl" value="basket">
                           <input type="hidden" name="fnc" value="backtoshop">
                        </div>
                        <button type="submit" class="btn btn-default pull-left">
                           <i class="fa fa-caret-left"></i> [{oxmultilang ident="CONTINUE_SHOPPING"}]
                        </button>
                     </form>
                  [{else}]
                     <a href="[{$oViewConf->getHomeLink()}]" class="btn btn-default pull-left">
                        <i class="fa fa-caret-left"></i> [{oxmultilang ident="CONTINUE_SHOPPING"}]
                     </a>
                  [{/if}]
               [{/block}]

                [{if !$oView->isLowOrderPrice()}]
                  [{block name="basket_btn_next_top"}]
                     <form action="[{$oViewConf->getSslSelfLink()}]" method="post" class="pull-right">
                        <div class="hidden">
                           [{$oViewConf->getHiddenSid()}]
                           <input type="hidden" name="cl" value="user">
                        </div>
                        <button type="submit" class="btn btn-primary submitButton largeButton nextStep pull-right">
                           [{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}] <i class="fa fa-caret-right"></i>
                        </button>
                     </form>
                  [{/block}]
               [{/if}]

            </div>
         <hr/>
       *}]
         [{/block}]

         <div class="lineBox">
            [{include file="page/checkout/inc/basketcontents.tpl" editable=true }]
         </div>

         [{block name="checkout_basket_loworderprice_bottom"}][{/block}]

         [{block name="checkout_basket_next_step_bottom"}]
            <div class="cart-buttons">
               [{if !$oView->isLowOrderPrice()}]
                  [{block name="basket_btn_next_bottom"}]
                     <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
                        <div class="hidden">
                           [{$oViewConf->getHiddenSid()}]
                           <input type="hidden" name="cl" value="user">
                        </div>
                        <p>
                           <button type="submit" class="btn btn-success btn-lg submitButton largeButton nextStep pull-right">
                              [{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}] <i class="fa fa-caret-right"></i>
                           </button>
                        <div class="clearfix"></div>
                        </p>
                     </form>
                  [{/block}]
               [{/if}]
            </div>
         [{/block}]
      [{/if}]
      [{if $oView->isWrapping()}]
         [{include file="page/checkout/inc/wrapping.tpl"}]
      [{/if}]
   [{/block}]
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl"}]