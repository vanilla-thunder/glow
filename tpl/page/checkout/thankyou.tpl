[{capture append="oxidBlock_content"}]
    [{assign var="order" value=$oView->getOrder()}]
    [{assign var="basket" value=$oView->getBasket()}]
    <div class="page-header"><h1>[{oxmultilang ident="THANK_YOU"}]</h1></div>
    [{block name="checkout_thankyou_main"}]

        [{block name="checkout_thankyou_info"}]
            <div>
                <p>[{oxmultilang ident="THANK_YOU_FOR_ORDER"}] [{$oxcmp_shop->oxshops__oxname->value}].</p>

                <p>
                    [{if !$oView->getMailError() }]
                        [{oxmultilang ident="MESSAGE_YOU_RECEIVED_ORDER_CONFIRM"}]
                    [{else}]
                        <div class="alert alert-warning" role="alert">[{oxmultilang ident="MESSAGE_CONFIRMATION_NOT_SUCCEED"}]</div>
                    [{/if}]
                </p>
                <p>[{oxmultilang ident="REGISTERED_YOUR_ORDER" args=$order->oxorder__oxordernr->value}]<br/>[{oxmultilang ident="MESSAGE_WE_WILL_INFORM_YOU"}]</p>
            </div>
            <div class="spacer"></div>
        [{/block}]

        [{block name="checkout_thankyou_proceed"}]
            [{if $oxcmp_user->oxuser__oxpassword->value}]
                <a rel="nofollow" class="btn btn-link" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order"}]">
                    [{oxmultilang ident="YOU_CAN_GO"}] [{oxmultilang ident="CHECK_YOUR_ORDER_HISTORY"}]
                </a>
            [{/if}]
        [{/block}]

        [{block name="checkout_thankyou_partners"}][{/block}]

        [{if $oView->getAlsoBoughtTheseProducts()}]
            <hr/>
            [{include file="widget/product/list.tpl" type="mini" head="WHO_BOUGHT_ALSO_BOUGHT"|oxmultilangassign listId="alsoBoughtThankyou" products=$oView->getAlsoBoughtTheseProducts() blDisableToCart=true}]
            [{oxscript add='$(".panel-body","#alsoBoughtThankyou").matchHeight();'}]
        [{/if}]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]
[{include file="layout/page.tpl" sidebar="left"}]