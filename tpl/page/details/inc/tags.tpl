[{assign var="oDetailsProduct" value=$oView->getProduct()}]
[{if $oView->showTags() && ( $oView->getTagCloudManager() || ( $oxcmp_user && $oDetailsProduct ) )}]

    <p class="tagCloud">
        [{assign var="oCloudManager" value=$oView->getTagCloudManager()}]
        [{if $oCloudManager->getCloudArray()|count < 0}]
            [{oxmultilang ident="NO_TAGS"}]
        [{/if}]
        [{foreach from=$oCloudManager->getCloudArray() item="oTag" name="detailsTags"}]
            <a class="tagitem_[{$oCloudManager->getTagSize($oTag->getTitle())}]" href="[{$oTag->getLink()}]">[{$oTag->getTitle()}]</a>[{if !$smarty.foreach.detailsTags.last}], [{/if}]
        [{/foreach}]
    </p>

[{/if}]