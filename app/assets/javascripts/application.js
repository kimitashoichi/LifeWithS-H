// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require_tree ../../../vendor/assets/javascripts/.
//= require_tree .
$(function () {

	$(document).on("click", '.add-image-buton', function(){
	   var form = $('#add-image').html();
	   $('.add-image-form').append('<div class="add-image-form2"></div>')
	   $('.add-image-form2:last').append(form);
	});
	$(document).on("click", '.delete-image-buton', function(){
	   $('.add-image-form2').eq(-1).remove();
	});

  $('.container').fadeIn(600);

	$('#tab-contents .tab[id != "tab1"]').hide();
	$('#tab-menu a').on('click', function(){
	   $("#tab-contents .tab").hide();
	   $("#tab-menu .active").removeClass("active");
	   $(this).addClass("active");
	   $($(this).attr("href")).fadeIn(600);
	   return false;
	});

  $("#theTarget").skippr({
    transition : 'fade',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : false,
    autoPlayDuration : 5000,
    keyboardOnAlways : true,
    hidePrevious : false
  });

  $(document).on('click', '.sign_button', function() {
    $('.sign_modal_wrapper').fadeIn(300);
    $('.sign_modal').fadeIn(300);
    if ($(this).hasClass('sign_up_button')) {
      $('.sign_up_modal').fadeIn(300);
    } else {
      $('.sign_in_modal').fadeIn(300);
    }
  });

  $(document).on('click', '.sign_modal_wrapper, .fa_wrapper', function() {
    $('.sign_modal_wrapper').fadeOut(300);
    $('.sign_modal').fadeOut(300);
    $('.sign_modal_content').fadeOut(300);
  });

});


