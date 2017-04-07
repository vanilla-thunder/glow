[{assign var="shop"      value=$oEmailView->getShop() }]
[{assign var="oViewConf" value=$oEmailView->getViewConfig() }]
[{assign var="oConf"     value=$oViewConf->getConfig() }]
[{assign var="currency"  value=$oEmailView->getCurrency() }]
[{assign var="user"      value=$oEmailView->getUser() }]
[{assign var="oDelSet"   value=$order->getDelSet() }]
[{assign var="basket"    value=$order->getBasket() }]
[{assign var="payment"   value=$order->getPayment() }]
[{assign var="sOrderId"  value=$order->getId() }]
[{assign var="oOrderFileList"   value=$oEmailView->getOrderFileList($sOrderId) }]
[{strip}]
   [{capture assign="title"}]
      [{oxmultilang ident="ORDER_NR" suffix="COLON"}]
     [{$order->oxorder__oxordernr->value}]
      <br/>
      [{oxmultilang ident="ORDER_FROM" suffix="COLON"}]
     [{$order->oxorder__oxorderdate->value|date_format:"%d.%m.%Y"}]
   [{/capture}]
   [{assign var="microdataItemtype" value="http://schema.org/Order"}]

   [{include file="email/html/header.tpl"}]

<!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td colspan="2"><![endif]-->

[{* Kurzer Text oben *}]
<div class="block" style="width:100%;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">

[{block name="email_html_order_cust_orderemail"}]
   [{if $payment->oxuserpayments__oxpaymentsid->value == "oxempty"}]
      [{oxcontent ident="oxuserordernpemail"}]
   [{else}]
      [{oxcontent ident="oxuserorderemail"}]
   [{/if}]
[{/block}]

            </td>
        </tr>
    </table>
</div>[{* /kurzer Text oben *}]
<!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->

[{* Zusammenfassung der Artikel *}]
   [{assign var="basketitemlist" value=$basket->getBasketArticles() }]
   [{foreach key=basketindex from=$basket->getContents() item=basketitem}]

      [{assign var="basketproduct" value=$basketitemlist.$basketindex }]
      [{block name="email_html_order_cust_basketitem"}]
         <hr>
         <!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td width="200"><![endif]-->
         <div style="width:200px;display:inline-block;vertical-align:top;" class="block">
            <table width="100%">
               <tr>
                  <td class="padding" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                     <img src="[{$basketproduct->getThumbnailUrl(false)}]" alt="[{$basketitem->getTitle()|strip_tags}]" width="180" style="max-width:180px;max-height:180px;">
               </tr>
            </table>
         </div>
         <!--[if (gte mso 9)|(IE)]></td><td width="400"><![endif]-->
         <div class="block" style="width:400px;display:inline-block;vertical-align:top;">
            <table width="100%">
               <tr>
                  <td class="padding" align="left"      style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                   <h3>[{$basketitem->getTitle()}]</h3>

                     [{if $basketitem->getPersParams() }]
                        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam}]
                           [{* [{oxmultilang ident='LABEL'}][{$sVar}]: *}][{$aParam}]<br>
                        [{/foreach}]
                     [{/if}]
                     [{if $basketitem->getChosenSelList() }]
                        [{foreach from=$basketitem->getChosenSelList() item=oList}]
                           [{ $oList->name }]: [{ $oList->value }]<br>
                        [{/foreach}]
                     [{/if}]

                     [{oxmultilang ident="PRODUCT_NO" suffix="COLON" }] [{ $basketproduct->oxarticles__oxartnum->value }]
                     <br>

                     [{if $basketitem->getUnitPrice() }]
                        [{oxmultilang ident="UNIT_PRICE" suffix="COLON"}] [{oxprice price=$basketitem->getUnitPrice() currency=$currency }]
                        <br>
                     [{/if}]

                     [{oxmultilang ident="QUANTITY" suffix="COLON"}] [{$basketitem->getAmount()}]<br>

                     [{if $basketitem->aDiscounts}]
                        [{oxmultilang ident="DISCOUNT" suffix="COLON" }]
                        [{foreach from=$basketitem->aDiscounts item=oDiscount}]
                           <br>
                           [{ $oDiscount->sDiscount }]
                        [{/foreach}]
                     [{/if}]

                     <b>[{oxmultilang ident="TOTAL" suffix="COLON"}][{oxprice price=$basketitem->getPrice() currency=$currency}]</b><br>
                     <small>[{oxmultilang ident="VAT" suffix="COLON"}] [{$basketitem->getVatPercent() }]%</small>
                     <br>

                     [{* Geschenkverpackung *}]
                     [{if $oViewConf->getShowGiftWrapping() }]
                        [{assign var="oWrapping" value=$basketitem->getWrapping() }]
                        <b>[{oxmultilang ident="GIFT_WRAPPING" suffix="COLON"}]nbsp;</b>
                        [{if !$basketitem->getWrappingId() }][{oxmultilang ident="NONE" }]
                        [{else}][{$oWrapping->oxwrapping__oxname->value}][{/if}]
                     [{/if}]

                     [{if $basketproduct->oxarticles__oxorderinfo->value }]<p>[{ $basketproduct->oxarticles__oxorderinfo->value }]</p>[{/if}]
                  </td>
               </tr>
            </table>
         </div>
         <!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->
      [{/block}]
   [{/foreach}]
