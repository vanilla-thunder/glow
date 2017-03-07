[{assign var="shop"      value=$oEmailView->getShop() }]
[{assign var="oViewConf" value=$oEmailView->getViewConfig() }]
[{assign var="currency"  value=$oEmailView->getCurrency() }]
[{assign var="user"      value=$oEmailView->getUser() }]
[{assign var="basket"    value=$order->getBasket() }]
[{assign var="oDelSet"   value=$order->getDelSet() }]
[{assign var="payment"   value=$order->getPayment() }]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=[{$oEmailView->getCharset()}]">
    <meta name="viewport" content="width=device-width"/>
    <title>[{oxmultilang ident="ORDER_NUMBER" }] [{ $order->oxorder__oxordernr->value }]</title>
    <style type="text/css">
        [{include file="../../../../out/glow/src/css/email.css"}]
    </style>
    <!--[if mso 12]>
    <style type="text/css">
        .flexibleContainer {
            display: block !important;
            width: 100% !important;
        }
    </style>
    <![endif]-->
    <!--[if mso 14]>
    <style type="text/css">
        .flexibleContainer {
            display: block !important;
            width: 100% !important;
        }
    </style>
    <![endif]-->
</head>
<body style="background: #ebebeb; text-align: left;">
<table class="container" width="100%" cellpadding="0" cellspacing="0" style="max-width: 600px; background: white; border: 1px solid gray;">
    <tr>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;" colspan="2">
            <h2>[{$shop->oxshops__oxname->value}] - [{oxmultilang ident="EMAIL_TITLE_NEW_ORDER"}][{$order->oxorder__oxordernr->value}]</h2>

            [{block name="email_html_order_owner_orderemail"}]
                [{if $payment->oxuserpayments__oxpaymentsid->value == "oxempty"}]
                    [{oxcontent ident="oxadminordernpemail"}]
                [{else}]
                    [{oxcontent ident="oxadminorderemail"}]
                [{/if}]
            [{/block}]

            [{oxmultilang ident="ORDER_NUMBER" }] <b>[{ $order->oxorder__oxordernr->value }]</b>
        </td>
    </tr>
