$('#upload-list-box ul li[data-uid=<%= @upload.id %>]').remove()

if $('#upload-list-box ul li').length == 0
  $('#upload-list-box ul').html('<%=j render("empty") %>')

$('#upload-list-box').perfectScrollbar('update')
