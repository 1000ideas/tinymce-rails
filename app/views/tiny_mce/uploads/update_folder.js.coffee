$("<%=j render('breadcrumbs', folder: @current) %>").replaceAll('ul.breadcrumbs')

$('#folder-list-box ul').html('<%=j render(@folders, current: @current) %>')

$('#folder-list-box ul li a.name')
  .droppable window.tinymceUploadPlugin._droppable_options()

$('#upload-list-box').perfectScrollbar('update')
