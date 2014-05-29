$('#folder-list-box ul li a[data-fid=<%= @folder.id %>]')
  .parent()
  .remove()
$('#upload-list-box').perfectScrollbar('update')
