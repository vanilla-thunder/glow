[{strip}][{assign var="user"      value=$oEmailView->getUser() }]
   BLA [{if $user->getUserCountry() == "Deutschland"}]DE[{else}]AT[{/if}] Bestellung (# [{$order->oxorder__oxordernr->value}])
[{/strip}]