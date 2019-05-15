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
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .
//= require cocoon

$(function () {

	$(document).on("click", '.add-image-buton', function(){
	   var form = $('#add-image').html();
	   $('.add-image-form').append('<div class="add-image-form2"></div>')
	   $('.add-image-form2:last').append(form);
	});
	$(document).on("click", '.delete-image-buton', function(){
	   $('.add-image-form2').eq(-1).remove();
	});


	$('#tab-contents .tab[id != "tab1"]').hide();
	$('#tab-menu a').on('click', function(){
	   $("#tab-contents .tab").hide();
	   $("#tab-menu .active").removeClass("active");
	   $(this).addClass("active");
	   $($(this).attr("href")).fadeIn(600);
	   return false;
	});


});