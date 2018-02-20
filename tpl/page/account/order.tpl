[{capture append="oxidBlock_content"}]
    [{assign var=oOrders value=$oView->getOrderList()}]

    [{block name="account_order_history"}]
        [{if count($oOrders) > 0}]
            [{assign var=oArticleList value=$oView->getOrderArticleList()}]
            <ol class="list-unstyled">
                [{foreach from=$oOrders item=order}]
                    <li>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <h3 class="modal-title">[{oxmultilang ident="ORDER_NUMBER"}] [{$order->oxorder__oxordernr->value}]</h3>
                                    </div>
                                    <div class="col-xs-6">
                                        <strong>[{oxmultilang ident="DD_ORDER_ORDERDATE"}]</strong> [{$order->oxorder__oxorderdate->value|date_format:"%d.%m.%Y %H:%M:%S"}]
                                        <br/>
                                        [{if $order->oxorder__oxstorno->value}]
                                            <strong>[{oxmultilang ident="STATUS"}]</strong>
                                            [{oxmultilang ident="ORDER_IS_CANCELED"}]
                                        [{elseif $oViewConf->getViewThemeParam("blShowOrderState")}]
                                            <strong>[{oxmultilang ident="STATUS"}]</strong>
                                            [{if $order->oxorder__oxsenddate->value !="-"}][{oxmultilang ident="SHIPPED"}][{else}][{oxmultilang ident="NOT_SHIPPED_YET"}][{/if}]
                                        [{/if}]
                                    </div>
                                    <div class="col-xs-6">
                                        <strong>[{oxmultilang ident="SHIPMENT_TO" suffix="COLON"}]</strong>
                                        [{if $order->oxorder__oxdellname->value}]
                                            [{$order->oxorder__oxdelfname->value}]
                                            [{$order->oxorder__oxdellname->value}]
                                        [{else}]
                                            [{$order->oxorder__oxbillfname->value}]
                                            [{$order->oxorder__oxbilllname->value}]
                                        [{/if}]
                                        [{if $order->getShipmentTrackingUrl()}]
                                            <br/>
                                            <strong>[{oxmultilang ident="TRACKING_ID"}]</strong>
                                            <a href="[{$order->getShipmentTrackingUrl()}]">[{oxmultilang ident="TRACK_SHIPMENT"}]</a>
                                        [{/if}]
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <strong>[{oxmultilang ident="CART" suffix="COLON"}]</strong>
                                <ol class="list-unstyled">
                                    [{foreach from=$order->getOrderArticles(true) item=orderitem name=testOrderItem}]
                                        [{assign var=sArticleId value=$orderitem->oxorderarticles__oxartid->value}]
                                        [{assign var=oArticle value=$oArticleList[$sArticleId]}]
                                        <li id="accOrderAmount_[{$order->oxorder__oxordernr->value}]_[{$smarty.foreach.testOrderItem.iteration}]">
                                            [{$orderitem->oxorderarticles__oxamount->value}] [{oxmultilang ident="QNT"}]
                                            [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible()}]
                                            <a id="accOrderLink_[{$order->oxorder__oxordernr->value}]_[{$smarty.foreach.testOrderItem.iteration}]" href="[{$oArticle->getLink()}]">
                                                [{/if}]
                                                [{$orderitem->oxorderarticles__oxtitle->value}] [{$orderitem->oxorderarticles__oxselvariant->value}] <span class="amount"></span>
                                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible()}]
                                            </a>
                                            [{/if}]
                                            [{foreach key=sVar from=$orderitem->getPersParams() item=aParam}]
                                                [{if $aParam}]
                                                    <br/>
                                                    [{oxmultilang ident="DETAILS"}]: [{$aParam}]
                                                [{/if}]
                                            [{/foreach}]
                                            [{* Commented due to Trusted Shops precertification. Enable if needed *}]
                                            [{*
                                            [{oxhasrights ident="TOBASKET"}]
                                            [{if $oArticle->isBuyable()}]
                                              [{if $oArticle->oxarticles__oxid->value}]
                                                <a id="accOrderToBasket_[{$order->oxorder__oxordernr->value}]_[{$smarty.foreach.testOrderItem.iteration}]" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order" params="fnc=tobasket&amp;aid=`$oArticle->oxarticles__oxid->value`&amp;am=1"}]">[{oxmultilang ident="TO_CART"}]</a>
                                              [{/if}]
                                            [{/if}]
                                            [{/oxhasrights}]
                                            *}]
                                            [{if $order|method_exists:'getD3CustomerBoughtUploadArticles'}]
                                                [{* D3 MOD d3fileupload START  *}]
                                                [{d3modcfgcheck modid="d3fileupload"}][{/d3modcfgcheck}]
                                                [{if $mod_d3fileupload && $order->getD3CustomerBoughtUploadArticles()}]
                                                    <div>
                                                        <form action="[{$oViewConf->getSelfActionLink()}]" name="upload" method="post">
                                                            [{$oViewConf->getHiddenSid() }]
                                                            <input type="hidden" name="cl" value="d3uploadmanager">
                                                            <input type="hidden" name="oid" value="[{$order->oxorder__oxid->value}]">
                                                            <input type="hidden" name="uid" value="[{$order->oxorder__oxuserid->value}]">
                                                            <input type="hidden" name="location" value="account">
                                                            <span class="btn"><button class="submitButton largeButton" type="submit">[{ oxmultilang ident="D3_ACCOUNT_ORDER_START_UPLOAD" }]</button></span>
                                                        </form>
                                                    </div>
                                                [{/if}]
                                                [{* D3 MOD d3fileupload END  *}]
                                            [{/if}]
                                        </li>
                                    [{/foreach}]
                                </ol>
                            </div>
                        </div>
                    </li>
                [{/foreach}]
            </ol>
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigation() place="bottom"}]
        [{else}]
            [{oxmultilang ident="ORDER_EMPTY_HISTORY"}]
        [{/if}]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{capture append="oxidBlock_sidebar"}]
    [{include file="page/account/inc/account_menu.tpl" active_link="orderhistory"}]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left"}]