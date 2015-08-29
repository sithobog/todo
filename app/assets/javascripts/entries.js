var ready, refresh_text, reset_add_form, toggle_add, clear_body, get_current_text;
var current_text, new_text, new_body, current_url;

refresh_text = function(){
  $('pre').text(new_body);
  $('#entry_body').val(new_body);
}

reset_add_form = function(){
  $('.new_text').val("");
}

is_body_clear = function(){
  if ($('pre').text() == ""){
    $('pre, .change').hide();
  }else{
    $('pre, .change').show();
  }
}

get_current_text = function(){
  if ($('pre').text() == ""){
    current_text = $('pre').text();
  } else{
    current_text = $('pre').text()+"\n";
  }
}

//accepts css class of button and body which will be toggle
my_toggle = function(button, body){
  $('.'+button).on('click',function(){
    $('.'+body).slideToggle();
  });
}

ready = function(){

  $('.update_body').on('click',function(){
  	current_url = window.location.href;
    get_current_text();
    new_text = $('.new_text').val();
    new_body = current_text+new_text;
    $.ajax({
      type: "PUT",
      url: current_url+'/add',
      data: { body: new_body },
      success: function(){
        refresh_text();
        reset_add_form();
        is_body_clear();
        $('.add_text').slideToggle();
      }
    });
  });
  my_toggle('add','add_text');
  my_toggle('change','change_body');
  is_body_clear();
}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);
