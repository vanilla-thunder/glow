<?php

$aTheme = [
    'id'           => 'glow',
    'title'        => 'Glow',
    'description'  => 'cleaned, updated and bugfixed flow theme for oxid eshop 4.9 / 4.10',
    'thumbnail'    => 'theme.jpg',
    'version'      => '0.1.0',
    'parentTheme'  => 'flow',
    'parentVersions'=> ['1.0.0','1.0.0-beta.3'],
    'author'       => 'Marat Bedoev',
    'settings' => [
       [
          'group' => 'glow_layout',
          'name' => 'blKeepDefaultSidebar',
          'type' => 'bool',
          'value' => true,
          'position' => 0
       ],[
          'group' => 'glow_layout',
          'name' => 'aSidebarConfig',
          'type' => 'aarr',
          'value' => ['content' => 'left','register' => 'x'],
          'position' => 1
       ],[
          'group' => 'glow_layout',
          'name' => 'blFooterCattree',
          'type' => 'bool',
          'value' => false,
          'position' => 2
       ],[
          'group' => 'glow_layout',
          'name' => 'blFooterManufacturer',
          'type' => 'bool',
          'value' => false,
          'position' => 3
       ],[
          'group' => 'glow_functions',
          'name' => 'blShowNoticelist',
          'type' => 'bool',
          'value' => false,
          'position' => 0
       ],[
          'group' => 'glow_functions',
          'name' => 'blShowReviews',
          'type' => 'bool',
          'value' => false,
          'position' => 1
       ],[
          'group' => 'glow_account',
          'name' => 'blShowOrderState',
          'type' => 'bool',
          'value' => false,
          'position' => 0
       ],[
          'group' => 'glow_account',
          'name' => 'blAllowEmailChange',
          'type' => 'bool',
          'value' => true,
          'position' => 1
       ]

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
