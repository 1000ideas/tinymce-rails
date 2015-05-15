$("<%=j render('breadcrumbs', folder: @current) %>").replaceAll('ul.breadcrumbs')

$('#folder-list-box ul').html('<%=j render(@folders, current: @current) %>')

$('#upload-list-box').perfectScrollbar('update')
