[{block name="content_main"}]
<div class="container">
    [{include file="message/errors.tpl"}]

    [{foreach from=$oxidBlock_content item="_block"}]
        [{$_block|strip}]
    [{/foreach}]
</div>
[{/block}]