<hr>

[{* Zusammenfassung der Kosten *}]
<!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td colspan="2"><![endif]-->

   <div class="block" style="width:600px;display:inline-block;vertical-align:top;">
      <table width="100%">
         <tr>
            <td class="padding" align="right" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">

               [{block name="email_html_order_cust_giftwrapping"}]
                  [{if $oViewConf->getShowGiftWrapping() && $basket->getCard() }]
                     [{assign var="oCard" value=$basket->getCard() }]
                     <br><br>
                     <table border="0" cellspacing="0" cellpadding="2" width="100%">
                     <tr>
                        <td colspan="2" style="font-size:16px;line-height:1.25;"><b>[{oxmultilang ident="YOUR_GREETING_CARD" suffix="COLON" }]</b></td>
                     </tr>
                     <tr valign="top">
                        <td><img src="[{$oCard->getPictureUrl()}]" alt="[{$oCard->oxwrapping__oxname->value}]" hspace="0" vspace="0" border="0" align="top"></td>
                        <td style="font-size:16px;line-height:1.25;">
                           [{oxmultilang ident="WHAT_I_WANTED_TO_SAY" }]<br><br>
                           [{$basket->getCardMessage()}]
                        </td>
                     </tr>
                     </table>
                  [{/if}]
               [{/block}]

               [{* gutschein *}]
   [{*
               [{block name="email_html_order_cust_voucherdiscount_top"}]
                  [{if $oViewConf->getShowVouchers() && $basket->getVoucherDiscValue() }]
                     <table border="0" cellspacing="0" cellpadding="0">
                     <tr valign="top">
                        <td style="font-size:16px;line-height:1.25;"><b>[{oxmultilang ident="USED_COUPONS_2" }]</b></td>
                        <td style="font-size:16px;line-height:1.25;"><b>[{oxmultilang ident="REBATE" }]</b></td>
                     </tr>
                     [{foreach from=$order->getVoucherList() item=voucher}]
                        [{assign var="voucherseries" value=$voucher->getSerie() }]
                        <tr valign="top">
                           <td style="font-size:16px;line-height:1.25;">[{$voucher->oxvouchers__oxvouchernr->value}]</td>
                           <td style="font-size:16px;line-height:1.25;">[{$voucherseries->oxvoucherseries__oxdiscount->value}] [{if $voucherseries->oxvoucherseries__oxdiscounttype->value == "absolute"}][{ $currency->sign}][{else}]%[{/if}]</td>
                        </tr>
                     [{/foreach}]
                     </table>
                  [{/if}]
               [{/block}]
               *}]

                <br><br>
            </td>
         </tr>
         <tr>
            <td class="padding" align="right" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                <table border="0" cellspacing="0" cellpadding="0" width="300">
                    [{if !( $basket->getDiscounts() || ($oViewConf->getShowVouchers() && $basket->getVoucherDiscValue()) ) }]

   [{block name="email_html_order_cust_nodiscounttotalnet"}]
      [{* netto price *}]
      <tr valign="top">
         <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TOTAL_NET" suffix="COLON" }]</td>
         <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$basket->getNettoSum() currency=$currency }]</td>
      </tr>
   [{/block}]
   <tr>
      <td colspan="2" style="font-size:16px;line-height:1.25;">
         <hr>
      </td>
   </tr>
   [{* verschiedene MwSt-Sätze *}]
   [{block name="email_html_order_cust_nodiscountproductvats"}]
      [{foreach from=$basket->getProductVats(false) item=VATitem key=key}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$VATitem currency=$currency }]</td>
         </tr>
      [{/foreach}]
   [{/block}]
   <tr><td style="font-size:16px;line-height:1.25;" colspan="2"><hr></td></tr>

   [{* brutto price *}]
   [{block name="email_html_order_cust_nodiscounttotalgross"}]
      <tr valign="top">
         <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
         <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
      </tr>
   [{/block}]
   <tr>
      <td style="font-size:16px;line-height:1.25;" colspan="2">
         <hr>
      </td>
   </tr>
