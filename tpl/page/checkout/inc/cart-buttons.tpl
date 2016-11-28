[{assign var="prev" value=$prev|default:false}]
[{assign var="next" value=$next|default:false}]

<div class="cart-buttons clearfix">
   [{if $prev}]
      <a href="[{$prev}]" class="btn btn-default stepback"><i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
   [{/if}]
   [{if $next}]
      <button class="btn btn-success btn-lg pull-right nextstep" name="userform" type="submit">
         [{oxmultilang ident=$next}] <i class="fa fa-caret-right"></i>
      </button>
   [{/if}]
</div>
