var ready, set_positions, is_list_completed;
var current_url;

set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.well.task_body').each(function(i){
    $(this).attr("data-pos",i+1);
  });
}

is_list_completed = function(){
  if ($('.well.task_body').length != 0 && $('.well.task_body').length == $('.well.task_body.completed').length){
    $('.sortable').addClass('completed_list');
  }
}

ready = function(){

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
    $('.well.task_body').each(function(i){
      updated_order.push({ id: $(this).data("id"), position: i+1 });
    });

    // send the updated order via ajax
    $.ajax({
      type: "PUT",
      url: current_url+'/tasks/sort',
      data: { order: updated_order }
    });
  });

  $('.complete_task').on('click',function(){
    var id = $(this).closest('.task_body').data('id');
    $(this).hide();
    $(this).closest('.task_body').addClass('completed');
    is_list_completed();
    $.ajax({
      type: "PUT",
      url: current_url+'/tasks/'+id+'/complete'
    });
  });

}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);

$(document).bind('ajaxSuccess', ready);
$(document).ajaxSuccess(function(){
    $('#new_task')[0].reset();
});