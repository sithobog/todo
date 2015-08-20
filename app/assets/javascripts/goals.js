var ready;

ready = function(){


  $('.finish_goal').on('click',function(){
    $('.conclusion').slideToggle();
  });
}

$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);