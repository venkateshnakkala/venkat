//jQuery to collapse the navbar on scroll
j$ = jQuery.noConflict();

    j$(window).scroll(function() {
        if (j$(".navbar").offset().top > 50) {
            j$(".navbar-fixed-top").addClass("top-nav-collapse");
        } else {
            j$(".navbar-fixed-top").removeClass("top-nav-collapse");
        }
    });

    //jQuery for page scrolling feature - requires jQuery Easing plugin
    j$(function() {
        j$('a.page-scroll').bind('click', function(event) {
            var $anchor = $(this);
            j$('html, body').stop().animate({
                scrollTop: j$($anchor.attr('href')).offset().top
            }, 1500, 'easeInOutExpo');
            event.preventDefault();
        });
    });
/*
 $(window).scroll(function() {
        if ($(".navbar").offset().top > 50) {
            $(".navbar-fixed-top").addClass("top-nav-collapse");
        } else {
            $(".navbar-fixed-top").removeClass("top-nav-collapse");
        }
    });

    //jQuery for page scrolling feature - requires jQuery Easing plugin
    $(function() {
        $('a.page-scroll').bind('click', function(event) {
            var $anchor = $(this);
            $('html, body').stop().animate({
                scrollTop: $($anchor.attr('href')).offset().top
            }, 1500, 'easeInOutExpo');
            event.preventDefault();
        });
    });
*/