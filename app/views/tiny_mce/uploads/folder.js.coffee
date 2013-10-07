<% if @folder.errors.any? %>
window.tinymceUploadPlugin.alert("<%=j @folder.errors.full_messages.join(', ') %>")
<% else %>
<% if @current %>
if $('#folder-list-box li[data-fid=<%= @current.id %>] ul').length == 0
  $('#folder-list-box li[data-fid=<%= @current.id %>]').append('<ul>')
$("<%=j render(@folder, current: nil) %>").appendTo('#folder-list-box li[data-fid=<%= @current.id %>] ul')
$('#folder-list-box li[data-fid=<%= @current.id %>] ul > li').tsort('a.name')
<% else %>
$("<%=j render(@folder, current: nil) %>").appendTo('#folder-list-box > ul')
$('#folder-list-box ul > li').tsort('a.name')
<% end %>
<% end %>