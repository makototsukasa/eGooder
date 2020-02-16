$(function() {
    $('.flash').delay(1500).slideUp();
});

$(document).on('mouseenter', '.user-item', function() {
    var $item = $(this).find('.user-item-message');
    var $items = $('.user-item-message');
    var $icon = $(this).find('.user-item-icon');
    var $icons = $('.user-item-icon');
    var $objects = $('.user-item');

    $objects.removeClass('open');
    $items.slideUp({queue: false});
    $icons.css({
        'width': '50%',
        'height': '50%'
    }, {
        queue: false
    });
    $(this).addClass('open');
    $icon.animate({
        'width': '100%',
        'height': '100%'
    }, {
        queue: false
    });
    $item.slideDown({queue: false});
});

$(document).on('mouseleave', '.user-item', function() {
    var $items = $('.user-item-message');
    var $objects = $('.user-item');
    var $icons = $('.user-item-icon');

    $objects.removeClass('open');
    $items.slideUp({queue: false});
    $icons.animate({
        'width': '50%',
        'height': '50%'
    }, {
        queue: false});
});