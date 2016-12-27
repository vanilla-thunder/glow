[{ assign var="shop"      value=$oEmailView->getShop() }]
[{ assign var="oViewConf" value=$oEmailView->getViewConfig() }]
[{ assign var="user"      value=$oEmailView->getUser() }]

[{capture assign="title"}]
[{$shop->oxshops__oxname->value}] [{oxmultilang ident="NEWSLETTER"}]
[{/capture}]
[{include file="email/plain/header.tpl" title=$shop->oxshops__oxordersubject->value }]

[{ oxcontent ident="oxnewsletterplainemail" }]

[{ oxcontent ident="oxemailfooterplain" }]