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

    // photoswipe
    
    $(document).on("click", "#zoom1", function (e) {
        e.preventDefault();
        var iIndex = 0;

        if ($oMorePicsSlider.length) {
            iIndex = $oMorePicsSlider.find('a.selected').data('num') - 1;
        }

        pswp.open(iIndex, this);
    });

});
Flow.initDetailsEvents = function () {
    var $oDetailsWrapper = $('#details'),
        $oReviewRating = $('#reviewRating'),
        $oMorePicsSlider = $('#morePicsContainer'),
        pswp = this.setPhotoSwipe();





    if ($oMorePicsSlider.length) {
        $oMorePicsSlider.find('a').click(function (e) {
                e.preventDefault();
                var $this = $(this);
                $('#zoom1').attr('href', $this.data('zoom-url')).find('img').attr('src', this.href);
                $oMorePicsSlider.find('a.selected').removeClass('selected');
                $this.addClass('selected');
            }
        );

        if ($oMorePicsSlider.hasClass('flexslider')) {
            $oMorePicsSlider.flexslider(
                {
                    animation: "slide",
                    itemWidth: 150,
                    minItems: 5,
                    maxItems: 5
                }
            );
        }
    }
};

Flow.setPhotoSwipe = function () {
    var obj = {},
        $oMorePicsContainer = $('#morePicsContainer');
    obj.pswp = $('.pswp')[0];
    obj.items = [];

    if ($oMorePicsContainer.length) {
        $oMorePicsContainer.find('a').each(function () {
                var $this = $(this);

                obj.items.push(
                    {
                        src: $this.data('zoom-url'),
                        w: $this.data('width'),
                        h: $this.data('height')
                    }
                );
            }
        );
    }
    else {
        var $oZoom = $('#zoom1');
        obj.items.push(
            {
                src: $oZoom.attr('href'),
                w: $oZoom.data('width'),
                h: $oZoom.data('height')
            }
        );
    }

    obj.open = function (index, elm) {
        if (typeof index === 'undefined') {
            index = 0;
        }

        // define options (if needed)
        var options = {
            index: index, // start at first slide
            getThumbBoundsFn: function (index) {
                //var thumbnail = $( '.dd-zoom-toggle[data-index=' + index + ']' )[ 0 ];

                var pageYScroll = window.pageYOffset || document.documentElement.scrollTop;
                var rect = elm.getBoundingClientRect();

                return {x: rect.left, y: rect.top + pageYScroll, w: rect.height};
            },

            mainClass: 'pswp--minimal--dark',
            barsSize: {top: 0, bottom: 0},
            captionEl: false,
            fullscreenEl: false,
            shareEl: false,
            bgOpacity: 0.85,
            tapToClose: true,
            tapToToggleControls: false
        };

        // Initializes and opens PhotoSwipe
        var gallery = new PhotoSwipe(this.pswp, PhotoSwipeUI_Default, this.items, options);
        gallery.init();
    };

    return obj;
};

function getAjaxLoader() {
    var oLayerElem = document.createElement('div'),
        oSpinnerElem = document.createElement('div'),
        oBubbleElem1 = document.createElement('span'),
        oBubbleElem2 = document.createElement('span'),
        oBubbleElem3 = document.createElement('span');

    oLayerElem.className = 'ajax-loader';
    oSpinnerElem.className = 'ajax-loader-spinner';
    oBubbleElem1.className = 'bubble1';
    oBubbleElem2.className = 'bubble2';
    oBubbleElem3.className = 'bubble3';

    oSpinnerElem.appendChild(oBubbleElem1);
    oSpinnerElem.appendChild(oBubbleElem2);
    oSpinnerElem.appendChild(oBubbleElem3);

    oLayerElem.appendChild(oSpinnerElem);

    return oLayerElem;
}

$(document).ready(function () {

        if (window.isMobileDevice()) {
            var $oBody = $('body'),
                $oSwipeOverlay = $('#swipe-overlay'),
                carousel = new Carousel('#swipe-overlay');

            $oSwipeOverlay.appendTo($oBody);

            carousel.init();

            $('#zoom1, #morePicsContainer a').on('click touch', function (e) {
                    e.preventDefault();
                    $oSwipeOverlay.addClass('open');

                    // Lazy Loading
                    $oSwipeOverlay.find('img').each(function () {
                            var $this = $(this),
                                sSrc = $this.data('src');

                            if (sSrc) {
                                $this.attr('src', sSrc);
                            }
                        }
                    );
                }
            );

            $oSwipeOverlay.find('.close-btn').on('click touch', function () {
                    $oSwipeOverlay.removeClass('open');
                }
            );
        }
    }
);