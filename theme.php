<?php
$aDetailImageSizes = [];
for ($x = 0; $x < 12; $x++) {
    $aDetailImageSizes['oxpic' . $x + 1] = '800*800';
}

$aTheme = [
    'id'             => 'glow',
    'title'          => 'Glow',
    'description'    => 'cleaned, updated and bugfixed flow theme for oxid eshop 4.9 / 4.10',
    'thumbnail'      => 'theme.jpg',
    'version'        => '0.1.1',
    'parentTheme'    => 'flow',
    'parentVersions' => ['1.0.0', '1.0.0-beta.3'],
    'author'         => 'Marat Bedoev',
    'settings'       => [
        [
            'group'    => 'glow_layout',
            'name'     => 'blFullWidthHeader',
            'type'     => 'bool',
            'value'    => false,
            'position' => 0
        ], [
            'group'    => 'glow_layout',
            'name'     => 'blFullWidthFooter',
            'type'     => 'bool',
            'value'    => false,
            'position' => 1
        ], [
            'group'    => 'glow_layout',
            'name'     => 'blKeepDefaultSidebar',
            'type'     => 'bool',
            'value'    => true,
            'position' => 2
        ], [
            'group'    => 'glow_layout',
            'name'     => 'aSidebarConfig',
            'type'     => 'aarr',
            'value'    => ['content' => 'left', 'register' => 'x'],
            'position' => 3
        ], [
            'group'    => 'glow_layout',
            'name'     => 'blFooterCattree',
            'type'     => 'bool',
            'value'    => false,
            'position' => 4
        ], [
            'group'    => 'glow_layout',
            'name'     => 'blFooterManufacturer',
            'type'     => 'bool',
            'value'    => false,
            'position' => 5
        ], [
            'group'    => 'glow_functions',
            'name'     => 'blShowNoticelist',
            'type'     => 'bool',
            'value'    => false,
            'position' => 0
        ], [
            'group'    => 'glow_functions',
            'name'     => 'blShowNewsletter',
            'type'     => 'bool',
            'value'    => false,
            'position' => 1
        ], [
            'group'    => 'glow_functions',
            'name'     => 'blShowReviews',
            'type'     => 'bool',
            'value'    => false,
            'position' => 1
        ], [
            'group'    => 'glow_functions',
            'name'     => 'blShowOrderRemark',
            'type'     => 'bool',
            'value'    => true,
            'position' => 2
        ], [
            'group'    => 'glow_account',
            'name'     => 'blShowOrderState',
            'type'     => 'bool',
            'value'    => false,
            'position' => 0
        ], [
            'group'    => 'glow_account',
            'name'     => 'blAllowEmailChange',
            'type'     => 'bool',
            'value'    => true,
            'position' => 1
        ], [
            'group'    => 'glow_start',
            'name'     => 'blStartPageSliderAutoplay',
            'type'     => 'bool',
            'value'    => true,
            'position' => 0
        ], [
            'group'    => 'glow_start',
            'name'     => 'sStartPageSliderAutoplaySpeed',
            'type'     => 'str',
            'value'    => '5000',
            'position' => 1
        ], [
            'group'    => 'glow_start',
            'name'     => 'sStartPageSliderAnimationSpeed',
            'type'     => 'str',
            'value'    => '2000',
            'position' => 2
        ], [
            'group'       => 'glow_start',
            'name'        => 'sStartPageSliderAnimation',
            'type'        => 'select',
            'value'       => 'slide',
            'constraints' => 'slide|fade',
            'position'    => 3
        ], [
            'group'       => 'glow_start',
            'name'        => 'sStartPageSliderDirection',
            'type'        => 'select',
            'value'       => 'horizontal',
            'constraints' => 'horizontal|vertical',
            'position'    => 4
        ], [
            'group'    => 'glow_start',
            'name'     => 'blStartPageSliderArrows',
            'type'     => 'bool',
            'value'    => true,
            'position' => 7
        ], [
            'group'       => 'glow_start',
            'name'        => 'blStartPageSliderDots',
            'type'        => 'bool',
            'value'       => true,
            'position'    => 8
        ], [
            'group'       => 'glow_start',
            'name'        => 'sStartPageSliderEasing',
            'type'        => 'select',
            'value'       => 'swing',
            'constraints' => 'swing|linear',
            'position'    => 4
        ], [
            'group'       => 'glow_start',
            'name'        => 'sStartPageSliderNav',
            'type'        => 'select',
            'value'       => '0',
            'constraints' => '0|1|2',
            'position'    => 7
        ], [
            'group'       => 'glow_start',
            'name'        => 'sStartPageActionsLayout',
            'type'        => 'select',
            'value'       => '2+2',
            'constraints' => '4+4|3+1|2+2|1+3',
            'position'    => 10
        ], [
            /*
            'group'       => 'glow_start',
            'name'        => 'sStartPagePromotionsLayout',
            'type'        => 'select',
            'value'       => '1',
            'constraints' => '0|1|2|3|4',
            'position'    => 11
        ], [
            */
            'group'       => 'glow_product',
            'name'        => 'sProductPageLayout',
            'type'        => 'select',
            'value'       => '50+50',
            'constraints' => '33+66|50+50|66+33',
            'position'    => 1
        ], [
            'group'    => 'glow_product',
            'name'     => 'blProductPageShow2BasketAmount',
            'type'     => 'bool',
            'value'    => false,
            'position' => 2
        ], [
            'group'    => 'glow_product',
            'name'     => 'aProductPageRadioVarselect',
            'type'     => 'arr',
            'value'    => [],
            'position' => 3
        ],


        /*[
           'group' => 'glow_recaptcha',
           'name' => 'sRecaptchaApiKey',
           'type' => 'str',
           'value' => '',
           'position' => 0
        ],[
           'group' => 'glow_recaptcha',
           'name' => 'sRecaptchaSecret',
           'type' => 'str',
           'value' => '',
           'position' => 1
        ]*/


    ]
];