[{else}]

   [{if $order->isNettoMode() }]
      [{* netto price *}]
      [{block name="email_html_order_cust_discounttotalnet"}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TOTAL_NET" suffix="COLON" }]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$basket->getNettoSum() currency=$currency }]</td>
         </tr>
      [{/block}]
   [{else}]
      [{* brutto price *}]
      [{block name="email_html_order_cust_discounttotalgross"}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
         </tr>
      [{/block}]
   [{/if}]

   <tr><td style="font-size:16px;line-height:1.25;" colspan="2"><hr></td></tr>

   [{* discounts *}]
   [{block name="email_html_order_cust_discounts"}]
      [{foreach from=$basket->getDiscounts() item=oDiscount}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">
               [{if $oDiscount->dDiscount < 0 }][{oxmultilang ident="SURCHARGE" }][{else}][{oxmultilang ident="DISCOUNT" }][{/if}]
               <em>[{ $oDiscount->sDiscount }]</em> :
            </td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oDiscount->dDiscount*-1 currency=$currency}]</td>
         </tr>
         <tr><td style="font-size:16px;line-height:1.25;" colspan="2"><hr></td></tr>
      [{/foreach}]
   [{/block}]



   [{* voucher discounts *}]
   [{block name="email_html_order_cust_voucherdiscount"}]
      [{if $oViewConf->getShowVouchers() && $basket->getVoucherDiscValue() }]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="COUPON" suffix="COLON" }]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">
               [{assign var="oVoucherDiscount" value=$basket->getVoucherDiscount()}]
               [{oxprice price=$oVoucherDiscount->getBruttoPrice()*-1 currency=$currency}]
            </td>
         </tr>
         <tr><td style="font-size:16px;line-height:1.25;" colspan="2"><hr></td></tr>
      [{/if}]
   [{/block}]

   [{* netto price *}]
   [{if !$order->isNettoMode() }]
      [{block name="email_html_order_cust_totalnet"}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">
               [{oxmultilang ident="TOTAL_NET" suffix="COLON" }]
            </td>
            <td style="font-size:16px;line-height:1.25;" align="right">
               [{oxprice price=$basket->getNettoSum() currency=$currency }]
            </td>
         </tr>
         <tr><td style="font-size:16px;line-height:1.25;" colspan="2"><hr></td></tr>
      [{/block}]
   [{/if}]

   [{* VATs *}]
   [{block name="email_html_order_cust_productvats"}]
      [{foreach from=$basket->getProductVats(false) item=VATitem key=key}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$VATitem currency=$currency }]</td>
         </tr>
      [{/foreach}]
   [{/block}]
   <tr>
      <td style="font-size:16px;line-height:1.25;" colspan="2">
         <hr>
      </td>
   </tr>
   [{* brutto price *}]
   [{if $order->isNettoMode() }]
      [{block name="email_html_order_cust_totalbrut"}]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
         </tr>
      [{/block}]
      <tr>
         <td style="font-size:16px;line-height:1.25;" colspan="2">
            <hr>
         </td>
      </tr>
   [{/if}]

