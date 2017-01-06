<hr/>
<div class="alert alert-success" role="alert">
    [{math equation="x-y" x=$oViewConf->vskfreiab() y=$oxcmp_basket->getBruttoSum() assign="ordermore" format="%.2f"}]
    <a href="[{ oxgetseourl ident='oxdeliveryinfo' type='oxcontent' }]" rel="nofollow">
        [{oxmultilang ident="ORDER_MORE_FOR_FREE_SHIPPING" args=$ordermore|number_format:2:",":' '|cat:$currency->sign }]
    </a>
</div>