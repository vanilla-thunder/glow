$(function () {
    
    function selectVariant() {
        var $select = $(this),
            $option = $("option:selected", $select);

        var $aVarSelections = $("form.js-oxProductForm [id^='varselid_']");
        if ($option.hasClass("not-available")) {
            for (var i = 0; i < $aVarSelections.length; i++) {
                console.log($($aVarSelections[i]).attr("id"));
                //if($( aVarSelections[i] ).attr( "id" ) !== $select.attr("id") ) $("option:selected",$( aVarSelections[i] )).removeAttr("selected");
            }
            $("form.js-oxProductForm input[name=anid]").attr("value", $("form.js-oxProductForm input[name=parentid]").attr("value"));
        }

        // submit variant selection
        if ($select.parents('.js-fnSubmit').length > 0) {
            var data = {};
            $("form.js-oxWidgetReload").serializeArray().map(function (x) { data[x.name] = x.value; });
            $aVarSelections.serializeArray().map(function (x) { data[x.name] = x.value; });

            $.ajax({
                url: $("form.js-oxWidgetReload").attr("action"),
                data: data,
                success: function (data, textStatus, jqXHR) {
                    $("#details_container").html(data);
                    $("script", $("#details_container")).each(function () {
                        try {
                            if (this.src != '' && $('body > script[src="' + this.src + '"]').length == 0) {
                                $('body').append(this);
                                document.body.appendChild(this);
                                return true;
                            }
                            eval(this.innerHTML);
                        } catch (e) {
                            console.log(e);
                        }
                        $(this).remove();
                    });
                    return true;
                }
            });
        }
        return false;
    }
    $(document).on("change", "[id^='varselid_']", selectVariant);


});