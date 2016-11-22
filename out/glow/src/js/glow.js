$( function () {

    // allgemeines Zeug
    $( "img" ).unveil();
    $( '.hasTooltip' ).tooltip({container: 'body'});
    $( '.hasPopover' ).popover();

    // navs menüs etc
    $('[data-toggle="offcanvas"]').click(function () {
        $('.row-offcanvas').toggleClass('active');
    });
    
    // Variantenauswahl

    

});