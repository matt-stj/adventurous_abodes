$(document).ready(function() {


  $('select').material_select();


  $("select").change(function(){
        $("select").find("option:selected").each(function(){
            if($(this).attr("value")=="Castle"){
                $(".rentals").not(".castle").hide();
                $(".castle").show();
            }
            else if($(this).attr("value")=="Dungeon"){
                $(".rentals").not(".dungeon").hide();
                $(".dungeon").show();
            }
            else if($(this).attr("value")=="Shack"){
                $(".rentals").not(".shack").hide();
                $(".shack").show();
            }
            else{
                $(".rentals").hide();
            }
        });
    }).change();





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