[{/if}]

   [{* delivery costs *}]
   [{block name="email_html_order_cust_delcosts"}]
      [{assign var="oDeliveryCost" value=$basket->getDeliveryCost()}]
      [{if $oDeliveryCost && $oDeliveryCost->getPrice() > 0 }]
         [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
            <tr valign="top">
               <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="SHIPPING_NET" suffix="COLON" }]</td>
               <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oDeliveryCost->getNettoPrice() currency=$currency}]</td>
            </tr>
            [{if $oDeliveryCost->getVatValue()}]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">
                     [{if $basket->isProportionalCalculationOn() }]
                        [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                     [{else}]
                        [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$oDeliveryCost->getVat() }]
                     [{/if}]
                  </td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oDeliveryCost->getVatValue() currency=$currency}]</td>
               </tr>
            [{/if}]
         [{else}]
            <tr valign="top">
               <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="SHIPPING_COST" suffix="COLON" }]</td>
               <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oDeliveryCost->getBruttoPrice() currency=$currency}]</td>
            </tr>
         [{/if}]
         <tr>
            <td style="font-size:16px;line-height:1.25;" colspan="2">
               <hr>
            </td>
         </tr>
      [{/if}]
   [{/block}]

   [{* payment sum *}]
   [{block name="email_html_order_cust_paymentcosts"}]
      [{assign var="oPaymentCost" value=$basket->getPaymentCost()}]
      [{if $oPaymentCost && $oPaymentCost->getPrice() }]
         [{if $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge') }]
            <tr valign="top">
               <td style="font-size:16px;line-height:1.25;">[{if $oPaymentCost->getPrice() >= 0}][{oxmultilang ident="SURCHARGE" }][{else}][{oxmultilang ident="DEDUCTION" }][{/if}] [{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</td>
               <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oPaymentCost->getNettoPrice() currency=$currency}]</td>
            </tr>
            [{if $oPaymentCost->getVatValue()}]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">
                     [{if $basket->isProportionalCalculationOn() }]
                        [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                     [{else}]
                        [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$oPaymentCost->getVat()}]
                     [{/if}]
                  </td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oPaymentCost->getVatValue() currency=$currency}]</td>
               </tr>
            [{/if}]
         [{else}]
            <tr valign="top">
               <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="SURCHARGE" suffix="COLON" }]</td>
               <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$oPaymentCost->getBruttoPrice() currency=$currency}]</td>
            </tr>
         [{/if}]
         <tr>
            <td style="font-size:16px;line-height:1.25;" colspan="2">
               <hr>
            </td>
         </tr>
      [{/if}]
   [{/block}]


   [{* Trusted Shops *}]
   [{block name="email_html_order_cust_ts"}]
      [{assign var="trustedShopProtectionCost" value=$basket->getTrustedShopProtectionCost()}]
      [{if $trustedShopProtectionCost && $trustedShopProtectionCost->getPrice() > 0  }]
         <tr valign="top">
            <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="TRUSTED_SHOP_BUYER_PROTECTION" suffix="COLON" }]</td>
            <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$trustedShopProtectionCost->getNettoPrice() currency=$currency}]</td>
         </tr>
         [{if $trustedShopProtectionCost->getVatValue()}]
            <tr valign="top">
               <td style="font-size:16px;line-height:1.25;">
                  [{if $basket->isProportionalCalculationOn() }]
                     [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                  [{else}]
                     [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$trustedShopProtectionCost->getVat()}]
                  [{/if}]
               </td>

               <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$trustedShopProtectionCost->getVatValue() currency=$currency}]</td>
            </tr>
         [{/if}]
         <tr>
            <td style="font-size:16px;line-height:1.25;" colspan="2">
               <hr>
            </td>
         </tr>
      [{/if}]
   [{/block}]

   [{* Gift wrapping *}]
   [{if $oViewConf->getShowGiftWrapping() }]
      [{block name="email_html_order_cust_wrappingcosts"}]
         [{assign var="wrappingCost" value=$basket->getWrappingCost()}]
         [{if $wrappingCost && $wrappingCost->getPrice() > 0 }]
            [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="BASKET_TOTAL_WRAPPING_COSTS_NET" suffix="COLON" }]</td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$wrappingCost->getNettoPrice() currency=$currency}]</td>
               </tr>
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="PLUS_VAT" suffix="COLON" }]</td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$wrappingCost->getVatValue() currency=$currency}]</td>
               </tr>
            [{else}]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]</td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$wrappingCost->getBruttoPrice() currency=$currency}]</td>
               </tr>
            [{/if}]
            <tr>
               <td style="font-size:16px;line-height:1.25;" colspan="2">
                  <hr>
               </td>
            </tr>
         [{/if}]
      [{/block}]

      [{* Greeting card *}]
      [{block name="email_html_order_cust_giftwrapping"}]
         [{assign var="giftCardCost" value=$basket->getGiftCardCost()}]
         [{if $giftCardCost && $giftCardCost->getPrice() > 0 }]
            [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="BASKET_TOTAL_GIFTCARD_COSTS_NET" suffix="COLON" }]</td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$giftCardCost->getNettoPrice() currency=$currency}]</td>
               </tr>
               <tr>
                  <td style="font-size:16px;line-height:1.25;">
                     [{if $basket->isProportionalCalculationOn() }]
                        [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                     [{else}]
                        [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" suffix="COLON" args=$giftCardCost->getVat()}]
                     [{/if}]
                  </td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$giftCardCost->getVatValue() currency=$currency}]</td>
               </tr>
            [{else}]
               <tr valign="top">
                  <td style="font-size:16px;line-height:1.25;">[{oxmultilang ident="GREETING_CARD" suffix="COLON"}]</td>
                  <td style="font-size:16px;line-height:1.25;" align="right">[{oxprice price=$giftCardCost->getBruttoPrice() currency=$currency}]</td>
               </tr>
            [{/if}]
            <tr>
               <td style="font-size:16px;line-height:1.25;" colspan="2">
                  <hr>
               </td>
            </tr>
         [{/if}]
      [{/block}]

   [{/if}]

   [{block name="email_html_order_cust_grandtotal"}]
      [{* grand total price *}]
      <tr valign="top">
         <td style="font-size:16px;line-height:1.25;"><b class="bigger">[{oxmultilang ident="GRAND_TOTAL" suffix="COLON" }]</b></td>
         <td style="font-size:16px;line-height:1.25;" align="right">
            <b class="bigger">[{oxprice price=$basket->getPrice() currency=$currency}]</b></td>
      </tr>
   [{/block}]
                </table>

            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr>
