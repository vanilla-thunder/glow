<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=[{$oEmailView->getCharset()}]">
    <meta name="viewport" content="width=device-width"/>
    <title>[{$title|strip_tags}]</title>

    <style type="text/css">
        [{include file="../../../../out/glow/src/css/email.css"}]
    </style>
    <!--[if mso 12]>
    <style type="text/css">
        .flexibleContainer {
            display: block !important;
            width: 100% !important;
        }
    </style>
    <![endif]-->
    <!--[if mso 14]>
    <style type="text/css">
        .flexibleContainer {
            display: block !important;
            width: 100% !important;
        }
    </style>
    <![endif]-->
</head>
<body style="background-color:#ebebeb;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;text-align:center;">
<!--[if (gte mso 9)|(IE)]>
<table width="600" align="center" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td><![endif]-->
<table class="container" width="100%" cellpadding="0" cellspacing="0" style="max-width:600px;background-color:white;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;border-width:1px;border-style:solid;border-color:gray;margin-top:0;margin-bottom:0;margin-right:auto;margin-left:auto;">
    <tr>
        <td style="text-align:center;vertical-align:top;font-size:0;">
            [{* conditional table + erste Zeile *}]<!--[if (gte mso 9)|(IE)]>
            <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><![endif]-->

            <div class="block" style="width:300px;display:inline-block;vertical-align:top;">
                <table width="100%">
                    <tr>
                        <td align="left" class="padding" style="padding-top:16px;padding-bottom:16px;padding-right:16px;padding-left:16px;font-size:16px;line-height:1.25;" >
                            <b>[{$title}]</b>
                        </td>
                    </tr>
                </table>
            </div>
            <!--[if (gte mso 9)|(IE)]></td>
            <td><![endif]-->

            <div  class="block" style="width:300px;display:inline-block;vertical-align:top;" >
                <table width="100%">
                    <tr>
                        <td align="right" style="font-size:16px;line-height:1.25;" >
                            <a href="[{$oViewConf->getBaseDir()}]">
                                <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/mail_logo.jpg'}]" width="200" alt="[{ $shop->oxshops__oxname->value }]" style="max-width:250px;">
                            </a>
                        </td>
                    </tr>
                </table>
            </div>

            [{* /container erste Zeile *}]
            <!--[if (gte mso 9)|(IE)]></td></tr>
            <tr>
                <td colspan="2"><![endif]-->
            [{* container zweite Zeile *}]
            <div style="width: 600px;" class="">
                <a href="[{$oViewConf->getBaseDir()}]">
                    <img src="[{$oViewConf->getPictureDir()|cat:'wysiwigpro/mail_subheader.jpg'}]" width="600" alt="[{ $shop->oxshops__oxname->value }]">
                </a>
            </div>
            <!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->
<!-- /container zweite Zeile -->