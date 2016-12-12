[{capture append="oxidBlock_pageBody"}]
   [{if $oView->showRDFa()}]
      [{include file="rdfa/rdfa.tpl"}]
   [{/if}]

   [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
   [{assign var="sActiveClass" value=$oView->getClassName() }]
   [{assign var="aSidebarConfig" value=$oViewConf->getViewThemeParam('aSidebarConfig')}]
   [{if $oViewConf->getViewThemeParam('blKeepDefaultSidebar') }]
      [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass|default:$sidebar }]
   [{else}]
      [{assign var="sidebar" value=$aSidebarConfig.$sActiveClass }]
   [{/if}]

   <div id="wrapper">

      <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">

         <div class="content-box">

            [{if $oView->getClassName() != "start" && !$blHideBreadcrumb}]
               [{block name="layout_breadcrumb"}]
                  [{include file="widget/breadcrumb.tpl"}]
               [{/block}]
            [{/if}]

            [{$smarty.capture.loginErrors}]

            <div class="row">
               [{if $sidebar && $sidebar|strtolower == "left"}]
                  <div class="col-xs-12 col-md-3 [{$oView->getClassName()}]">
                     <div id="sidebar">
                        [{include file="layout/sidebar.tpl"}]
                     </div>
                  </div>
               [{/if}]

               <div class="col-xs-12 [{if $sidebar|strtolower == "left" || $sidebar|strtolower == "right"}]col-md-9[{/if}]">

                  <div id="content">
                     [{block name="content_main"}]
                        [{include file="message/errors.tpl"}]

                        [{foreach from=$oxidBlock_content item="_block"}]
                           [{$_block}]
                        [{/foreach}]
                     [{/block}]
                  </div>

               </div>

               [{if $sidebar && $sidebar|strtolower == "right"}]
                  <div class="col-xs-12 col-md-3 [{$oView->getClassName()}]">
                     <div id="sidebar">
                        [{include file="layout/sidebar.tpl"}]
                     </div>
                  </div>
               [{/if}]
            </div>

         </div>

      </div>

   </div>

   [{include file="widget/facebook/init.tpl"}]
   <i class="fa fa-chevron-circle-up icon-4x" id="jumptotop"></i>
[{/capture}]
[{include file="layout/base.tpl"}]