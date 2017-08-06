[{block name="content_main"}]
    [{include file="message/errors.tpl"}]

    [{foreach from=$oxidBlock_content item="_block"}]
        [{$_block|strip}]
    [{/foreach}]
[{/block}]