// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require nprogress
//= require nprogress-turbolinks
//= require list
//= require tinysort.js
//= require best_in_place
//= require jquery.peity.js
//= require list.pagination
//= require select2
//= require_tree .

jQuery(document).on('best_in_place:success', function (event, request, error) {
  'use strict';
  if (request == '{"display_as":""}') { location.reload(); }
});

jQuery(document).on('best_in_place:error', function (event, request, error) {
  'use strict';
  jQuery.each(jQuery.parseJSON(request.responseText), function (index, value) {
    if (typeof value === "object") {value = index + " " + value.toString(); }
    alert(value);
    if (value.indexOf("has already graded") > -1) { location.reload(); }
  });
});
