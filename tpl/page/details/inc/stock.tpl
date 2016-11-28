<span class="productstock">
   [{if $oDetailsProduct->getStockStatus() == -1}]
      <i class="fa fa-square fa-fw text-danger"></i>
      [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
         [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
      [{elseif $oViewConf->getStockOffDefaultMessage()}]
         [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
      [{/if}]
      [{if $oDetailsProduct->getDeliveryDate()}]
         [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
      [{/if}]
   [{elseif $oDetailsProduct->getStockStatus() == 1}]
      <i class="fa fa-square fa-fw text-warning"></i>[{oxmultilang ident="LOW_STOCK"}]
   [{elseif $oDetailsProduct->getStockStatus() == 0}]
      <i class="fa fa-square fa-fw text-success"></i>
      [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
         [{$oDetailsProduct->oxarticles__oxstocktext->value}]
      [{elseif $oViewConf->getStockOnDefaultMessage()}]
         [{oxmultilang ident="READY_FOR_SHIPPING"}]
      [{/if}]
   [{/if}]
</span>