[{ assign var="shop"      value=$oEmailView->getShop() }]
[{ assign var="oViewConf" value=$oEmailView->getViewConfig() }]
[{ assign var="user"      value=$oEmailView->getUser() }]

[{include file="email/html/header.tpl" title="HAVE_YOU_FORGOTTEN_PASSWORD"|oxmultilangassign}]

<!--[if (gte mso 9)|(IE)]><table width="100%" align="center" cellpadding="0" cellspacing="0" border="0"><tr><td colspan="2"><![endif]-->

<div class="block" style="width:100%;display:inline-block;vertical-align:top;">
    <table width="100%">
        <tr>
            <td class="padding" align="left" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;">

                [{ oxcontent ident="oxupdatepassinfoemail" }]

            </td>
        </tr>
    </table>
</div><!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->

[{include file="email/html/footer.tpl"}]