<tr>
    <td colspan="2"><![endif]-->
<div class="block" style="width:600px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="right" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                [{* mitteilung an uns und download links *}]

   [{block name="email_html_order_cust_userremark"}]
      [{if $order->oxorder__oxremark->value }]
         <font class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="WHAT_I_WANTED_TO_SAY" suffix="COLON" }]</span>
         <br>
         <p>[{ $order->oxorder__oxremark->value|oxescape }]</p>
      [{/if}]
   [{/block}]

   [{block name="email_html_order_cust_download_link"}]
      [{if $oOrderFileList and $oOrderFileList|count }]
         <font class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="MY_DOWNLOADS_DESC" }]</span>
         <br>
         [{foreach from=$oOrderFileList item="oOrderFile"}]
         [{if $order->oxorder__oxpaid->value || !$oOrderFile->oxorderfiles__oxpurchasedonly->value}]
            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=download" params="sorderfileid="|cat:$oOrderFile->getId()}]" rel="nofollow">[{$oOrderFile->oxorderfiles__oxfilename->value}]</a>
            [{$oOrderFile->getFileSize()|oxfilesize}]
         [{else}]
          [{$oOrderFile->oxorderfiles__oxfilename->value}]
            <strong>[{oxmultilang ident="DOWNLOADS_PAYMENT_PENDING" }]</strong>
         [{/if}]
      [{/foreach}]
      [{/if}]
   [{/block}]
            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr></table>
<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td width="50%"><![endif]-->
<div class="block" style="width:300px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">


                [{block name="email_html_order_cust_username"}]
   <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="EMAIL_ADDRESS" suffix="COLON" }]</span>
   <br>
   [{ $user->oxuser__oxusername->value }]
   <br>
[{/block}]

   [{block name="email_html_order_cust_paymentinfo_top"}]
      [{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
         <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</span>
         <br>
         [{ $payment->oxpayments__oxdesc->value }]
         [{assign var="oPaymentCostPrice" value=$basket->getPaymentCost()}]
         [{if $oPaymentCostPrice }]([{oxprice price=$oPaymentCostPrice->getBruttoPrice() currency=$currency}])[{/if}]
         <br>
      [{/if}]
   [{/block}]

   [{block name="email_html_order_cust_deliveryinfo"}]
      [{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
         <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="SELECTED_SHIPPING_CARRIER" suffix="COLON" }]</span>
         <br>
         [{ $order->oDelSet->oxdeliveryset__oxtitle->value }]
         <br>
      [{/if}]
   [{/block}]

            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td>
<td width="50%"><![endif]-->
<div class="block" style="width:300px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">

                [{block name="email_html_order_cust_paymentinfo"}]
   [{if $payment->oxuserpayments__oxpaymentsid->value == "oxidpayadvance"}]
      <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="BANK_DETAILS" }]</span>
      <br>
      [{if $shop->oxshops__oxbankname->value}][{oxmultilang ident="BANK" suffix="COLON" }] [{$shop->oxshops__oxbankname->value}]<br>[{/if}]
      [{if $shop->oxshops__oxbankcode->value}][{oxmultilang ident="BANK_CODE" suffix="COLON" }] [{$shop->oxshops__oxbankcode->value}]<br>[{/if}]
      [{if $shop->oxshops__oxbanknumber->value}][{oxmultilang ident="BANK_ACCOUNT_NUMBER" suffix="COLON" }] [{$shop->oxshops__oxbanknumber->value}]<br>[{/if}]
      [{if $shop->oxshops__oxbiccode->value}][{oxmultilang ident="BIC" suffix="COLON"}] [{$shop->oxshops__oxbiccode->value}]<br>[{/if}]
      [{if $shop->oxshops__oxibannumber->value}][{oxmultilang ident="IBAN" suffix="COLON"}] [{$shop->oxshops__oxibannumber->value}][{/if}]
   [{/if}]
