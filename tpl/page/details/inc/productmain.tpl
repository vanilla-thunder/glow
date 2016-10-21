[{oxscript include="js/pages/details.min.js" priority=10}]

[{assign var="oConfig" value=$oViewConf->getConfig()}]
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

<div class="detailsInfo clear" itemscope itemtype="http://schema.org/Product">
   <div class="row">
      [{* article picture with zoom *}]
      <div class="col-xs-12 col-md-6">
         [{block name="details_productmain_zoom"}]
            <div class="picture">
               <a href="[{$oPictureProduct->getZoomPictureUrl(1)}]" id="zoom1" class="thumbnail">
                  <img src="[{$oView->getActPicture()}]" itemprop="image"
                       alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
               </a>
            </div>
         [{/block}]

         [{block name="details_productmain_morepics"}]
            [{include file="page/details/inc/morepics.tpl"}]
         [{/block}]
      </div>

      [{* product info *}]
      <div class="col-xs-12 col-md-6">
         [{block name="details_productmain_title"}]
            <h1 id="productTitle" itemprop="name">
               [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
            </h1>
         [{/block}]

         [{* article number *}]
         [{block name="details_productmain_artnumber"}]
            <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</span>
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
            [{oxhasrights ident="SHOWSHORTDESCRIPTION"}]
            [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
               <p class="shortdesc" id="productShortdesc" itemprop="description">[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
            [{/if}]
            [{/oxhasrights}]
         [{/block}]

         [{oxhasrights ident="TOBASKET"}]
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
            [{/oxhasrights}]
            [{* article main info block *}]
            <div class="information" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
               <div class="productMainInfo[{if $oManufacturer->oxmanufacturers__oxicon->value}] hasBrand[{/if}] row">

                  [{* additional info *}]
                  <div class="additionalInfo clearfix">
                     [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                     [{block name="details_productmain_priceperunit"}]
                        [{if $oUnitPrice}]
                           <span id="productPriceUnit">[{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]</span>
                        [{/if}]
                     [{/block}]
                  </div>

                  [{if $oDetailsProduct->oxarticles__oxweight->value}]
                     <div class="weight">
                        [{block name="details_productmain_weight"}]
                           [{oxmultilang ident="WEIGHT" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]
                        [{/block}]
                     </div>
                  [{/if}]

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
                        <div id="variants" class="selectorsBox js-fnSubmit clear">
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
               </div>

               [{* selection lists *}]
               [{block name="details_productmain_selectlists"}]
                  [{if $oViewConf->showSelectLists()}]
                     [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                     [{if $oSelections}]
                        <div class="selectorsBox [{* js-fnSubmit *}] clear" id="productSelections">
                           [{foreach from=$oSelections item=oList name=selections}]
                              [{include file="page/details/inc/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                           [{/foreach}]
                        </div>
                     [{/if}]
                  [{/if}]
               [{/block}]

               [{* pers params *}]
               [{block name="details_productmain_persparams"}]
                  [{if $oView->isPersParam()}]
                     <div class="persparamBox clear form-group">
                        <label for="persistentParam" class="control-label">[{oxmultilang ident="LABEL"}]</label>
                        <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35" class="form-control">
                     </div>
                  [{/if}]
               [{/block}]

               <div class="pricebox">
                  [{block name="details_productmain_tprice"}]
                     [{oxhasrights ident="SHOWARTICLEPRICE"}]
                     [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                     [{assign var=price  value=$oDetailsProduct->getPrice()}]
                     [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                        <del>[{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]</del>
                        <br/>
                     [{/if}]
                     [{/oxhasrights}]
                  [{/block}]

                  [{block name="details_productmain_vpe"}]
                     [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                        <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                        <br>
                     [{/if}]
                  [{/block}]


                  [{block name="details_productmain_price"}]
                     [{oxhasrights ident="SHOWARTICLEPRICE"}]
                     [{block name="details_productmain_price_value"}]
                        [{if $oDetailsProduct->getFPrice()}]
                           <label id="productPrice" class="price">
                              [{assign var="sFrom" value=""}]
                              [{assign var="fPrice" value=$oDetailsProduct->getFPrice()}]
                              [{if $oDetailsProduct->isParentNotBuyable()}]
                                 [{assign var="fPrice" value=$oDetailsProduct->getFVarMinPrice()}]
                                 [{if $oDetailsProduct->isRangePrice()}]
                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                 [{/if}]
                              [{/if}]
                              <span[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}] class="text-danger"[{/if}]>
                                            <span class="price-from">[{$sFrom}]</span>
                                            <span class="price">[{$fPrice}]</span>
                                            <span class="currency">[{$currency->sign}]</span>
                                 [{if $oView->isVatIncluded()}]
                                    <span class="price-markup">*</span>
                                 [{/if}]
                                 <span class="hidden">
                                                <span itemprop="price">[{$fPrice}] [{$currency->sign}]</span>
                                            </span>
                                        </span>
                           </label>
                        [{/if}]
                        [{if $oDetailsProduct->loadAmountPriceInfo()}]
                           [{include file="page/details/inc/priceinfo.tpl"}]
                        [{/if}]
                     [{/block}]
                     [{/oxhasrights}]


                     [{block name="details_productmain_watchlist"}][{/block}]
                  [{/block}]
               </div>

               <div class="tobasket">


                  [{block name="details_productmain_tobasket"}]
                     <div class="tobasketFunction clear">
                        [{oxhasrights ident="TOBASKET"}]
                        [{if !$oDetailsProduct->isNotBuyable()}]
                           <div class="input-group">
                              <input id="amountToBasket" type="text" name="am" value="1" autocomplete="off" class="form-control">
                              <div class="input-group-tweak">
                                 <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary submitButton largeButton">
                                    <i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]</button>
                              </div>
                           </div>
                        [{/if}]
                        [{/oxhasrights}]
                     </div>
                  [{/block}]

                  [{block name="details_productmain_stockstatus"}]
                     [{if $oDetailsProduct->getStockStatus() == -1}]
                        <span class="stockFlag notOnStock">
                                <i class="fa fa-circle text-danger"></i>
                           [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                              <link itemprop="availability" href="http://schema.org/OutOfStock"/>






                                                                                                                                                                                                                                                                                                   [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                                [{elseif $oViewConf->getStockOffDefaultMessage()}]






                              <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                              [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                           [{/if}]
                           [{if $oDetailsProduct->getDeliveryDate()}]
                              <link itemprop="availability" href="http://schema.org/PreOrder"/>
                              [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                           [{/if}]
                            </span>
                     [{elseif $oDetailsProduct->getStockStatus() == 1}]
                        <link itemprop="availability" href="http://schema.org/InStock"/>
                        <span class="stockFlag lowStock">
                                <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK"}]
                            </span>
                     [{elseif $oDetailsProduct->getStockStatus() == 0}]
                        <span class="stockFlag">
                                <link itemprop="availability" href="http://schema.org/InStock"/>
                                <i class="fa fa-circle text-success"></i>
                           [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                              [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                           [{elseif $oViewConf->getStockOnDefaultMessage()}]
                              [{oxmultilang ident="READY_FOR_SHIPPING"}]
                           [{/if}]
                            </span>
                     [{/if}]
                  [{/block}]

                  [{oxhasrights ident="TOBASKET"}]
                  [{if $oDetailsProduct->isBuyable()}]
                     <span class="deliverytime">
                                [{block name="details_productmain_deliverytime"}]
                                   [{include file="page/details/inc/deliverytime.tpl"}]
                                [{/block}]
                            </span>
                  [{/if}]
                  [{/oxhasrights}]

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

            [{oxhasrights ident="TOBASKET"}]
         </form>
         [{/oxhasrights}]
      </div>
   </div>
</div>