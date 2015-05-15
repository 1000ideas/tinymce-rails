$("<%=j render('breadcrumbs', folder: @folder) %>").replaceAll('ul.breadcrumbs')

$('#folder-list-box ul').html('<%=j render(@folders, current: @folder) %>')

<% if @uploads.any? %>
$('#upload-list-box ul').html('<%=j render(@uploads) %>')
<% else %>
$('#upload-list-box ul').html('<%=j render("empty") %>')
<% end %>

$('#upload-list-box ul > li').addClass('ui-selectee')

$('#folder_parent_id').val('<%=j @folder.try(:id).try(:to_s) %>')

window.tinymceUploadPlugin._set_selectable()

$('#upload-list-box').perfectScrollbar('update')
