$(document).ready(function() {

  // This allows touch devices to click on the dropdown menus
  // https://github.com/twitter/bootstrap/issues/4550#issuecomment-8525357
  $('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });
});