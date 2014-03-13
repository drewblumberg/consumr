// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  var $window = $(window);
  var $heroButton = $('.hero_button');

  $('#search_results').on('click', '.medium img', fillInFormData);

  if($window.width() < 600) {
    return $heroButton.removeClass('large').addClass('tiny');
  }
});

function fillInFormData(e){
  var $this = $(this);
  var $list_item = $this.parent();
  var image_url = $this.attr('src');
  var title = $list_item.children('ul').children('li.medium_title').text();
  var creator = $.trim($list_item.children('ul').children('li.medium_creator').text());
  var category = $('#search_category').val();
  var categories = ['Movie', 'TV Show', 'Book'];

  $('#medium_title').val(title);
  $('#medium_creator').val(creator);
  $('#medium_image_url').val(image_url);
  $('#medium_category').val(categories[parseInt(category)-1]);
}


$(function(){ $(document).foundation(); });
