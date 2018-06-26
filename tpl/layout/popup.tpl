[{block name="content_main"}]
    <div class="[{if $smarty.get.ajax != 1}]container[{/if}]">
        [{include file="message/errors.tpl"}]
        [{foreach from=$oxidBlock_content item="_block"}]
            [{$_block|strip}]
        [{/foreach}]
    </div>
[{/block}]