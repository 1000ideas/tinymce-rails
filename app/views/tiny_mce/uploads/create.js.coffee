<% if @upload.errors.any? %>
  window.tinymceUploadPlugin.alert("<%=j @upload.errors.full_messages.join(', ') %>")
<% else %>
  $("<%=j render(@upload) %>").appendTo('#upload-list-box ul')
  if $('#upload-list-box ul li.empty').length > 0
    $('#upload-list-box ul li.empty').remove()
  window.tinymceUploadPlugin.sort()
<% end %>