$(document).on('turbolinks:load', function() {

  $('input, textarea').on('focusin', function() {
    $(this).parent().find('.field__label').addClass('active');
  });
  
  $('input, textarea').on('focusout', function() {
    if (!this.value) {
      $(this).parent().find('.field__label').removeClass('active');
    }
  });

});