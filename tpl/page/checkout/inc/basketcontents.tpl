[{assign var="currency" value=$oView->getActCurrency()}]
<form name="basket[{$basketindex}]" id="basket_form" action="[{$oViewConf->getSelfActionLink()}]#wrapper" method="post">
   [{$oViewConf->getHiddenSid()}]
   <input type="hidden" name="cl" value="basket">
   <input type="hidden" name="fnc" value="changebasket">
   <input type="hidden" name="CustomError" value="basket">

   <div class="[{$oViewConf->getActiveClassName()}]Items">
      [{assign var="basketitemlist" value=$oView->getBasketArticles()}]
      [{foreach from=$oxcmp_basket->getContents() item=basketitem key=basketindex name=basketContents }]
         <div class="row" id="item_[{$smarty.foreach.basketContents.iteration}]">

            [{block name="checkout_basketcontents_basketitem"}]
               [{assign var="basketproduct" value=$basketitemlist.$basketindex}]
               [{assign var="oArticle" value=$basketitem->getArticle()}] [{* TODO braucht man das? *}]
               [{assign var="oAttributes" value=$oArticle->getAttributesDisplayableInBasket()}]
               [{* product image *}]
               <div class="col-xs-3 col-sm-2">
                  [{block name="checkout_basketcontents_basketitem_image"}]
                     <a href="[{$basketitem->getLink()}]" class="thumbnail">
                        <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$basketitem->getIconUrl()}]" alt="[{$basketitem->getTitle()|strip_tags}]">
                     </a>
                  [{/block}]
               </div>
               [{* title + artnum + persparam + variants + sellist *}]
               <div class="col-xs-9 col-sm-5 col-md-5">
                  [{block name="checkout_basketcontents_basketitem_titlenumber"}]
                     [{if $editable}]<a rel="nofllow" href="[{$basketitem->getLink()}]">[{/if}]
                     <b>[{$basketitem->getTitle()}]</b>
                     [{if $editable}]</a>[{/if}]
                     [{if $basketitem->isSkipDiscount()}]
                        <sup>
                           <a href="#SkipDiscounts_link">**</a>
                        </sup>
                     [{/if}]
                     <br/>
                     <div class="small">
                        [{oxmultilang ident="PRODUCT_NO"}] [{$basketproduct->oxarticles__oxartnum->value}]<br/>
                        [{foreach from=$oAttributes->getArray() key="oArtAttributes" item="oAttr" name="attributeContents"}]
                           [{$oAttr->oxattribute__oxtitle->value}]: [{$oAttr->oxattribute__oxvalue->value}]
                           <br/>
                        [{/foreach}]

                        [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                           [{assign var="oSelections" value=$basketproduct->getSelections(null,$basketitem->getSelList())}]
                           [{if $oSelections}]
                              <div class="selectorsBox clear" id="cartItemSelections_[{$smarty.foreach.basketContents.iteration}]">
                                 [{foreach from=$oSelections item=oList name=selections}]
                                    [{if $oViewConf->showSelectListsInList()}]
                                       [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="aproducts[`$basketindex`][sel]" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                    [{else}]
                                       [{assign var="oActiveSelection" value=$oList->getActiveSelection()}]
                                       [{if $oActiveSelection}]
                                          <input type="hidden" name="aproducts[[{$basketindex}]][sel][[{$smarty.foreach.selections.index}]]" value="[{if $oActiveSelection }][{$oActiveSelection->getValue()}][{/if}]">
                                          <div>[{$oList->getLabel()}]: [{$oActiveSelection->getName()}]</div>
                                       [{/if}]
                                    [{/if}]
                                 [{/foreach}]
                              </div>
                           [{/if}]
                        [{/if}]

                        [{* persparams *}]
                        [{if !$editable}]
                           <p class="persparamBox">
                              <small>
                                 [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                    [{if !$smarty.foreach.persparams.first}]<br/>[{/if}]
                                    [{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}]
                                       [{oxmultilang ident="LABEL"}]
                                    [{else}]
                                       [{$sVar}] :
                                    [{/if}]
                                    [{$aParam}]
                                 [{/foreach}]
                              </small>
                           </p>
                        [{else}]
                           [{if $basketproduct->oxarticles__oxisconfigurable->value}]
                              [{if $basketitem->getPersParams()}]
                                 <br/>
                                 [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                    <p>
                                       <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][[{$sVar}]]" value="[{$aParam}]" placeholder="[{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}][{oxmultilang ident="LABEL"}][{else}][{$sVar}][{/if}]">
                                    </p>
                                 [{/foreach}]
                              [{else}]
                                 <p>
                                    <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][details]" value="" placeholder="[{oxmultilang ident="LABEL"}]">
                                 </p>
                              [{/if}]
                           [{/if}]
                        [{/if}]
                        [{if $basketproduct->getStockStatus() == -1 && $basketproduct->getDeliveryDate()}]
                           <div class="alert alert-danger text-center">[{oxmultilang ident="AVAILABLE_ON"}] [{$basketproduct->getDeliveryDate()}]</div>
                        [{/if}]
                     </div>
                     [{* product wrapping *}]
                     [{block name="checkout_basketcontents_basketitem_wrapping"}]
                        [{if $oView->isWrapping()}]
                           <p class="wrapping">
                              [{if $basketitem->getWrappingId()}]
                                 [{assign var="oWrap" value=$basketitem->getWrapping()}]
                                 [{oxmultilang ident="WRAPPING"}]: [{$oWrap->oxwrapping__oxname->value}] [{* ( [{oxprice price=$oWrap->getPrice() currency=$currency }] ) *}]
                              [{/if}]
                           </p>
                        [{/if}]
                     [{/block}]
                  [{/block}]
               </div>
               <div class="clearfix visible-xs-block"></div>
               [{* ppu + total price + vat % *}]
               <div class="col-xs-7 col-sm-3 col-md-3 col-md-push-2">
                  [{block name="checkout_basketcontents_basketitem_unitprice"}]
                     [{if $basketitem->getRegularUnitPrice()}]
                        <div class="regularUnitPrice text-right">
                           <strong>[{oxmultilang ident="UNIT_PRICE" suffix="COLON"}]</strong>
                           [{oxprice price=$basketitem->getRegularUnitPrice() currency=$currency}]
                        </div>
                     [{/if}]
                     [{if $basketitem->getUnitPrice() && $basketitem->getUnitPrice() != $basketitem->getRegularUnitPrice() }]
                        <div class="regularUnitPrice text-right">
                           <strong>[{oxmultilang ident="YOUR_PRICE" suffix="COLON"}]</strong>
                           [{oxprice price=$basketitem->getUnitPrice() currency=$currency}]
                        </div>
                     [{/if}]
                  [{/block}]
                  [{block name="checkout_basketcontents_basketitem_totalprice"}]
                     <div class="totalPrice text-right">
                        <strong>[{oxmultilang ident="TOTAL" suffix="COLON"}]</strong>
                        [{$basketitem->getFTotalPrice()}]&nbsp;[{$currency->sign}]
                     </div>
                  [{/block}]
                  [{block name="checkout_basketcontents_basketitem_vat"}]
                     <div class="vatPercent vatTotal small text-right">([{$basketitem->getVatPercent()}]% [{oxmultilang ident="VAT"}])</div>
                  [{/block}]
               </div>
               [{* product amount + remove btn *}]
               <div class="col-xs-5 col-sm-2 col-md-pull-3">
                  [{block name="checkout_basketcontents_basketitem_amount"}]
                     [{if $editable}]
                        <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$basketitem->getProductId()}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                        <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                        [{if $basketitem->isBundle()}]
                           <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                        [{/if}]

                        [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                           <p class="input-group">
                              <input id="amount_[{$smarty.foreach.basketContents.iteration}]" type="number" class="textbox form-control text-center"
                                     name="aproducts[[{$basketindex}]][am]" value="[{$basketitem->getAmount()}]" data-value="[{$basketitem->getAmount()}]" size="3" min="0" style="min-width:40px; padding: 5px; font-size: 125%;">
                              <span class="input-group-addon">
                                 [{if $basketitem->oxarticles__oxunitname->value}][{$basketitem->oxarticles__oxunitname->value}]
                                 [{else}][{oxmultilang ident="PCS"}][{/if}]
                              </span>
                           </p>
                           <button class="btn btn-warning col-xs-6" type="submit" name="updateBtn" title="[{oxmultilang ident="UPDATE"}]">
                              <i class="fa fa-refresh fa-lg fa-fw"></i>[{* oxmultilang ident="UPDATE" *}]
                           </button>
                           [{block name="checkout_basketcontents_basketitem_removecheckbox"}]
                              <input type="hidden" name="aproducts[[{$basketindex}]][remove]" id="aproducts_[{$basketindex}]_remove" value="0">
                              <button class="btn btn-danger col-xs-6" type="submit" name="removeBtn" title="[{oxmultilang ident="REMOVE"}]"
                                      onclick="document.getElementById( 'aproducts_[{$basketindex}]_remove' ).value = '1';">
                                 <i class="fa fa-trash-o fa-lg fa-fw" aria-hidden="true"></i>[{* oxmultilang ident="REMOVE" *}]
                              </button>
                           [{/block}]

                        [{/if}]
                     [{else}]
                        x [{$basketitem->getAmount()}]
                        [{if $basketitem->oxarticles__oxunitname->value}][{$basketitem->oxarticles__oxunitname->value}]
                        [{else}][{oxmultilang ident="PCS"}][{/if}]
                     [{/if}]
                     [{if $basketitem->getdBundledAmount() > 0 && ($basketitem->isBundle() || $basketitem->isDiscountArticle())}]
                        +[{$basketitem->getdBundledAmount()}]
                     [{/if}]
                  [{/block}]
               </div>
            [{/block}]

            [{* packing unit *}]
            [{block name="checkout_basketcontents_itemerror"}]
               [{foreach from=$Errors.basket item=oEr key=key}]
                  [{if $oEr->getErrorClassType() == 'oxOutOfStockException'}]
                     [{* display only the exceptions for the current article *}]
                     [{if $basketindex == $oEr->getValue('basketIndex')}]
                        <div class="alert alert-danger" role="alert">[{$oEr->getOxMessage()}] <strong>[{$oEr->getValue('remainingAmount')}]</strong></div>
                     [{/if}]
                  [{elseif $oEr->getErrorClassType() == 'oxArticleInputException'}]
                     [{if $basketitem->getProductId() == $oEr->getValue('productId')}]
                        <div class="alert alert-danger" role="alert">[{$oEr->getOxMessage()}]</div>
                     [{/if}]
                  [{/if}]
               [{/foreach}]
            [{/block}]
         </div>
         <hr/>
         [{*  basket items end  *}]
      [{/foreach}]

      [{block name="checkout_basketcontents_basketfunctions"}][{/block}]
   </div>

</form>


<div class="row">
   <div class="col-sm-6">
      [{block name="checkout_basketcontents_giftwrapping"}]
         [{if $oViewConf->getShowGiftWrapping()}]
            [{assign var="oCard" value=$oxcmp_basket->getCard()}]
            [{if $oCard}]
               <div class="media">
                  [{if $oCard->oxwrapping__oxpic->value}]
                     <div class="media-left">
                        <img class="media-object img-thumbnail" src="[{$oCard->getPictureUrl()}]" alt="[{$oCard->oxwrapping__oxname->value}]">
                     </div>
                  [{/if}]
                  <div class="media-body">
                     <h4 class="media-heading">
                        [{oxmultilang ident="GREETING_CARD"}] "<b>[{$oCard->oxwrapping__oxname->value}]</b>"
                        [{*( [{oxprice price=$oCard->getPrice() currency=$currency}] )*}]
                     </h4>
                     [{oxmultilang ident="YOUR_MESSAGE"}]:
                     <b>[{$oxcmp_basket->getCardMessage()|nl2br}]</b>
                     <div>
                        [{if $oxcmp_basket->isProportionalCalculationOn()}][{oxmultilang ident="PROPORTIONALLY_CALCULATED"}]
                        [{elseif $oxcmp_basket->getGiftCardCostVat()}][{$oxcmp_basket->getGiftCardCostVatPercent()}]%[{/if}]
                     </div>
                  </div>
               </div>
            [{/if}]
         [{/if}]
      [{/block}]

      [{if $editable && $oView->isWrapping()}]
         <p>
            <a href="#" class="btn btn-info btn-block" title="[{oxmultilang ident="ADD_WRAPPING"}]" data-toggle="modal" data-target="#giftoptions">
               <i class="fa fa-gift fa-fw fa-lg"></i> [{oxmultilang ident="ADD_WRAPPING"}]
            </a>
         </p>
      [{/if}]
      [{if $oViewConf->getShowVouchers() && $oViewConf->getActiveClassName() == 'basket'}]
         [{block name="checkout_basket_vouchers"}]
            <div id="basketVoucher">
               <form name="voucher" action="[{$oViewConf->getSelfActionLink()}]" method="post" class="form-horizontal" role="form" novalidate="novalidate" autocomplete="off">
                  <div class="hidden">
                     [{$oViewConf->getHiddenSid()}]
                     <input type="hidden" name="cl" value="basket">
                     <input type="hidden" name="fnc" value="addVoucher">
                     <input type="hidden" name="CustomError" value="basket">
                  </div>
                  <div class="form-group">

                     <div class="col-xs-7">
                        <label class="req sr-only" for="input_voucherNr">[{oxmultilang ident="ENTER_COUPON_NUMBER"}]</label>
                        <input type="text" name="voucherNr" size="30" class="form-control js-oxValidate js-oxValidate_notEmpty" id="input_voucherNr" placeholder="[{oxmultilang ident="REDEEM_COUPON"}]" required="required">
                     </div>
                     <div class="col-xs-5">
                        <button type="submit" class="btn btn-info btn-block"> [{oxmultilang ident="SUBMIT"}]</button>
                     </div>

                  </div>


                  [{foreach from=$Errors.basket item=oEr key=key}]
                     [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                        <div class="alert alert-danger">
                           [{oxmultilang ident="COUPON_NOT_ACCEPTED" args=$oEr->getValue('voucherNr')}]
                           <strong>[{oxmultilang ident="REASON" suffix="COLON"}]</strong>
                           [{$oEr->getOxMessage()}]
                        </div>
                     [{/if}]
                  [{/foreach}]
               </form>
            </div>
         [{/block}]
      [{/if}]
   </div>
   <div class="col-sm-6">


      [{block name="checkout_basketcontents_summary"}]
         <div id="" class="pull-right summary[{if $oViewConf->getActiveClassName() == 'order'}] orderSummary[{/if}]">
            [{*  basket summary  *}]
            <table class="table table-bordered table-striped">
               [{if !$oxcmp_basket->getDiscounts()}]
                  [{block name="checkout_basketcontents_nodiscounttotalnet"}]
                     <tr>
                        <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                        <td id="basketTotalProductsNetto">[{$oxcmp_basket->getProductsNetPrice()}]&nbsp;[{$currency->sign}]</td>
                     </tr>
                  [{/block}]

                  [{block name="checkout_basketcontents_nodiscountproductvats"}]
                     [{foreach from=$oxcmp_basket->getProductVats() item=VATitem key=key}]
                        <tr>
                           <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                           <td>[{$VATitem}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/foreach}]
                  [{/block}]

                  [{block name="checkout_basketcontents_nodiscounttotalgross"}]
                     <tr>
                        <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                        <td id="basketTotalProductsGross">[{$oxcmp_basket->getFProductsPrice()}]&nbsp;[{$currency->sign}]</td>
                     </tr>
                  [{/block}]
               [{else}]
                  [{if $oxcmp_basket->isPriceViewModeNetto()}]
                     [{block name="checkout_basketcontents_discounttotalnet"}]
                        <tr>
                           <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                           <td id="basketTotalProductsNetto">[{$oxcmp_basket->getProductsNetPrice()}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/block}]
                  [{else}]
                     [{block name="checkout_basketcontents_discounttotalgross"}]
                        <tr>
                           <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                           <td id="basketTotalProductsGross">[{$oxcmp_basket->getFProductsPrice()}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/block}]
                  [{/if}]

                  [{block name="checkout_basketcontents_discounts"}]
                     [{foreach from=$oxcmp_basket->getDiscounts() item=oDiscount name=test_Discounts}]
                        <tr>
                           <th>
                              <b>[{if $oDiscount->dDiscount < 0}][{oxmultilang ident="SURCHARGE"}][{else}][{oxmultilang ident="DISCOUNT"}][{/if}]&nbsp;</b>
                              [{$oDiscount->sDiscount}]
                           </th>
                           <td>
                              [{if $oDiscount->dDiscount < 0}][{$oDiscount->fDiscount|replace:"-":""}][{else}]-[{$oDiscount->fDiscount}][{/if}]&nbsp;[{$currency->sign}]
                           </td>
                        </tr>
                     [{/foreach}]
                  [{/block}]

                  [{if !$oxcmp_basket->isPriceViewModeNetto()}]
                     [{block name="checkout_basketcontents_totalnet"}]
                        <tr>
                           <th>[{oxmultilang ident="TOTAL_NET"}]</th>
                           <td id="basketTotalNetto">[{$oxcmp_basket->getProductsNetPrice()}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/block}]
                  [{/if}]

                  [{block name="checkout_basketcontents_productvats"}]
                     [{foreach from=$oxcmp_basket->getProductVats() item=VATitem key=key}]
                        <tr>
                           <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                           <td>[{$VATitem}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/foreach}]
                  [{/block}]

                  [{if $oxcmp_basket->isPriceViewModeNetto()}]
                     [{block name="checkout_basketcontents_totalgross"}]
                        <tr>
                           <th>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                           <td id="basketTotalGross">[{$oxcmp_basket->getFProductsPrice()}]&nbsp;[{$currency->sign}]</td>
                        </tr>
                     [{/block}]
                  [{/if}]
               [{/if}]

               [{block name="checkout_basketcontents_voucherdiscount"}]
                  [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVoucherDiscValue()}]
                     [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=Voucher}]
                        <tr class="couponData">
                           <th><span><strong>[{oxmultilang ident="COUPON"}]</strong>&nbsp;([{oxmultilang ident="NUMBER"}] [{$sVoucher->sVoucherNr}])</span>
                              [{if $editable}]
                                 <a href="[{$oViewConf->getSelfLink()}]&amp;cl=basket&amp;fnc=removeVoucher&amp;voucherId=[{$sVoucher->sVoucherId}]&amp;CustomError=basket" class="removeFn">[{oxmultilang ident="REMOVE"}]</a>
                              [{/if}]
                           </th>
                           <td>-<strong>[{$sVoucher->fVoucherdiscount}]&nbsp;[{$currency->sign}]</strong></td>
                        </tr>
                     [{/foreach}]
                  [{/if}]
               [{/block}]

               [{block name="checkout_basketcontents_delcosts"}]
                  [{assign var="deliveryCost" value=$oxcmp_basket->getDeliveryCost()}]
                  [{if $deliveryCost && ($oxcmp_basket->getBasketUser() || $oViewConf->isFunctionalityEnabled('blCalculateDelCostIfNotLoggedIn') ) }]
                     [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                        <tr>
                           <th>[{ oxmultilang ident="SHIPPING_NET" suffix="COLON" }]</th>
                           <td id="basketDeliveryNetto">[{oxprice price=$deliveryCost->getNettoPrice() currency=$currency }]</td>
                        </tr>
                        [{if $deliveryCost->getVatValue()}]
                           <tr>
                              [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                 <th>[{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON"}]</th>
                              [{else}]
                                 <th>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$deliveryCost->getVat()}]</th>
                              [{/if}]
                              <td id="basketDeliveryVat">[{oxprice price=$deliveryCost->getVatValue() currency=$currency}]</td>
                           </tr>
                        [{/if}]
                     [{else}]
                        <tr>
                           <th>[{ oxmultilang ident="SHIPPING_COST" suffix="COLON" }]</th>
                           <td id="basketDeliveryGross">[{oxprice price=$deliveryCost->getBruttoPrice() currency=$currency}]</td>
                        </tr>
                     [{/if}]
                  [{/if}]
               [{/block}]

               [{block name="checkout_basketcontents_paymentcosts"}]
                  [{assign var="paymentCost" value=$oxcmp_basket->getPaymentCost()}]
                  [{if $paymentCost && $paymentCost->getPrice() }]
                     [{if $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge') }]
                        <tr>
                           <th>[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON"}]</th>
                           <td id="basketPaymentNetto">[{oxprice price=$paymentCost->getNettoPrice() currency=$currency }]</td>
                        </tr>
                        [{if $paymentCost->getVatValue()}]
                           <tr>
                              [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                 <th>[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                              [{else}]
                                 <th>[{ oxmultilang ident="SURCHARGE_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$paymentCost->getVat() }]</th>
                              [{/if}]
                              <td id="basketPaymentVat">[{oxprice price=$paymentCost->getVatValue() currency=$currency }]</td>
                           </tr>
                        [{/if}]
                     [{else}]
                        <tr>
                           <th>[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</th>
                           <td id="basketPaymentGross">[{oxprice price=$paymentCost->getBruttoPrice() currency=$currency }]</td>
                        </tr>
                     [{/if}]
                  [{/if}]
               [{/block}]

               [{block name="checkout_basketcontents_wrappingcosts"}]
                  [{if $oViewConf->getShowGiftWrapping() }]
                     [{assign var="wrappingCost" value=$oxcmp_basket->getWrappingCost()}]
                     [{if $wrappingCost && $wrappingCost->getPrice() > 0 }]
                        [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                           <tr>
                              <th>[{ oxmultilang ident="BASKET_TOTAL_WRAPPING_COSTS_NET" suffix="COLON" }]</th>
                              <td id="basketWrappingNetto">[{oxprice price=$wrappingCost->getNettoPrice() currency=$currency}]</td>
                           </tr>
                           [{if $oxcmp_basket->getWrappCostVat() }]
                              <tr>
                                 <th>[{ oxmultilang ident="PLUS_VAT" suffix="COLON" }]</th>
                                 <td id="basketWrappingVat">[{oxprice price=$wrappingCost->getVatValue() currency=$currency}]</td>
                              </tr>
                           [{/if}]
                        [{else}]
                           <tr>
                              <th>[{ oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]</th>
                              <td id="basketWrappingGross">[{oxprice price=$wrappingCost->getBruttoPrice() currency=$currency }]</td>
                           </tr>
                        [{/if}]
                     [{/if}]

                     [{assign var="giftCardCost" value=$oxcmp_basket->getGiftCardCost()}]
                     [{if $giftCardCost && $giftCardCost->getPrice() > 0 }]
                        [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                           <tr>
                              <th>[{ oxmultilang ident="BASKET_TOTAL_GIFTCARD_COSTS_NET" suffix="COLON" }]</th>
                              <td id="basketGiftCardNetto">[{oxprice price=$giftCardCost->getNettoPrice() currency=$currency }]</td>
                           </tr>
                           <tr>
                              [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                 <th>[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                              [{else}]
                                 <th>[{ oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$giftCardCost->getVat() }] </th>
                              [{/if}]
                              <td id="basketGiftCardVat">[{oxprice price=$giftCardCost->getVatValue() currency=$currency}]</td>
                           </tr>
                        [{else}]
                           <tr>
                              <th>[{ oxmultilang ident="GREETING_CARD" suffix="COLON" }]</th>
                              <td id="basketGiftCardGross">[{oxprice price=$giftCardCost->getBruttoPrice() currency=$currency}]</td>
                           </tr>
                        [{/if}]
                     [{/if}]
                  [{/if}]
               [{/block}]

               [{block name="checkout_basketcontents_grandtotal"}]
                  <tr>
                     <th class="lead"><strong>[{oxmultilang ident="GRAND_TOTAL" suffix="COLON"}]</strong></th>
                     <td id="basketGrandTotal" class="lead"><strong>[{oxprice price=$oxcmp_basket->getPrice() currency=$currency}]</strong></td>
                  </tr>
               [{/block}]

               [{if $oxcmp_basket->hasSkipedDiscount()}]
                  <tr>
                     <th><span class="note">**</span> [{oxmultilang ident="MESSAGE_COUPON_NOT_APPLIED_FOR_ARTICLES"}]</span></th>
                     <td></td>
                  </tr>
               [{/if}]
            </table>
         </div>
      [{/block}]

   </div>
</div>