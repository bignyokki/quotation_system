$(document).on('turbolinks:load', function() {

  $('input').on('focusin', function() {
    $(this).parent().find('.field__label').addClass('active');
  });
  
  $('input').on('focusout', function() {
    if (!this.value) {
      $(this).parent().find('.field__label').removeClass('active');
    }
  });

});