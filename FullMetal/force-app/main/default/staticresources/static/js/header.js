$(function(){

// Dock Header 
$ = jQuery.noConflict();
    
        var didScroll;
        var lastScrollTop = 0;
        var delta = 5;
        var navbarHeight = $('header').outerHeight();
        var isPreviousClicked = false;
        
        $(window).scroll(function(event){ scrollHandler(); });

        function scrollHandler()
        {
            if(typeof isPreviousClicked != 'undefined')
            {
                if(isPreviousClicked)
                {
                    if($('header').attr('class') == "nav-down")
                    {
                        $('header').removeClass('nav-down').addClass('nav-up');
                        $("#secondary-header").css({"position":"fixed","top":"-70px","width":"100%","z-index":"990"});
                    }
                    
                    $(window).off('scroll');
                    setTimeout(function()
                    {
                        lastScrollTop = $(this).scrollTop();
                        $(window).scroll(function(event){ scrollHandler(); });
                    }, 2000);
                }
                else
                {
                    didScroll = true;
                }
            }
            else
            {
                didScroll = true;
            }
        }
        setInterval(function() {
            
            if (typeof isPreviousClicked == 'undefined')
            {
                if (didScroll ) 
                {
                    hasScrolled();
                    didScroll = false;
                }
            }
            else
            {
                if (didScroll && !isPreviousClicked)
                {
                    hasScrolled();
                    didScroll = false;
                }
            }

        }, 250);
        function hasScrolled() {
            var st = $(this).scrollTop();
            // Make sure they scroll more than delta
           if(Math.abs(lastScrollTop - st) <= delta)
                return;
            // If they scrolled down and are past the navbar, add class .nav-up.
            // This is necessary so you never see what is "behind" the navbar.
            if (st > lastScrollTop && st > navbarHeight){
                // Scroll Down
                $('header').removeClass('nav-down').addClass('nav-up');


                //----
                
                //for the pop-up in loss summary page
               $(".tab #secondary-header, .desktop #secondary-header").css({"position":"fixed","top":"-50px","width":"100%","z-index":"990"});
               $(".phone #secondary-header").css({"position":"fixed","top":"-120px","width":"100%","z-index":"990"});
                                                                
            } else {
                // Scroll Up
                if(st + $(window).height() <= $(document).height()) {
                    $('header').removeClass('nav-up').addClass('nav-down');

                    //loss-summary page
                      $("#secondary-header").css({"position":"fixed","top":"150px","width":"100%","z-index":"990"});
                    $("#next-step").css({"margin-top":"175px"});
                    if($(window).scrollTop() >=50) {
                        $("#secondary-header").css({"position":"fixed","top":"50px","width":"100%","z-index":"990"});
                    }
                }
            }
            lastScrollTop = st;
        }
                                
$(document).ready(function()
{
     $("html,body").animate({scrollTop: 0}, 1000);
});

/*
window.onbeforeunload = function(){
    window.scrollTo(0,0);
}
*/



});
