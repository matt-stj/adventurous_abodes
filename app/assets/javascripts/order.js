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
            else if($(this).attr("value")=="Treehouse"){
                $(".rentals").not(".treehouse").hide();
                $(".treehouse").show();
            }
            else if($(this).attr("value")=="Penthouse"){
                $(".rentals").not(".penthouse").hide();
                $(".penthouse").show();
            }
            else if($(this).attr("value")=="Spaceship"){
                $(".rentals").not(".spaceship").hide();
                $(".spaceship").show();
            }
            else if($(this).attr("value")=="Submarine"){
                $(".rentals").not(".submarine").hide();
                $(".submarine").show();
            }
            else if($(this).attr("value")=="Mansion"){
                $(".rentals").not(".mansion").hide();
                $(".mansion").show();
            }
            else if($(this).attr("value")=="Capsule"){
                $(".rentals").not(".capsule").hide();
                $(".capsule").show();
            }
            else if($(this).attr("value")=="Igloo"){
                $(".rentals").not(".igloo").hide();
                $(".igloo").show();
            }
            else if($(this).attr("value")=="Attic"){
                $(".rentals").not(".attic").hide();
                $(".attic").show();
            }
            else if($(this).attr("value")=="Storage Container"){
                $(".rentals").not(".storageContainer").hide();
                $(".storageContainer").show();
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
