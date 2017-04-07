[{assign var="shop"      value=$oEmailView->getShop() }]
[{assign var="user"      value=$order->getUser() }]
[{assign var="del"       value=$order->getDelSet() }]
[{assign var="oViewConf" value=$oEmailView->getViewConfig() }]

[{assign var="microdataItemtype" value="http://schema.org/ParcelDelivery"}]

[{include file="email/html/header.tpl" title="EMAIL_TITLE_ORDER_ON_THE_WAY"|oxmultilangassign}]

<!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td colspan="2"><![endif]-->
<div style="width: 100%;" class="block"><table width="100%" ><tr><td class="padding" align="left">

    [{block name="email_html_ordershipped_sendemail"}]
       [{ oxcontent ident="oxordersendemail" }]
    [{/block}]
    
</td></tr></table></div>
<!--[if (gte mso 9)|(IE)]></td></tr><tr><td width="50%"><![endif]-->
<div style="width: 300px;" class="block"><table width="100%"><tr><td class="padding" align="left">
    
    [{block name="email_html_ordershipped_oxordernr"}]
        <h4>[{ oxmultilang ident="ORDER_NUMBER" suffix="COLON" }] [{ $order->oxorder__oxordernr->value }]</h4>
    [{/block}]
    
    [{* delivery set || shipping carrier *}]
    <h4>
        [{oxmultilang ident="SHIPPING_CARRIER" suffix="COLON"}] [{$del->oxdeliveryset__oxtitle->value}]
    </h4>
    
    [{if $order->getTrackCode()}]<h4>Tracking Code:</h4> [{$order->getTrackCode()}][{/if}]
    
</tr></table></div>

<!--[if (gte mso 9)|(IE)]></td><td width="50%"><![endif]-->
<div style="width: 300px;" class="block"><table width="100%"><tr><td class="padding" align="left">
    [{block name="email_html_ordershipped_infoheader"}]
        <h4>[{ oxmultilang ident="ORDER_SHIPPED_TO" suffix="COLON" }]</h4>
    [{/block}]
    [{block name="email_html_ordershipped_address"}]
            [{if $order->oxorder__oxdellname->value }]
              [{ $order->oxorder__oxdelcompany->value }]<br>
            [{ $order->oxorder__oxdelfname->value }] [{ $order->oxorder__oxdellname->value }]<br>
            [{ $order->oxorder__oxdelstreet->value }] [{ $order->oxorder__oxdelstreetnr->value }]<br>
              [{if $order->oxorder__oxdelstateid->value}][{ $order->oxorder__oxdelstateid->value }]<br>[{/if}]
            [{ $order->oxorder__oxdelzip->value }] [{ $order->oxorder__oxdelcity->value }]<br>
          [{ $order->oxorder__oxdelcountry->value }]
            [{else}]
              [{ $order->oxorder__oxbillcompany->value }]<br>
              [{ $order->oxorder__oxbillfname->value }] [{ $order->oxorder__oxbilllname->value }]<br>
            [{ $order->oxorder__oxbillstreet->value }] [{ $order->oxorder__oxbillstreetnr->value }]<br>
              [{if $order->oxorder__oxbillstateid->value}][{ $order->oxorder__oxbillstateid->value }]<br>[{/if}]
            [{ $order->oxorder__oxbillzip->value }] [{ $order->oxorder__oxbillcity->value }]<br>
              [{ $order->oxorder__oxbillcountry->value }]
            [{/if}]

    [{/block}]
    
</tr></table></div>
<!--[if (gte mso 9)|(IE)]></td></tr><tr><td colspan="2"><![endif]-->
<div style="width: 100%;" class="block"><table width="100%" ><tr><td class="padding" align="left">

    [{block name="email_html_ordershipped_shipmenttrackingurl"}]
        [{if $order->getShipmentTrackingUrl()}]
        <a class="button" href="[{ $order->getShipmentTrackingUrl()}]" title="[{$order->getTrackCode()}]"   itemvalue="[{ $order->getShipmentTrackingUrl()}]">[{ oxmultilang ident="SHIPMENT_TRACKING" }]</a>
        [{/if}]
    [{/block}]
    
</td></tr></table></div>    
<!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->

[{block name="email_html_ordershipped_orderarticles"}]
[{foreach from=$order->getOrderArticles(true) item=oOrderArticle}]
    <!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td width="150"><![endif]-->
    <div style="width: 150px;" class="block"><table width="100%"><tr><td class="padding">
          [{assign var="oArticle" value=$oOrderArticle->getArticle() }]
          <img src="[{$oArticle->getThumbnailUrl(false)}]" alt="[{$oOrderArticle->oxorderarticles__oxtitle->value|strip_tags}]" width="100" style="max-width:100px;">
        
    </tr></table></div>
    <!--[if (gte mso 9)|(IE)]></td><td width="450"><![endif]-->
    <div style="width: 400px;" class="block"><table width="100%"><tr><td class="padding" align="left">
        <b>[{ $oOrderArticle->oxorderarticles__oxtitle->value }] [{ $oOrderArticle->oxorderarticles__oxselvariant->value }]</b>
        <br>[{ oxmultilang ident="PRODUCT_NO" suffix="COLON" }] [{ $oOrderArticle->oxorderarticles__oxartnum->value }]
        <br>[{ oxmultilang ident="QUANTITY" suffix="COLON" }][{ $oOrderArticle->oxorderarticles__oxamount->value }]
        
    </tr></table></div>
    <!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->
[{/foreach}]
[{/block}]

<!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td colspan="2"><![endif]-->
<div style="width: 100%;" class="block"><table width="100%" ><tr><td class="padding" align="left">
    

    [{block name="email_html_ordershipped_infofooter"}]
        <p>[{ oxmultilang ident="YOUR_TEAM" args=$shop->oxshops__oxname->value}]</p>
    [{/block}]

</tr></table></div>
<!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->

[{include file="email/html/footer.tpl"}]
