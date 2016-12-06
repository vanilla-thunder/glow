[{if $oView->isEnabledPrivateSales()}]
   [{capture append="oxidBlock_pageBody"}]
      [{oxid_include_widget cl="oxwCookieNote" _parent=$oView->getClassName() nocookie=1}]
   [{/capture}]
[{/if}]

[{capture append="oxidBlock_content"}]
   [{assign var="template_title" value="OPEN_ACCOUNT"|oxmultilangassign}]
   [{if $oView->isActive('PsLogin')}]
      [{include file="message/errors.tpl"}]
   [{/if}]

   <div class="page-header">
      <h1>[{oxmultilang ident="OPEN_ACCOUNT"}]</h1>
   </div>
   [{include file="form/register.tpl"}]

   [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{if $oView->isActive('PsLogin')}]
   [{include file="layout/popup.tpl"}]
[{else}]
   [{include file="layout/page.tpl" sidebar="Right"}]
[{/if}]