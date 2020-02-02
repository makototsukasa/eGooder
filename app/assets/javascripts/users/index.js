$(document).on('mouseenter', '.user-object', function() {
    var $item = $(this).find('.user-object-item');
    var $items = $('.user-object-item');
    var $icon = $(this).find('.user-object-icon');
    var $icons = $('.user-object-icon');
    var $objects = $('.user-object');

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

$(document).on('mouseleave', '.user-object', function() {
    var $items = $('.user-object-item');
    var $objects = $('.user-object');
    var $icons = $('.user-object-icon');

    $objects.removeClass('open');
    $items.slideUp({queue: false});
    $icons.animate({
        'width': '50%',
        'height': '50%'
    }, {
        queue: false});
});