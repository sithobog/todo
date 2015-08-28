function ready(){
$('.not-month a').remove();
}
$(document).ready(ready);
/**
 * if using turbolinks
 */
$(document).on('page:load', ready);