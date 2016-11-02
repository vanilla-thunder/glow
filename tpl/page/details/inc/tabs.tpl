[{block name="details_tabs_main"}]

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
   [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]

   [{block name="details_tabs_longdescription"}]
      [{if $oLongdesc->value}]
         <div class="panel panel-default">
            <div id="longdescHeading" class="panel-heading" role="tab">
               <h3 class="panel-title">
                  <a href="#longdescContent" aria-controls="longdescContent" role="button" data-toggle="collapse" data-parent="#accordion" aria-expanded="true">
                     [{block name="details_tabs_longdescription_heading"}]
                        [{oxmultilang ident="DESCRIPTION"}]
                     [{/block}]
                  </a>
               </h3>
            </div>
            <div id="longdescContent" aria-labelledby="longdescHeading" class="panel-collapse collapse in" role="tabpanel">
               <div class="panel-body">
                  [{block name="details_tabs_longdescription_content"}]
                     [{oxeval var=$oLongdesc}]
                     [{if $oDetailsProduct->oxarticles__oxexturl->value}]
                        <a id="productExturl" class="js-external" href="http://[{$oDetailsProduct->oxarticles__oxexturl->value}]">
                           [{if $oDetailsProduct->oxarticles__oxurldesc->value}][{$oDetailsProduct->oxarticles__oxurldesc->value}]
                           [{else}][{$oDetailsProduct->oxarticles__oxexturl->value}][{/if}]
                        </a>
                     [{/if}]
                  [{/block}]
               </div>
            </div>
         </div>
      [{/if}]
   [{/block}]

   [{block name="details_tabs_media"}]
      [{if $oView->getMediaFiles() || $oDetailsProduct->oxarticles__oxfile->value}]
         <div class="panel panel-default">
            <div id="mediaHeading" class="panel-heading" role="tab">
               <h3 class="panel-title">
                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#mediaContent" aria-expanded="true" aria-controls="mediaContent">
                     [{block name="details_tabs_media_heading"}]
                        [{oxmultilang ident="MEDIA"}]
                     [{/block}]
                  </a>
               </h3>
            </div>
            <div id="mediaContent" aria-labelledby="mediaHeading" class="panel-collapse collapse in" role="tabpanel">
               <div class="panel-body">
                  [{block name="details_tabs_media_content"}]
                     [{include file="page/details/inc/media.tpl"}]
                  [{/block}]
               </div>
            </div>
         </div>
      [{/if}]
   [{/block}]

   [{block name="details_tabs_attributes"}]
      [{if $oView->getAttributes()}]
         <div class="panel panel-default">
            <div id="attributesHeading" class="panel-heading" role="tab">
               <h3 class="panel-title">
                  <a href="#attributesContent" aria-controls="attributesContent" role="button" data-toggle="collapse" data-parent="#accordion" aria-expanded="true">
                     [{block name="details_tabs_attributes_heading"}][{oxmultilang ident="SPECIFICATION"}][{/block}]
                  </a>
               </h3>
            </div>
            <div id="attributesContent" aria-labelledby="attributesHeading" class="panel-collapse collapse in" role="tabpanel">
               <div class="panel-body">
                  [{block name="details_tabs_attributes_content"}][{include file="page/details/inc/attributes.tpl"}][{/block}]
               </div>
            </div>
         </div>
      [{/if}]
   [{/block}]

   [{*
   [{block name="details_tabs_xxx"}]
   <div class="panel panel-default">
      <div id="xxxHeading" class="panel-heading" role="tab">
         <h3 class="panel-title">
            <a href="#longdescContent" aria-controls="longdescContent" role="button" data-toggle="collapse" data-parent="#accordion" aria-expanded="true" >
            [{block name="details_tabs_xxx_heading"}]

            [{/block}]
            </a>
         </h3>
      </div>
      <div id="longdescContent" aria-labelledby="longdescHeading" class="panel-collapse collapse in" role="tabpanel">
         <div class="panel-body">
            [{block name="details_tabs_xxx_content"}]
            [{/block}]
         </div>
      </div>
   </div>
   [{/block}]
   *}]

   [{* TODO Preisalarm. fliegt doch bald raus, oder? *}]
   [{*
[{block name="details_tabs_pricealarm"}]
   [{if $oView->isPriceAlarm() && !$oDetailsProduct->isParentNotBuyable()}]
      <a href="#pricealarm" data-toggle="tab">[{oxmultilang ident="PRICE_ALERT"}]</a>[{/capture}]
      <div id="pricealarm" class="tab-pane[{if $blFirstTab}] active[{/if}]">[{include file="form/pricealarm.tpl"}]</div>
   [{/if}]
[{/block}]
*}]
</div>
[{/block}]

[{block name="details_tabs_tags"}]
   [{if $oView->showTags() && ( $oView->getTagCloudManager() || ( ( $oView->getTagCloudManager() || $oxcmp_user) && $oDetailsProduct ) )}]
      <div class="panel panel-default">
         <div class="panel-body">
            <b>[{oxmultilang ident="TAGS" suffix="COLON"}]</b>
            [{oxid_include_dynamic file="page/details/inc/tags.tpl"}]
         </div>
      </div>
   [{/if}]
[{/block}]
[{block name="details_tabs_facebook"}][{/block}]