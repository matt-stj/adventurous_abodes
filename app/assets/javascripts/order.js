$(document).ready(function() {


  $('select').material_select();


  $("select").change(function(){
        $("select").find("option:selected").each(function(){
            if($(this).attr("value")=="Castle"){
                $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".castle").hide();
                $(".castle").show();
            }
            else if($(this).attr("value")=="Dungeon"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".dungeon").hide();
                $(".dungeon").show();
            }
            else if($(this).attr("value")=="Shack"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".shack").hide();
                $(".shack").show();
            }
            else if($(this).attr("value")=="Treehouse"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".treehouse").hide();
                $(".treehouse").show();
            }
            else if($(this).attr("value")=="Penthouse"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".penthouse").hide();
                $(".penthouse").show();
            }
            else if($(this).attr("value")=="Spaceship"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".spaceship").hide();
                $(".spaceship").show();
            }
            else if($(this).attr("value")=="Submarine"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".submarine").hide();
                $(".submarine").show();
            }
            else if($(this).attr("value")=="Mansion"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".mansion").hide();
                $(".mansion").show();
            }
            else if($(this).attr("value")=="Capsule"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".capsule").hide();
                $(".capsule").show();
            }
            else if($(this).attr("value")=="Igloo"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".igloo").hide();
                $(".igloo").show();
            }
            else if($(this).attr("value")=="Attic"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".attic").hide();
                $(".attic").show();
            }
            else if($(this).attr("value")=="Storage Container"){
              $(".displayed-rentals").removeClass("hidden");
                $(".rentals").not(".storage").hide();
                $(".storage").show();
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
