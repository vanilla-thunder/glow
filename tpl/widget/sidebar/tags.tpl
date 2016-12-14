[{assign var="oTagsManager" value=$oView->getTagCloudManager()}]
[{block name="dd_widget_sidebar_tags"}]
   [{if $oView->getTagCloudManager()}]
      <p>
         [{foreach from=$oTagsManager->getCloudArray() item="oTag" key="sTagTitle"}]
            [{assign var="iTagSize" value=$oTagsManager->getTagSize($sTagTitle)}]
            [{assign var="sTagPriority" value="success"}]
            [{if $iTagSize == 100}]
               [{assign var="sTagPriority" value="default"}]
            [{elseif $iTagSize == 200}]
               [{assign var="sTagPriority" value="info"}]
            [{elseif $iTagSize == 300}]
               [{assign var="sTagPriority" value="success"}]
            [{elseif $iTagSize == 400}]
               [{assign var="sTagPriority" value="danger"}]
            [{/if}]
            <a class="label label-[{$sTagPriority}] tagitem_[{$iTagSize}]" href="[{$oTag->getLink()}]">[{$oTag->getTitle()}]</a>
         [{/foreach}]
      </p>
      [{block name="dd_widget_sidebar_tags_morelink"}]
         [{if $oView->isMoreTagsVisible()}]
            <div class="text-right">
               <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=tags"}]" class="btn btn-default btn-block btn-sm">[{oxmultilang ident="MORE"}]</a>
            </div>
         [{/if}]
      [{/block}]
   [{/if}]
[{/block}]
