$(function () {
    var $b = $("body");

    $b.on("change", "#blshowshipaddress", function () {
            if (this.checked) $("#shippingAddress").fadeOut('fast');
            else $("#shippingAddress").fadeIn('slow');
        });
    
    // Schritt 2 ----------------------------------------------------------------- Schritt 2
    $b.on("change","input[name='oxaddressid']",function() {
        var selectValue = $(this).val();

        // was ist das für ein Quatsch? Nirgends wird geprüft ob realoadaddress == 1 oder 2 ist
        if ($("input[name=reloadaddress]")) $("input[name=reloadaddress]").val((selectValue === '-1' ? 1 : 2)); 
        
        if (selectValue !== '-1') // andere ausgewählte Adresse lasen
        {
            var address = aShipAddr[selectValue];
            for(var field in address)
            {
                if(address.hasOwnProperty(field)) {
                    $("input[type='text'][id='deladr_"+field+"']").val(address[field]); // text fields
                    $("input[id^='deladr_"+field+"'][value='"+address[field]+"'").prop("checked", true); // radio + options
                    $("select[id^='deladr_"+field+"'] option[value='"+address[field]+"'").prop("selected", true); // radio + options
                }
            }
            //$("form[name='order']").unbind('submit');
            //$('#shippingAddressForm').remove();
            //$("form[name='order'] input[name=cl]").val($("input[name=changeClass]").val());
            //$("form[name='order'] input[name=fnc]").val("");
            //$("form[name='order']").submit();
        } 
        else // neue Adresse eingeben
        {
            $("input[type='text'][id^='deladr']").val(""); // textfelder
            $("input[id^='deladr']:checked").prop("checked", null); // radio
            $("select[id^='deladr'] option:selected").prop("selected", null); // option
            $('#shippingAddressForm').show();
        }
    });

    // Schritt 3 ----------------------------------------------------------------- Schritt 3
    $b.on("change", "input[name='sShipSet']", function () {
        $(this).parent("form").submit();
    });

    $(".validate").bootstrapValidator({
        framework: 'bootstrap',
        feedbackIcons: {
            valid: 'fa fa-check',
            invalid: 'fa fa-times',
            validating: 'fa fa-spinner fa-pulse'
        },
        fields: {

            password: {
                validators: {
                    notEmpty: {
                        message: 'The password is required and can\'t be empty'
                    },
                    identical: {
                        field: 'confirmPassword',
                        message: 'The password and its confirm are not the same'
                    }
                }
            },
            confirmPassword: {
                validators: {
                    notEmpty: {
                        message: 'The confirm password is required and can\'t be empty'
                    },
                    identical: {
                        field: 'password',
                        message: 'The password and its confirm are not the same'
                    }
                }
            }
        }
    });
});