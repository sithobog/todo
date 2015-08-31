var ready, set_positions, is_list_completed, empty_list_text, reset_form, complete_task, sort_task;
var current_url;

set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.task_body').each(function(i){
    $(this).attr("data-pos",i+1);
  });
}

is_list_completed = function(){
  if ($('.task_body').length != 0 && $('.task_body').length == $('.task_body.completed').length){
    $('.sortable').addClass('completed_list');
  }else{
    $('.sortable').removeClass('completed_list');
  }
  empty_list_text();
}

empty_list_text = function(){
  if ($('.task_body').length != 0){
    $('.text_for_empty_list').hide();
  } else if ($('.task_body').length == 0) {
    $('.text_for_empty_list').show();
  }
}

reset_form = function(){
  if ($('#new_task').length != 0){
  $('#new_task')[0].reset();
  }
}

complete_task = function(){
    $('.complete_task').on('click',function(){
    var id = $(this).closest('.task_body').data('id');
    //$(this).css("background-image","url(check.png)");
    $(this).closest('.task_body').addClass('completed');
    $.ajax({
      type: "PUT",
      url: current_url+'/tasks/'+id+'/complete',
      success: function(){
        sort_task();  
      }
    });
  });
}

sort_task = function(){
  // call set_positions function
  set_positions();
  current_url = window.location.href

  $('.sortable').sortable();

  // after the order changes
  $('.sortable').sortable().bind('sortupdate', function(e, ui) {
    // array to store new order
    updated_order = []
    // set the updated positions
    set_positions();
    // populate the updated_order array with the new task positions
    $('.task_body').each(function(i){
      updated_order.push({ id: $(this).data("id"), position: i+1 });
    });

    // send the updated order via ajax
    $.ajax({
      type: "PUT",
      url: current_url+'/tasks/sort',
      data: { order: updated_order }
    });
  });
}

ready = function(){

  sort_task();
  
  complete_task();
}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);

$(document).bind('ajaxSuccess', ready);
$(document).ajaxSuccess(function(){
  reset_form();
  is_list_completed();
});