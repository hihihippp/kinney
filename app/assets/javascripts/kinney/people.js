var myTextExtraction = function(node)
{
  if ($(node).find('span').length > 0 ) {
    return $(node).find('span')[0].innerHTML;
  } else {
    return $(node).text();
    
  }
}

$(document).ready(function() {
  // sort the table of profiles with no video
  $('table.tablesorter').tablesorter({
    textExtraction: myTextExtraction,
    sortList: [[0,0]]
  });
  
  // sort the profiles that have video
  // first add the controls to the page
  $('#insert_controls').append('Sort by: <a href="#" class="btn disabled" id="sort_last_name">Last Name</a><a href="#" class="btn" id="sort_graduating_class">Graduating Class</a>');
  
  $('#sort_graduating_class').click(function(){
    $('.sortable_thumbs li.sortable_thumb').sortElements(function(a, b){
      // FIXME: certainly there is a better way to sort empty values
      return ($(a).find('.grad_class').text() || "zzz") > ($(b).find('.grad_class').text() || "zzz") ? 1 : -1;
    });
    $('#sort_graduating_class').addClass('disabled');
    $('#sort_last_name').removeClass('disabled');
  });
  $('#sort_last_name').click(function(){
    $('.sortable_thumbs li.sortable_thumb').sortElements(function(a, b){
      return $(a).find('.last_name').text() > $(b).find('.last_name').text() ? 1 : -1;
    });
    $('#sort_graduating_class').removeClass('disabled');
    $('#sort_last_name').addClass('disabled');
  });
  
});