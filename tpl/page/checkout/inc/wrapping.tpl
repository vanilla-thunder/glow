[{assign var="currency" value=$oView->getActCurrency()}]

<div class="modal fade" id="giftoptions" tabindex="-1" role="dialog" aria-labelledby="giftoptions_modal_label" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            [{block name="checkout_wrapping_header"}]
               <span class="h4 modal-title" id="giftoptions_modal_label">[{oxmultilang ident="GIFT_WRAPPING_GREETING_CARD"}]</span>
            [{/block}]
         </div>
         <div class="modal-body">
            <div class="media">
               <div class="media-left">
                  <a href="#">
                     <img class="media-object" src="[{$oViewConf->getImageUrl('gift-wrapping.jpg')}]" alt="[{oxmultilang ident="ADD_WRAPPING"}]">
                  </a>
               </div>
               <div class="media-body">
                  <h4 class="media-heading">[{oxmultilang ident="WRAPPING_DESCRIPTION"}]</h4>
               </div>
            </div>

            [{block name="checkout_wrapping_contents"}]
               <h3 class="page-header">[{oxmultilang ident="ADD_WRAPPING"}]</h3>
               [{if !$oxcmp_basket->getProductsCount()}]
                  <div class="alert alert-danger">[{oxmultilang ident="BASKET_EMPTY"}]</div>
               [{else}]
                  <form name="basket" action="[{$oViewConf->getSelfActionLink()}]" method="post" role="form" id="giftoptions_modal_form">
                     <div class="hidden">
                        [{$oViewConf->getHiddenSid()}]
                        <input type="hidden" name="cl" value="basket">
                        <input type="hidden" name="fnc" value="changewrapping">
                     </div>

                     [{if $oView->getWrappingList()|@count}]
                        [{* basket items *}]
                        [{assign var="basketitemlist" value=$oView->getBasketArticles()}]
                        [{foreach key=basketindex from=$oxcmp_basket->getContents() item=basketitem name=wrappArt}]
                           [{assign var="basketproduct" value=$basketitemlist.$basketindex}]
                           <hr/>
                           [{block name="checkout_wrapping_item"}]
                              <div class="row">
                                 <div class="col-xs-4 col-sm-3 col-md-2">
                                    <img src="[{$basketproduct->getIconUrl()}]" alt="[{$basketitem->getTitle()|strip_tags}]" class="">
                                 </div>
                                 <div class="col-xs-8">
                                    <p class="lead">[{$basketitem->getTitle()}]</p>
                                 </div>
                              </div>
                              <div id="wrapp_[{$smarty.foreach.wrappArt.iteration}]" class="row">

                                 <div class="col-xs-12 col-sm-4 col-md-3 form-group">
                                    <div class="radio">
                                       <label>
                                          <input class="radiobox" type="radio" name="wrapping[[{$basketindex}]]" id="wrapping_[{$basketindex}]" value="0" [{if !$basketitem->getWrappingId()}]CHECKED[{/if}]>
                                          [{oxmultilang ident="NONE"}] <strong>0,00 [{$currency->sign}]</strong>
                                       </label>
                                    </div>
                                 </div>
                                 [{foreach from=$oView->getWrappingList() item=wrapping name=Wraps}]
                                    <div class="col-xs-6 col-sm-4 col-md-3 form-group">
                                       <div class="radio">
                                          <label>
                                             <input class="radiobox" type="radio" name="wrapping[[{$basketindex}]]" id="wrapping_[{$wrapping->oxwrapping__oxid->value}]" value="[{$wrapping->oxwrapping__oxid->value}]" [{if $basketitem->getWrappingId() == $wrapping->oxwrapping__oxid->value}]CHECKED[{/if}]>
                                             <div class="text-center">
                                                [{$wrapping->oxwrapping__oxname->value}]<br/>
                                                <strong>[{$wrapping->getFPrice()}] [{$currency->sign}]</strong>
                                             </div>
                                             [{if $wrapping->oxwrapping__oxpic->value}]
                                                <img src="[{$wrapping->getPictureUrl()}]" alt="[{$wrapping->oxwrapping__oxname->value}]" class="img-thumbnail">
                                             [{/if}]
                                          </label>
                                       </div>
                                    </div>
                                 [{/foreach}]
                              </div>
                           [{/block}]
                        [{/foreach}]
                     [{/if}]

                     [{if $oView->getCardList()|@count}]
                        <h3 class="page-header">[{oxmultilang ident="GREETING_CARD"}]</h3>
                        <div class="wrappingCard clear" id="wrappCard">
                           [{block name="checkout_wrapping_cards"}]
                              <div class="row">
                                 <div class="col-xs-12 col-sm-4 col-md-3">
                                    <div class="form-group">
                                       <div class="radio">
                                          <label>
                                             <input type="radio" class="radiobox" name="chosencard" id="chosencard" value="0" [{if !$oxcmp_basket->getCardId()}]CHECKED[{/if}]> [{oxmultilang ident="NO_GREETING_CARD"}]
                                          </label>
                                       </div>
                                    </div>
                                 </div>
                                 [{foreach from=$oView->getCardList() item=card name=GreetCards}]
                                    <div class="col-xs-6 col-sm-4 col-md-3">
                                       <div class="form-group">
                                          <div class="radio">
                                             <label>
                                                <input class="radiobox" type="radio" name="chosencard" id="chosen_[{$card->oxwrapping__oxid->value}]" value="[{$card->oxwrapping__oxid->value}]" [{if $oxcmp_basket->getCardId() == $card->oxwrapping__oxid->value}]CHECKED[{/if}]>
                                                <div class="text-center">
                                                   [{$card->oxwrapping__oxname->value}]<br/>
                                                   <strong>[{$card->getFPrice()}] [{$currency->sign}]</strong>
                                                </div>
                                                [{if $card->oxwrapping__oxpic->value}]
                                                   <img src="[{$card->getPictureUrl()}]" alt="[{$card->oxwrapping__oxname->value}]" class="img-thumbnail">
                                                [{/if}]
                                             </label>
                                          </div>
                                       </div>
                                    </div>
                                 [{/foreach}]
                              </div>
                           [{/block}]

                           [{block name="checkout_wrapping_comment"}]
                              <div class="form-group wrappingComment">
                                 <label for="giftmessage" class="control-label">[{oxmultilang ident="GREETING_MESSAGE"}]</label>
                                 <textarea cols="102" rows="5" name="giftmessage" id="giftmessage" class="form-control">[{$oxcmp_basket->getCardMessage()}]</textarea>
                              </div>
                           [{/block}]
                        </div>
                     [{/if}]
                  </form>
               [{/if}]
            [{/block}]
         </div>
         <div class="modal-footer">
            [{block name="checkout_wrapping_submit"}]
               <button type="button" class="btn btn-default" data-dismiss="modal">[{oxmultilang ident="PREVIOUS"}]</button>
               <button type="submit" class="btn btn-primary" onclick="window.giftoptions_modal_form.submit();return false;">[{oxmultilang ident="APPLY"}]</button>
            [{/block}]
         </div>
      </div>
   </div>
</div>