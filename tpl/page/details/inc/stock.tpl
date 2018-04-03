<span class="productstock">
   [{if $oDetailsProduct->getStockStatus() == -1}]
         <i class="fa fa-square fa-fw text-danger"></i>
      [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
       [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
   [{elseif $oViewConf->getStockOffDefaultMessage()}]
       [{oxmultilang ident=$oViewConf->getViewThemeParam("sOutOfStockIdent")|default:"MESSAGE_NOT_ON_STOCK"}]
   [{/if}]
      [{if $oDetailsProduct->getDeliveryDate()}]
       [{oxmultilang ident=$oViewConf->getViewThemeParam("sAvailableOnIdent")|default:"AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
   [{/if}]
   [{elseif $oDetailsProduct->getStockStatus() == 1}]
      <i class="fa fa-square fa-fw text-warning"></i>
      [{oxmultilang ident=$oViewConf->getViewThemeParam("sLowStockIdent")|default:"LOW_STOCK"}]
   [{elseif $oDetailsProduct->getStockStatus() == 0}]
      <i class="fa fa-square fa-fw text-success"></i>
       [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
           [{$oDetailsProduct->oxarticles__oxstocktext->value}]
       [{elseif $oViewConf->getStockOnDefaultMessage()}]
           [{oxmultilang ident=$oViewConf->getViewThemeParam("sHighStockIdent")|default:"READY_FOR_SHIPPING"}]
       [{/if}]
   [{/if}]
</span>