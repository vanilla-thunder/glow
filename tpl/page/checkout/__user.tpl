[{capture append="oxidBlock_content"}]

   [{* ordering steps *}]
   [{include file="page/checkout/inc/steps.tpl" active=2}]

   [{block name="checkout_user_main"}]
      [{if !$oxcmp_user && !$oView->getLoginOption()}]
         [{include file="page/checkout/inc/options.tpl"}]
      [{ else }]
         [{include file="form/user_checkout.tpl"}]
      [{/if}]
   [{/block}]
   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl"}]