</table>
<table class="container" width="100%" cellpadding="0" cellspacing="0" style="max-width: 600px; background: white; border: 1px solid gray;">
    <tr>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;">
            [{block name="email_html_order_cust_username"}]
                <strong style="margin: 10px 0;">[{oxmultilang ident="EMAIL_ADDRESS" suffix="COLON" }]</strong>
                <br>
                [{ $user->oxuser__oxusername->value }]
                <br>
            [{/block}]

            [{block name="email_html_order_cust_paymentinfo_top"}]
                [{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
                    <strong style="margin: 10px 0;">[{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</strong>
                    <br>
                    [{ $payment->oxpayments__oxdesc->value }]
                    [{assign var="oPaymentCostPrice" value=$basket->getPaymentCost()}]
                    [{if $oPaymentCostPrice }]([{oxprice price=$oPaymentCostPrice->getBruttoPrice() currency=$currency}])[{/if}]
                    <br>
                [{/if}]
            [{/block}]

            [{block name="email_html_order_cust_deliveryinfo"}]
                [{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
                    <strong style="margin: 10px 0;">[{oxmultilang ident="SELECTED_SHIPPING_CARRIER" suffix="COLON" }]</strong>
                    <br>
                    [{ $order->oDelSet->oxdeliveryset__oxtitle->value }]
                    <br>
                [{/if}]
            [{/block}]
        </td>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;" width="50%">
            [{block name="email_html_order_owner_paymentinfo"}]
                [{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
                    <h3 style="font-weight: bold; margin: 0 0 7px; padding: 0; line-height: 35px; font-size: 12px; font-family: Arial, Helvetica, sans-serif; text-transform: uppercase; border-bottom: 3px solid #ddd;">
                        [{oxmultilang ident="PAYMENT_INFORMATION" suffix="COLON" }]
                    </h3>
                    <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px;">
                        <b>[{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }] [{ $payment->oxpayments__oxdesc->value }]
                            [{assign var="oPaymentCostPrice" value=$basket->getPaymentCost()}]
                            [{if $oPaymentCostPrice }]([{oxprice price=$oPaymentCostPrice->getBruttoPrice() currency=$currency}])[{/if}]</b>
                        <br><br>
                        [{* oxmultilang ident="PAYMENT_INFO_OFF" *}]
                        [{* BLA-KW: Transaktions-ID der externen Bezahldienstanbieter als Referenztext mit übergeben für manuelle Buchung in D&G für Abgleich der Buchhaltung *}]
                        [{ if $order->oxorder__oxtransid->value }]
                            Referenztext:
                            <b>[{$order->oxorder__oxtransid->value}]</b>
                        [{ elseif $order->oxorder__psamazonorderid->value }]
                            Referenztext:
                            <b>[{$order->oxorder__psamazonorderid->value}]</b>
                        [{ elseif $order->oxorder__jagamazonorderreferenceid->value }]
                            Referenztext:
                            <b>[{$order->oxorder__jagamazonorderreferenceid->value}]</b>
                        [{ elseif $order->oxorder__bztransaction->value }]
                            Referenztext:
                            <b>[{$order->oxorder__bztransaction->value}]</b>
                        [{/if}]
                    </p>
                [{/if}]
            [{/block}]
        </td>
    </tr>
    <tr>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;">
            [{* RECHUNGSADRESSE *}]
            [{*<strong style="margin: 10px 0;">[{oxmultilang ident="ADDRESS" suffix="COLON" }]</strong><br> *}]
            <strong style="margin: 10px 0;">[{oxmultilang ident="BILLING_ADDRESS" suffix="COLON" }]</strong><br>
            [{ $order->oxorder__oxbillcompany->value }]<br>
            [{ $order->oxorder__oxbillsal->value|oxmultilangsal}] [{ $order->oxorder__oxbillfname->value }] [{ $order->oxorder__oxbilllname->value }]<br>
            [{if $order->oxorder__oxbilladdinfo->value }][{ $order->oxorder__oxbilladdinfo->value }]<br>[{/if}]
            [{ $order->oxorder__oxbillstreet->value }] [{ $order->oxorder__oxbillstreetnr->value }]<br>
            [{ $order->oxorder__oxbillstateid->value }]
            [{ $order->oxorder__oxbillzip->value }] [{ $order->oxorder__oxbillcity->value }]<br>
            [{ $order->oxorder__oxbillcountry->value }]<br>
            [{if $order->oxorder__oxbillustid->value}][{oxmultilang ident="VAT_ID_NUMBER" suffix="COLON" }] [{ $order->oxorder__oxbillustid->value }]
                <br>
            [{/if}]
            [{oxmultilang ident="PHONE" suffix="COLON" }] [{ $order->oxorder__oxbillfon->value }]<br>
            [{if $user->oxuser__oxbirthdate->value != '0000-00-00'}][{ oxmultilang ident="BIRTHDATE" suffix="COLON" }] [{ $user->oxuser__oxbirthdate->value }]<br>[{/if}]<br>
        </td>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;">
            [{* abweichende Lieferanschrift *}]
            [{if $order->oxorder__oxdellname->value }]
                <strong style="margin: 10px 0;">[{oxmultilang ident="SHIPPING_ADDRESS" suffix="COLON" }]</strong>
                <br>
                [{ $order->oxorder__oxdelcompany->value }]
                <br>
                [{ $order->oxorder__oxdelsal->value|oxmultilangsal }] [{ $order->oxorder__oxdelfname->value }] [{ $order->oxorder__oxdellname->value }]
                <br>
                [{if $order->oxorder__oxdeladdinfo->value }][{ $order->oxorder__oxdeladdinfo->value }]<br>[{/if}]
                [{ $order->oxorder__oxdelstreet->value }] [{ $order->oxorder__oxdelstreetnr->value }]
                <br>
                [{ $order->oxorder__oxdelstateid->value }]
                [{ $order->oxorder__oxdelzip->value }] [{ $order->oxorder__oxdelcity->value }]
                <br>
                [{ $order->oxorder__oxdelcountry->value }]
            [{/if}]
        </td>
    </tr>
    <tr>
        <td style="text-align: lenter; vertical-align: top; padding: 15px;" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                [{oxmultilang ident="ORDER_NUMBER" }] <b>[{ $order->oxorder__oxordernr->value }]</b>

                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td><b>[{oxmultilang ident="PRODUCT" }]</b></td>
                        <td align="right"><b>[{oxmultilang ident="UNIT_PRICE" }]</b></td>
                        <td align="right"><b>[{oxmultilang ident="QUANTITY" }]</b></td>
                        <td align="right"><b>[{oxmultilang ident="TOTAL" }]/[{oxmultilang ident="VAT" }]</b></td>
                    </tr>

                    [{assign var="basketitemlist" value=$basket->getBasketArticles() }]
                    [{foreach key=basketindex from=$basket->getContents() item=basketitem}]
                        [{block name="email_html_order_owner_basketitem"}]
                            <tr>
                                <td colspan="4">
                                    <hr>
                                </td>
                            </tr>
                            [{assign var="basketproduct" value=$basketitemlist.$basketindex }]
                            <tr valign="top">
                                <td valign="top">
                                    <b>[{$basketitem->getTitle()}]</b>
                                    <br>[{oxmultilang ident="PRODUCT_NO" suffix="COLON" }] [{ $basketproduct->oxarticles__oxartnum->value }]
                                    [{if $oViewConf->getShowGiftWrapping() }]
                                        <p>
                                            [{assign var="oWrapping" value=$basketitem->getWrapping() }]
                                            <b>[{oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]
                                                &nbsp;</b>[{if !$basketitem->getWrappingId() }][{oxmultilang ident="NONE" }][{else}][{$oWrapping->oxwrapping__oxname->value}][{/if}]
                                        </p>
                                    [{/if}]
                                    [{if $basketitem->getChosenSelList() }],
                                        [{foreach from=$basketitem->getChosenSelList() item=oList}]
                                            [{ $oList->name }] [{ $oList->value }]&nbsp;
                                        [{/foreach}]
                                    [{/if}]
                                    [{if $basketitem->getPersParams() }]
                                        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam}]
                                            <br>
                                            <em>[{$sVar}]: [{$aParam}]</em>
                                        [{/foreach}]
                                    [{/if}]
                                </td>
                                <td valign="top" align="right">
                                    <b>[{if $basketitem->getUnitPrice() }][{oxprice price=$basketitem->getUnitPrice() currency=$currency }][{/if}]</b>
                                    [{if !$basketitem->isBundle() }]
                                        [{assign var=dRegUnitPrice value=$basketitem->getRegularUnitPrice()}]
                                        [{assign var=dUnitPrice value=$basketitem->getUnitPrice()}]
                                        [{if $dRegUnitPrice->getPrice() > $dUnitPrice->getPrice() }]
                                            <br>
                                            <s>[{oxprice price=$basketitem->getRegularUnitPrice() currency=$currency }]</s>
                                        [{/if}]
                                    [{/if}]
                                    [{if $basketitem->aDiscounts}]
                                        <br>
                                        <br>
                                        <em style="font-size: 7pt;font-weight: normal;">[{oxmultilang ident="DISCOUNT" suffix="COLON" }]
                                            [{foreach from=$basketitem->aDiscounts item=oDiscount}]
                                                <br>
                                                [{ $oDiscount->sDiscount }]
                                            [{/foreach}]
                                        </em>
                                    [{/if}]
                                    [{if $basketproduct->oxarticles__oxorderinfo->value }][{ $basketproduct->oxarticles__oxorderinfo->value }][{/if}]
                                </td>
                                <td valign="top" align="right">x[{$basketitem->getAmount()}]</td>
                                <td valign="top" align="right"><b>[{oxprice price=$basketitem->getPrice() currency=$currency}]</b><br/>
                                    <small>([{$basketitem->getVatPercent() }]% MwSt)</small>
                                </td>
                            </tr>
                        [{/block}]
                    [{/foreach}]
                </table>

                [{* Zusammenfassung der Kosten *}]
                [{block name="email_html_order_cust_giftwrapping"}]
                    [{if $oViewConf->getShowGiftWrapping() && $basket->getCard() }]
                        [{assign var="oCard" value=$basket->getCard() }]
                        <br>
                        <br>
                        <table border="0" cellspacing="0" cellpadding="2" width="100%">
                            <tr>
                                <td colspan="2"><b>[{oxmultilang ident="YOUR_GREETING_CARD" suffix="COLON" }]</b></td>
                            </tr>
                            <tr valign="top">
                                <td><img src="[{$oCard->getPictureUrl()}]" alt="[{$oCard->oxwrapping__oxname->value}]" hspace="0" vspace="0" border="0" align="top"></td>
                                <td>
                                    [{oxmultilang ident="WHAT_I_WANTED_TO_SAY" }]<br><br>
                                    [{$basket->getCardMessage()}]
                                </td>
                            </tr>
                        </table>
                    [{/if}]
                [{/block}]

                <br><br>

                [{* gutschein *}]
                [{block name="email_html_order_cust_voucherdiscount_top"}]
                    [{if $oViewConf->getShowVouchers() && $basket->getVoucherDiscValue() }]
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr valign="top">
                                <td><b>[{oxmultilang ident="USED_COUPONS_2" }]</b></td>
                                <td><b>[{oxmultilang ident="REBATE" }]</b></td>
                            </tr>
                            [{foreach from=$order->getVoucherList() item=voucher}]
                                [{assign var="voucherseries" value=$voucher->getSerie() }]
                                <tr valign="top">
                                    <td>[{$voucher->oxvouchers__oxvouchernr->value}]</td>
                                    <td>[{$voucherseries->oxvoucherseries__oxdiscount->value}] [{if $voucherseries->oxvoucherseries__oxdiscounttype->value == "absolute"}][{ $currency->sign}][{else}]%[{/if}]</td>
                                </tr>
                            [{/foreach}]
                        </table>
                    [{/if}]
                [{/block}]

                <table border="0" cellspacing="0" cellpadding="0" width="300">
                    [{if !( $basket->getDiscounts() || ($oViewConf->getShowVouchers() && $basket->getVoucherDiscValue()) ) }]

                        [{block name="email_html_order_cust_nodiscounttotalnet"}]
                            [{* netto price *}]
                            <tr valign="top">
                                <td>
                                    [{oxmultilang ident="TOTAL_NET" suffix="COLON" }]
                                </td>
                                <td align="right">
                                    [{oxprice price=$basket->getNettoSum() currency=$currency }]
                                </td>
                            </tr>
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* verschiedene MwSt-Sätze *}]
                        [{block name="email_html_order_cust_nodiscountproductvats"}]
                            [{foreach from=$basket->getProductVats(false) item=VATitem key=key}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</td>
                                    <td align="right">[{oxprice price=$VATitem currency=$currency }]</td>
                                </tr>
                            [{/foreach}]
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* brutto price *}]
                        [{block name="email_html_order_cust_nodiscounttotalgross"}]
                            <tr valign="top">
                                <td>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
                                <td align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
                            </tr>
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                    [{else}]

                        [{if $order->isNettoMode() }]
                            [{* netto price *}]
                            [{block name="email_html_order_cust_discounttotalnet"}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="TOTAL_NET" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$basket->getNettoSum() currency=$currency }]</td>
                                </tr>
                            [{/block}]
                        [{else}]
                            [{* brutto price *}]
                            [{block name="email_html_order_cust_discounttotalgross"}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
                                </tr>
                            [{/block}]
                        [{/if}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* discounts *}]
                        [{block name="email_html_order_cust_discounts"}]
                            [{foreach from=$basket->getDiscounts() item=oDiscount}]
                                <tr valign="top">
                                    <td>
                                        [{if $oDiscount->dDiscount < 0 }][{oxmultilang ident="SURCHARGE" }][{else}][{oxmultilang ident="DISCOUNT" }][{/if}]
                                        <em>[{ $oDiscount->sDiscount }]</em> :
                                    </td>
                                    <td align="right">[{oxprice price=$oDiscount->dDiscount*-1 currency=$currency}]</td>
                                </tr>
                            [{/foreach}]
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* voucher discounts *}]
                        [{block name="email_html_order_cust_voucherdiscount"}]
                            [{if $oViewConf->getShowVouchers() && $basket->getVoucherDiscValue() }]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="COUPON" suffix="COLON" }]</td>
                                    <td align="right">
                                        [{assign var="oVoucherDiscount" value=$basket->getVoucherDiscount()}]
                                        [{oxprice price=$oVoucherDiscount->getBruttoPrice()*-1 currency=$currency}]
                                    </td>
                                </tr>
                            [{/if}]
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* netto price *}]
                        [{if !$order->isNettoMode() }]
                            [{block name="email_html_order_cust_totalnet"}]
                                <tr valign="top">
                                    <td style="padding: 5px; border-bottom: 1px solid #ddd;">
                                        [{oxmultilang ident="TOTAL_NET" suffix="COLON" }]
                                    </td>
                                    <td style="padding: 5px; border-bottom: 1px solid #ddd;" align="right">
                                        [{oxprice price=$basket->getNettoSum() currency=$currency }]
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr>
                                    </td>
                                </tr>
                            [{/block}]
                        [{/if}]

                        [{* VATs *}]
                        [{block name="email_html_order_cust_productvats"}]
                            [{foreach from=$basket->getProductVats(false) item=VATitem key=key}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</td>
                                    <td align="right">[{oxprice price=$VATitem currency=$currency }]</td>
                                </tr>
                            [{/foreach}]
                        [{/block}]
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        [{* brutto price *}]
                        [{if $order->isNettoMode() }]
                            [{block name="email_html_order_cust_totalbrut"}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="TOTAL_GROSS" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$basket->getBruttoSum() currency=$currency }]</td>
                                </tr>
                            [{/block}]
                            <tr>
                                <td colspan="2">
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
                                    <td>[{oxmultilang ident="SHIPPING_NET" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$oDeliveryCost->getNettoPrice() currency=$currency}]</td>
                                </tr>
                                [{if $oDeliveryCost->getVatValue()}]
                                    <tr valign="top">
                                        <td>
                                            [{if $basket->isProportionalCalculationOn() }]
                                                [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                                            [{else}]
                                                [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$oDeliveryCost->getVat() }]
                                            [{/if}]
                                        </td>
                                        <td align="right">[{oxprice price=$oDeliveryCost->getVatValue() currency=$currency}]</td>
                                    </tr>
                                [{/if}]
                            [{else}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="SHIPPING_COST" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$oDeliveryCost->getBruttoPrice() currency=$currency}]</td>
                                </tr>
                            [{/if}]
                            <tr>
                                <td colspan="2">
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
                                    <td>[{if $oPaymentCost->getPrice() >= 0}][{oxmultilang ident="SURCHARGE" }][{else}][{oxmultilang ident="DEDUCTION" }][{/if}] [{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$oPaymentCost->getNettoPrice() currency=$currency}]</td>
                                </tr>
                                [{if $oPaymentCost->getVatValue()}]
                                    <tr valign="top">
                                        <td>
                                            [{if $basket->isProportionalCalculationOn() }]
                                                [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                                            [{else}]
                                                [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$oPaymentCost->getVat()}]
                                            [{/if}]
                                        </td>
                                        <td align="right">[{oxprice price=$oPaymentCost->getVatValue() currency=$currency}]</td>
                                    </tr>
                                [{/if}]
                            [{else}]
                                <tr valign="top">
                                    <td>[{oxmultilang ident="SURCHARGE" suffix="COLON" }]</td>
                                    <td align="right">[{oxprice price=$oPaymentCost->getBruttoPrice() currency=$currency}]</td>
                                </tr>
                            [{/if}]
                            <tr>
                                <td colspan="2">
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
                                        <td>[{oxmultilang ident="BASKET_TOTAL_WRAPPING_COSTS_NET" suffix="COLON" }]</td>
                                        <td align="right">[{oxprice price=$wrappingCost->getNettoPrice() currency=$currency}]</td>
                                    </tr>
                                    <tr valign="top">
                                        <td>[{oxmultilang ident="PLUS_VAT" suffix="COLON" }]</td>
                                        <td align="right">[{oxprice price=$wrappingCost->getVatValue() currency=$currency}]</td>
                                    </tr>
                                [{else}]
                                    <tr valign="top">
                                        <td>[{oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]</td>
                                        <td align="right">[{oxprice price=$wrappingCost->getBruttoPrice() currency=$currency}]</td>
                                    </tr>
                                [{/if}]
                                <tr>
                                    <td colspan="2">
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
                                        <td>[{oxmultilang ident="BASKET_TOTAL_GIFTCARD_COSTS_NET" suffix="COLON" }]</td>
                                        <td align="right">[{oxprice price=$giftCardCost->getNettoPrice() currency=$currency}]</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            [{if $basket->isProportionalCalculationOn() }]
                                                [{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]
                                            [{else}]
                                                [{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" suffix="COLON" args=$giftCardCost->getVat()}]
                                            [{/if}]
                                        </td>
                                        <td align="right">[{oxprice price=$giftCardCost->getVatValue() currency=$currency}]</td>
                                    </tr>
                                [{else}]
                                    <tr valign="top">
                                        <td>[{oxmultilang ident="GREETING_CARD" suffix="COLON"}]</td>
                                        <td align="right">[{oxprice price=$giftCardCost->getBruttoPrice() currency=$currency}]</td>
                                    </tr>
                                [{/if}]
                                <tr>
                                    <td colspan="2">
                                        <hr>
                                    </td>
                                </tr>
                            [{/if}]
                        [{/block}]

                    [{/if}]

                    [{block name="email_html_order_cust_grandtotal"}]
                        [{* grand total price *}]
                        <tr valign="top">
                            <td><b class="bigger">[{oxmultilang ident="GRAND_TOTAL" suffix="COLON" }]</b></td>
                            <td align="right"><b class="bigger">[{oxprice price=$basket->getPrice() currency=$currency}]</b></td>
                        </tr>
                    [{/block}]
                </table>

                [{* mitteilung an uns und download links *}]

                [{block name="email_html_order_cust_userremark"}]
                    [{if $order->oxorder__oxremark->value }]
                        <strong style="margin: 10px 0;">[{oxmultilang ident="WHAT_I_WANTED_TO_SAY" SUFFIX="COLON" }]</strong>
                        <br>
                        <p>[{ $order->oxorder__oxremark->value|oxescape }]</p>
                    [{/if}]
                [{/block}]

                [{block name="email_html_order_cust_download_link"}]
                    [{if $oOrderFileList and $oOrderFileList|count }]
                        <strong style="margin: 10px 0;">[{oxmultilang ident="MY_DOWNLOADS_DESC" }]</strong>
                        <br>
                        [{foreach from=$oOrderFileList item="oOrderFile"}]
                            [{if $order->oxorder__oxpaid->value || !$oOrderFile->oxorderfiles__oxpurchasedonly->value}]
                                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=download" params="sorderfileid="|cat:$oOrderFile->getId()}]"
                                   rel="nofollow">[{$oOrderFile->oxorderfiles__oxfilename->value}]</a>
                                [{$oOrderFile->getFileSize()|oxfilesize}]
                            [{else}]
                              [{$oOrderFile->oxorderfiles__oxfilename->value}]
                                <strong style="margin: 10px 0;">[{oxmultilang ident="DOWNLOADS_PAYMENT_PENDING" }]</strong>
                            [{/if}]
                        [{/foreach}]
                    [{/if}]
                [{/block}]
                </td>
                </tr>
            </table>

</body>
</html>
