[{strip}][{assign var="user" value=$oEmailView->getUser() }]
   [{$shop->oxshops__oxname->value }] [{if $user->getUserCountry() == "Deutschland"}]DE[{else}]AT[{/if}] Bestellung (# [{$order->oxorder__oxordernr->value}])
[{/strip}]