[{d3modcfgcheck modid="d3heidelpay"}][{/d3modcfgcheck}]
[{if $mod_d3heidelpay && $oView->d3IsHeidelpayPaymentMethode($paymentmethod)}]
    -- [{ $oView->d3GetPaymentFormTemplateName($paymentmethod) }] --
    <br/>
    [{if $oViewConf->getModulePath('d3heidelpay',$oView->d3GetPaymentFormTemplateName($paymentmethod)) }]
        [{include file=$oViewConf->getModulePath('d3heidelpay',$oView->d3GetPaymentFormTemplateName($paymentmethod)) }]
    [{else}][{include file=$oView->d3GetPaymentFormTemplateName($paymentmethod)}][{/if}]
[{else}]
    [{$smarty.block.parent}]
[{/if}]
