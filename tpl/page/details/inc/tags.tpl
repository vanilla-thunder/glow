[{assign var="oDetailsProduct" value=$oView->getProduct()}]
[{if $oView->showTags() && ( $oView->getTagCloudManager() || ( $oxcmp_user && $oDetailsProduct ) )}]

   [{assign var="oCloudManager" value=$oView->getTagCloudManager()}]
   [{if $oCloudManager->getCloudArray()|count < 0}]
      [{oxmultilang ident="NO_TAGS"}]
   [{/if}]
   [{foreach from=$oCloudManager->getCloudArray() item="oTag" name="detailsTags"}]
      <a class="tagitem_[{$oCloudManager->getTagSize($oTag->getTitle())}]" href="[{$oTag->getLink()}]"><span class="label label-default">[{$oTag->getTitle()}]</span></a>
   [{/foreach}]

[{/if}]