[{if $delivadr}]
   <strong>
      [{if $delivadr->oxaddress__oxcompany->value}][{$delivadr->oxaddress__oxcompany->value}][{$delimiter|default:'<br/>'}][{/if}]
      [{if $delivadr->oxaddress__oxsal->value || $delivadr->oxaddress__oxfname->value || $delivadr->oxaddress__oxlname->value}][{$delivadr->oxaddress__oxsal->value|oxmultilangsal}]&nbsp;[{$delivadr->oxaddress__oxfname->value}]&nbsp;[{$delivadr->oxaddress__oxlname->value}]<br>[{/if}]
   </strong>
   [{if $delivadr->oxaddress__oxstreet->value || $delivadr->oxaddress__oxstreetnr->value}][{$delivadr->oxaddress__oxstreet->value}]&nbsp;[{$delivadr->oxaddress__oxstreetnr->value}][{$delimiter|default:'<br/>'}][{/if}]
   [{if $delivadr->oxaddress__oxaddinfo->value}] [{$delivadr->oxaddress__oxaddinfo->value}][{$delimiter|default:'<br/>'}][{/if}]
   [{if $delivadr->oxaddress__oxstateid->value}][{$delivadr->oxaddress__oxstateid->value}] [{/if}]
   [{if $delivadr->oxaddress__oxzip->value || $delivadr->oxaddress__oxcity->value}][{$delivadr->oxaddress__oxzip->value}]&nbsp;[{$delivadr->oxaddress__oxcity->value}][{$delimiter|default:'<br/>'}][{/if}]
   [{if $delivadr->oxaddress__oxcountry->value}][{$delivadr->oxaddress__oxcountry->value}]<br>[{/if}]
   [{if $delivadr->oxaddress__oxfon->value}]<strong>[{oxmultilang ident="PHONE"}]</strong> [{$delivadr->oxaddress__oxfon->value}][{$delimiter|default:'<br/>'}][{/if}]
   [{if $delivadr->oxaddress__oxfax->value}]<strong>[{oxmultilang ident="FAX"}]</strong> [{$delivadr->oxaddress__oxfax->value}]<br>[{/if}]
   [{capture assign="addressjs"}]
      aShipAddr['[{$delivadr->oxaddress__oxid->value}]'] = {
         'oxaddress__oxcompany': '[{$delivadr->oxaddress__oxcompany->value}]',
         'oxaddress__oxsal': '[{$delivadr->oxaddress__oxsal->value}]',
         'oxaddress__oxfname': '[{$delivadr->oxaddress__oxfname->value}]',
         'oxaddress__oxlname': '[{$delivadr->oxaddress__oxlname->value}]',
         'oxaddress__oxstreet': '[{$delivadr->oxaddress__oxstreet->value}]',
         'oxaddress__oxstreetnr': '[{$delivadr->oxaddress__oxstreetnr->value}]',
         'oxaddress__oxaddinfo': '[{$delivadr->oxaddress__oxaddinfo->value}]',
         'oxaddress__oxzip': '[{$delivadr->oxaddress__oxzip->value}]',
         'oxaddress__oxcity': '[{$delivadr->oxaddress__oxcity->value}]',
         'oxaddress__oxcountryid': '[{$delivadr->oxaddress__oxcountryid->value}]',
         'oxaddress__oxstateid': '[{$delivadr->oxaddress__oxstateid->value}]',
         'oxaddress__oxfon': '[{$delivadr->oxaddress__oxfon->value}]',
         'oxaddress__oxfax': '[{$delivadr->oxaddress__oxfax->value}]'
      };
   [{/capture}]
   [{oxscript add=$addressjs}]
[{/if}]