[{/block}]
            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr>
<tr>
    <td><![endif]-->
<div class="block" style="width:300px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">
                [{* RECHUNGSADRESSE *}]
                <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="BILLING_ADDRESS" suffix="COLON" }]</span><br>
               [{ $order->oxorder__oxbillcompany->value }]<br>
               [{ $order->oxorder__oxbillsal->value|oxmultilangsal}] [{ $order->oxorder__oxbillfname->value }] [{ $order->oxorder__oxbilllname->value }]<br>
               [{if $order->oxorder__oxbilladdinfo->value }][{ $order->oxorder__oxbilladdinfo->value }]<br>[{/if}]
                [{ $order->oxorder__oxbillstreet->value }] [{ $order->oxorder__oxbillstreetnr->value }]<br>
                [{if $order->oxorder__oxbillstateid->value }][{ $order->oxorder__oxbillstateid->value }]<br/>[{/if}]
                [{ $order->oxorder__oxbillzip->value }]&nbsp;[{ $order->oxorder__oxbillcity->value }]<br>
              [{ $order->oxorder__oxbillcountry->value }]<br>
                  [{if $order->oxorder__oxbillustid->value}][{oxmultilang ident="VAT_ID_NUMBER" suffix="COLON" }] [{ $order->oxorder__oxbillustid->value }]<br>[{/if}]
               [{if $order->oxorder__oxbillfon->value }][{oxmultilang ident="PHONE" suffix="COLON" }] [{ $order->oxorder__oxbillfon->value }]<br>[{/if}]
            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td>
<td><![endif]-->
<div class="block" style="width:300px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">

                [{* abweichende Lieferanschrift *}]
   [{if $order->oxorder__oxdellname->value }]
      <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="SHIPPING_ADDRESS" suffix="COLON" }]</span><br>
      [{ $order->oxorder__oxdelcompany->value }]<br>
      [{ $order->oxorder__oxdelsal->value|oxmultilangsal }] [{ $order->oxorder__oxdelfname->value }] [{ $order->oxorder__oxdellname->value }]<br>
      [{if $order->oxorder__oxdeladdinfo->value }][{ $order->oxorder__oxdeladdinfo->value }]<br>[{/if}]
      [{ $order->oxorder__oxdelstreet->value }] [{ $order->oxorder__oxdelstreetnr->value }]<br>
      [{ $order->oxorder__oxdelstateid->value }] [{ $order->oxorder__oxdelzip->value }] [{ $order->oxorder__oxdelcity->value }]<br>
      [{ $order->oxorder__oxdelcountry->value }]
   [{/if}]

            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr>
<tr>
    <td colspan="2"><![endif]-->
<div class="block" style="width:600px;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">


                [{block name="email_html_order_cust_tsinfo"}]
   [{if $oViewConf->showTs("ORDEREMAIL") && $oViewConf->getTsId() }]
      [{assign var="sTSRatingImg" value="https://www.trustedshops.com/bewertung/widget/img/bewerten_"|cat:$oViewConf->getActLanguageAbbr()|cat:".gif"}]
      <span class="h4" style="color:#71A12A;margin-top:5px;margin-bottom:5px;margin-right:0;margin-left:0;font-weight:bold;font-size:18px;">[{oxmultilang ident="RATE_OUR_SHOP" }]</span>
      <br>
      <a href="[{ $oViewConf->getTsRatingUrl() }]" target="_blank" title="[{oxmultilang ident="TRUSTED_SHOPS_RATINGS" }]">
         <img src="[{$sTSRatingImg}]" border="0" alt="[{oxmultilang ident="WRITE_REVIEW_2" }]" align="middle">
      </a>
   [{/if}]
[{/block}]

            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->

</td></tr>
<tr>
    <td class="row" style="text-align:center;vertical-align:top;font-size:12px;padding-top:8px;padding-bottom:8px;padding-right:8px;padding-left:8px;">
        [{block name="email_html_order_cust_orderemailend"}]
   [{oxcontent ident="oxuserorderemailend" }]
[{/block}]

   [{include file="email/html/footer.tpl"}]
[{/strip}]