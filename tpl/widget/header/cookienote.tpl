[{if $oView->isEnabled() && $smarty.cookies.displayedCookiesNotification != '1'}]
   <div id="kekse" class="alert alert-info main-row" style="margin:0;" role="alert">
      <button type="button" class="close" data-dismiss="alert">
         <span aria-hidden="true">&times;</span><span class="sr-only">[{oxmultilang ident='COOKIE_NOTE_CLOSE'}]</span>
      </button>
      <div class="text-center">
      [{oxmultilang ident='COOKIE_NOTE'}]
      <b><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=clearcookies"}]" title="[{oxmultilang ident='COOKIE_NOTE_DISAGREE'}]">[{oxmultilang ident='COOKIE_NOTE_DISAGREE'}]</a></b>
      </div>
   </div>
   <!-- [{'displayedCookiesNotification'|setcookie:'1'}] -->
[{/if}]