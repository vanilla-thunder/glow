[{oxscript include="js/pages/details.min.js" priority=10}]

[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
   [{assign var="_sSelectionHashCollection" value=""}]
   [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
      [{assign var="_sSelectionHash" value=""}]
      [{foreach from=$oSelectionList item=oListItem key=iPos}]
         [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
      [{/foreach}]
      [{if $_sSelectionHash}]
         [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
         [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
      [{/if}]
   [{/foreach}]
   [{oxscript add="oxVariantSelections  = [`$_sSelectionHashCollection`];"}]
   <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
      <div>
         [{$oViewConf->getHiddenSid()}]
         [{$oViewConf->getNavFormParams()}]
         <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
         <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
         <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
         <input type="hidden" name="nocookie" value="1">
         <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
         <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
         <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
      </div>
   </form>
[{/if}]

<div class="detailsInfo clear">

   [{block name="details_productmain_title"}]
      <h1 class="text-center">[{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]</h1>
   [{/block}]

   <div class="row">
      [{* article picture with zoom *}]
      <div class="col-xs-12 col-sm-5">
         [{block name="details_productmain_zoom"}]
            <div class="picture">
               <a href="[{$oPictureProduct->getZoomPictureUrl(1)}]" id="zoom1" class="thumbnail" rel="produktbilder">
                  <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
               </a>
            </div>
            [{oxscript add='$(".thumbnail").fancybox();'}]
         [{/block}]

         [{block name="details_productmain_morepics"}]
            [{include file="page/details/inc/morepics.tpl"}]
         [{/block}]
      </div>

      [{* product info *}]
      <div class="col-xs-12 col-sm-7">
         [{* article number *}]
         [{block name="details_productmain_artnumber"}]
            <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}] <span >[{$oDetailsProduct->oxarticles__oxartnum->value}]</span></span>
         [{/block}]

         [{* ratings *}]
         <div class="star-ratings">
            [{if $oView->ratingIsActive()}]
               [{block name="details_productmain_ratings"}]
                  [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
               [{/block}]
            [{/if}]
         </div>

         [{* short description *}]
         [{block name="details_productmain_shortdesc"}]
            [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
               <p class="shortdesc" id="productShortdesc" >[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
            [{/if}]
         [{/block}]

         [{if $oDetailsProduct->oxarticles__oxweight->value}]
            <div class="weight">
               [{block name="details_productmain_weight"}]
                  [{oxmultilang ident="WEIGHT" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]
               [{/block}]
            </div>
         [{/if}]

         <hr/>

         <form class="js-oxProductForm form-horizontal" action="[{$oViewConf->getSelfActionLink()}]" method="post">
            <div class="hidden">
               [{$oViewConf->getHiddenSid()}]
               [{$oViewConf->getNavFormParams()}]
               <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
               <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
               <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
               <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
               <input type="hidden" name="panid" value="">
               [{if !$oDetailsProduct->isNotBuyable()}]
                  <input type="hidden" name="fnc" value="tobasket">
               [{/if}]
            </div>

            [{assign var="blCanBuy" value=true}]

            [{* variants | md variants *}]
            [{block name="details_productmain_variantselections"}]
               [{if $aVariantSelections && $aVariantSelections.selections}]
                  [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                  [{if !$blHasActiveSelections}]
                     [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                        [{assign var="blCanBuy" value=true}]
                     [{/if}]
                  [{/if}]
                  <div id="variants">
                     [{assign var="blHasActiveSelections" value=false}]
                     [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                        [{if $oList->getActiveSelection()}]
                           [{assign var="blHasActiveSelections" value=true}]
                        [{/if}]
                        [{include file="page/details/inc/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                     [{/foreach}]
                  </div>
               [{/if}]
            [{/block}]

            [{* selection lists *}]
            [{block name="details_productmain_selectlists"}]
               [{if $oViewConf->showSelectLists()}]
                  <div id="selectionlists">
                     [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                     [{if $oSelections}]
                        <div>
                           [{foreach from=$oSelections item=oList name=selections}]
                              [{include file="page/details/inc/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                           [{/foreach}]
                        </div>
                     [{/if}]
                  </div>
               [{/if}]
            [{/block}]

            [{* pers params *}]
            [{block name="details_productmain_persparams"}]
               [{if $oView->isPersParam()}]
                  <div id="persparam" class="form-group">
                     <label for="persistentParam" class="col-xs-12 col-sm-3 control-label"><strong>[{oxmultilang ident="YOUR_MESSAGE" suffix="COLON"}]</strong></label>
                     <div class="col-xs-12 col-sm-9">
                        <input id="persistentParam" class="form-control" type="text" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35">
                     </div>
                  </div>
               [{/if}]
            [{/block}]

            [{block name="details_productmain_vpe"}]
               [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                  <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                  <br>
               [{/if}]
            [{/block}]

            <div class="row">
               <div class="col-xs-12 col-md-6"   >

                  [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                  [{assign var=price  value=$oDetailsProduct->getPrice()}]

                  <div class="priceinfo [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]reduced[{/if}] text-center">
                     [{block name="details_productmain_tprice"}]
                        [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                           <div class="tprice">
                              <span class="h4">[{oxmultilang ident="REDUCED_FROM"}] [{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]</span>
                              <em>[{oxmultilang ident="OUR_REGULAR_PRICE"}]</em>
                           </div>
                        [{/if}]
                     [{/block}]

                     [{block name="details_productmain_price"}]
                        [{block name="details_productmain_price_value"}]
                           [{if $oDetailsProduct->getFPrice()}]
                              [{assign var="sFrom" value=""}]
                              [{assign var="fPrice" value=$oDetailsProduct->getFPrice()}]

                              [{if $oDetailsProduct->isParentNotBuyable()}]
                                 [{assign var="fPrice" value=$oDetailsProduct->getFVarMinPrice()}]
                                 [{if $oDetailsProduct->isRangePrice()}]
                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                 [{/if}]
                              [{/if}]
                              <strong class="h2">
                                 <span class="price-from">[{$sFrom}]</span>
                                 <span class="price">[{$fPrice}]</span>
                                 <span class="currency">[{$currency->sign}]</span>
                                 <span class="price-markup">[{include file="page/details/inc/vatinfo.tpl"}]</span>
                              </strong>
                           [{/if}]

                           [{if $oDetailsProduct->loadAmountPriceInfo()}]
                              [{include file="page/details/inc/priceinfo.tpl"}]
                           [{/if}]
                        [{/block}]
                     [{/block}]

                     [{* price per unit *}]
                     [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                     [{block name="details_productmain_priceperunit"}]
                        [{if $oUnitPrice}]
                           [{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]
                        [{/if}]
                     [{/block}]

                  </div>
               </div>
               <div class="col-xs-12 col-md-6">
                  [{block name="details_productmain_tobasket"}]
                     [{if !$oDetailsProduct->isNotBuyable()}]
                        [{if $blCanBuy}]
                           <div class="input-group input-group-lg">
                              <input id="amountToBasket" title="[{oxmultilang ident='GENERAL_SUM'}]" type="number" name="am" value="1" autocomplete="off" class="form-control text-center large">
                              <span class="input-group-btn">
                                 <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary">
                                    <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]
                                 </button>
                              </span>
                           </div>
                        [{else}]
                           <div class="alert alert-warning text-center">[{oxmultilang ident="DETAILS_CHOOSEVARIANT"}]</div>
                        [{/if}]
                     [{/if}]
                  [{/block}]

                  [{if $blCanBuy}]
                     [{* product stock *}]
                     [{block name="details_productmain_stockstatus"}]
                        [{if $oDetailsProduct->getStockStatus() == -1}]
                           <span class="stockFlag notOnStock">
                                <i class="fa fa-circle text-danger"></i>
                              [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                                 [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                              [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                 [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                              [{/if}]
                              [{if $oDetailsProduct->getDeliveryDate()}]
                                 [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                              [{/if}]
                           </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 1}]
                           <span class="stockFlag lowStock">
                              <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK"}]
                           </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 0}]
                           <span class="stockFlag">
                              <i class="fa fa-circle text-success"></i>
                              [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                 [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                              [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                 [{oxmultilang ident="READY_FOR_SHIPPING"}]
                              [{/if}]
                           </span>
                        [{/if}]
                     [{/block}]
                  [{/if}]

                  [{if $oDetailsProduct->isBuyable()}]
                     [{block name="details_productmain_deliverytime"}]
                        [{include file="page/details/inc/deliverytime.tpl"}]
                     [{/block}]
                  [{/if}]

               </div>
            </div>

         </form>

            <hr/>
            blCanBuy: [{$blCanBuy|var_dump}]<br/>
            isBuyable: [{$oDetailsProduct->isBuyable()|var_dump}]
            <hr/>

            [{block name="details_productmain_watchlist"}][{/block}]

            [{block name="details_productmain_social"}]
               <div class="social">
                  [{if ( $oView->isActive('FbShare') || $oView->isActive('FbLike') && $oViewConf->getFbAppId() )}]
                     [{if $oView->isActive('FacebookConfirm') && !$oView->isFbWidgetVisible() }]
                        <div class="socialButton" id="productFbShare">
                           [{include file="widget/facebook/enable.tpl" source="widget/facebook/share.tpl" ident="#productFbShare"}]
                           [{include file="widget/facebook/like.tpl" assign="fbfile"}]
                           [{assign var='fbfile' value=$fbfile|strip|escape:'url'}]
                           [{oxscript add="oxFacebook.buttons['#productFbLike']={html:'`$fbfile`',script:''};"}]
                        </div>
                        <div class="socialButton" id="productFbLike"></div>
                     [{else}]
                        <div class="socialButton" id="productFbShare">
                           [{include file="widget/facebook/enable.tpl" source="widget/facebook/share.tpl" ident="#productFbShare"}]
                        </div>
                        <div class="socialButton" id="productFbLike">
                           [{include file="widget/facebook/enable.tpl" source="widget/facebook/like.tpl" ident="#productFbLike"}]
                        </div>
                     [{/if}]
                  [{/if}]
               </div>
            [{/block}]



      </div>
   </div>
</div>