[{assign var="oConfig" value=$oViewConf->getConfig()}]

[{if $oView->morePics()}]
   <ul class="list-inline">
      [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
         [{if !$smarty.foreach.sMorePics.first}]
         <li>
            <a id="morePics_[{$smarty.foreach.sMorePics.iteration}]" class="thumbnail" href="[{$oPictureProduct->getZoomPictureUrl($iPicNr)}]" rel="produktbilder">
               <img src="[{$oPictureProduct->getIconUrl($iPicNr)}]" alt="[{oxmultilang ident="OXTHUMB"}] [{$smarty.foreach.sMorePics.iteration}]">
            </a>
         </li>
         [{/if}]
      [{/foreach}]
   </ul>
[{/if}]