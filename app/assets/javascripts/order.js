$(document).ready(function() {

  $('.dropdown-button').on('click', 'button', function() {
    $(this).closest('#tour').find('.photos').slideToggle();
  });





  var $orders = $('.order');

  $('#order_filter_status').on('change', function () {
    var currentStatus = this.value;
    $orders.each(function (index, order) {
      $order = $(order);
      if ($order.data('status') === currentStatus) {
        $order.show();
      } else {
        $order.hide();
      }
    });
  });
});
