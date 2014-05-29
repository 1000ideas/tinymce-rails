$('#upload-list-box ul li[data-uid=<%= @upload.id %>] p.name').text('<%= @upload.title %>')
$('#upload-list-box').perfectScrollbar('update')
