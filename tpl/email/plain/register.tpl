[{assign var="shop"      value=$oEmailView->getShop() }]
[{assign var="oViewConf" value=$oEmailView->getViewConfig() }]
[{assign var="user"      value=$oEmailView->getUser() }]

[{include file="email/plain/header.tpl" title="EMAIL_TITLE_WELCOME_TO"|oxmultilangassign|cat:$shop->oxshops__oxname->value}]


[{ oxcontent ident=$contentplainident|default:"oxregisterplainemail" }]

[{ oxcontent ident="oxemailfooterplain" }]