[{if $ppApprovalUrl && ($oView->isPPThirdParty($sPaymentID) || $sPaymentID == $paypalid) }]
   [{if $sPaymentID == $paypalid }]
      <div id="ppplus"></div>
      <script type="text/javascript">
          if(typeof PAYPAL == 'undefined') {
              document.write('<script type="text/javascript" src="https://www.paypalobjects.com/webstatic/ppplus/ppplus.min.js"></'+'script>');
          }
      </script>
      <script type="application/javascript">
          var ppFrameLoaded = false;
          var ppp = PAYPAL.apps.PPP({
              approvalUrl: "[{$ppApprovalUrl}]",
              placeholder: "ppplus",
              country: "[{$oxcmp_user->aspaypal_getCountryCode()}]",
              language: [{if $oView->getActiveLangAbbr() == "de"}]"de_DE"[{else}]"en_US"[{/if}],
             [{if $ppsandbox}]
              mode: "sandbox",
             [{/if}]
              surcharging: [{if $ppsurcharging}]true[{else}]false[{/if}],
              buttonLocation: "inside",
              showPuiOnSandbox: true,
              showLoadingIndicator: true,
             [{if $oView->getCheckedPaymentId() == $paypalid || $oView->isPPThirdParty($oView->getCheckedPaymentId())}]
              preselection: "paypal",
             [{else}]
              preselection: "none",
             [{/if}]
              thirdPartyPaymentMethods: [
                 [{foreach from=$ppthirdparty item=payment name=thirdpayments}]
                  {
                      'redirectUrl': '[{$oViewConf->getSslSelfLink()|replace:"&amp;":"&"}]cl=payment&pppayid=[{$payment->oxpayments__oxid->value}]',
                      'methodName': '[{$payment->oxpayments__oxdesc->value}]',
                     [{if $payment->oxpayments__pppluslogo->value}]
                      'imageUrl': '[{$payment->oxpayments__pppluslogo->value}]',
                     [{/if}]
                      'description': '[{$payment->oxpayments__oxlongdesc->rawValue|strip_tags|replace:"'":""|trim|replace:"\r":" "|replace:"\n":" "}]'
                  }
                 [{if !$smarty.foreach.thirdpayments.last}],[{/if}]
                 [{/foreach}]
              ],
              onLoad: function () {
                  ppFrameLoaded = true;
              },
              disableContinue: function () {

              },
              enableContinue: function () {
                  $('input[name=paymentid]:checked').prop('checked',false);
                  $('#payWithAmazonDiv').hide();
              }
          });

          function disableCheckoutButtons(form) {
              $('[type="submit"]', form).each(function () {
                  var button = $(this);
                  button.attr('disabled', 'disabled');
                  button.css('opacity', 0.3);
                  button.css('filter', 'alpha(opacity=30)');
              });
              $('body').css('opacity', 0.3);
              $('body').css('filter', 'alpha(opacity=30)');
          }

          function enableCheckoutButtons(form) {
              $('[type="submit"]', form).each(function () {
                  var button = $(this);
                  button.removeProp('disabled');
                  button.css('opacity', 1);
                  button.css('filter', 'alpha(opacity=100)');
              });
              $('body').css('opacity', 1);
              $('body').css('filter', 'alpha(opacity=100)');
          }

          var ppthirdparty = [];
          [{foreach from=$ppthirdparty item=payment name=thirdpayments}]
          ppthirdparty['[{$payment->oxpayments__oxdesc}]'] = 1;
          [{/foreach}]

          function ppCheckout(form) {
              if ($('input[name=paymentid]:checked').length == 0) {
                  if (ppthirdparty[PAYPAL.apps.PPP.getPaymentMethod()] === 1) {
                      PAYPAL.apps.PPP.doCheckout();
                      return false;
                  }
                  var that_form = form;
                  disableCheckoutButtons(that_form);

                  $.ajax({
                      url: '[{$oViewConf->getPaymentLink()|oxaddparams:"fnc=patchpppaypal"|replace:"&amp;":"&"}]',
                      data: {},
                      type: 'GET'
                  }).done(function (result) {
                      enableCheckoutButtons(that_form);
                      if (result !== null && result.trim() === "1")
                          PAYPAL.apps.PPP.doCheckout();
                      else
                          document.location.href = '[{$oViewConf->getPaymentLink()|oxaddparams:"payerror=999"|replace:"&amp;":"&"}]';
                  }).fail(function () {
                      enableCheckoutButtons(that_form);
                      document.location.href = '[{$oViewConf->getPaymentLink()|oxaddparams:"payerror=999"|replace:"&amp;":"&"}]';
                  });
                  return false;
              }
              return true;
          }

          //hack for heidelpay modul
          function ppSubmitActiveForm() {
              var oActForm = $('input[type=radio]:checked').closest('form.payment');//document.getElementById("payment" + sActFormID);

              if (ppCheckout(oActForm))
                  oActForm[0].submit();
          }

      </script>
      [{capture assign=pageScript}]
         $('input[type="radio"][name="paymentid"]').change(function() {
         ppp.deselectPaymentMethod();
         });
         $('form[name="order"]').submit(function(event) {
         if (!ppCheckout($(this)))
         event.preventDefault();
         });
         if ($('#paymentNextStepBottom').length > 0 && $('#paymentNextStepBottom')[0].attributes.onclick && ($('#paymentNextStepBottom')[0].attributes.onclick.nodeValue == 'submitActiveForm();return false' || $('#paymentNextStepBottom')[0].attributes.onclick.nodeValue == 'JavaScript:submitActiveForm();return false' || $('#paymentNextStepBottom')[0].attributes.onclick.nodeValue == 'javascript:submitActiveForm();return false;'))
         $('#paymentNextStepBottom')[0].attributes.onclick.nodeValue = 'ppSubmitActiveForm();return false';
         setTimeout(function() {
         if (!ppFrameLoaded)
         document.location.href = '[{$oViewConf->getPaymentLink()|oxaddparams:"fnc=disableppplus"|replace:"&amp;":"&"}]';
         },15000);
      [{/capture}]
      [{oxscript add=$pageScript}]
   [{/if}]
[{else}]
   [{$smarty.block.parent}]
[{/if}]