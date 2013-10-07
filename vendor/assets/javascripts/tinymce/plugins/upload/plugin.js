
tinymce.PluginManager.add('upload', function(editor, url) {
  self = this

  var prefix = editor.settings.upload_path_prefix;

  if (typeof prefix == 'undefined' || prefix == null) {
    prefix = ''
  }

  var current = null;
  var win;

  var insertImage = function(title, link) {
    img = new Image()
    img.onload = function() {
      editor.insertContent(editor.dom.createHTML('img', {
        src: link,
        alt: title,
        title: title,
        width: img.width,
        height: img.height
      }));
    };

    img.onerror = function() {
      editor.insertContent(editor.dom.createHTML('img', {
        src: link,
        alt: title,
        title: title
      }));
    };

    img.src = link;
  }

  var setCurrentItem = function(name, link, img) {
    if (name != null) {
      current = {
        name: name, 
        url: link,
        image: img
      };

      
    } else {
      current = null;
    }

    self.win.statusbar.items()[0].disabled(current == null)
  }


  var openDialog = function(source, callback) {
    self.win = editor.windowManager.open({
      // title: "File manager",
      url: prefix + '/tinymce/uploads.html',
      width: 720,
      height: 600,
      buttons: [
        {text: 'Insert', disabled: true, subtype: 'primary', onclick: function(e) {
          if (callback != null && callback.call != null) {
            callback(current.url);
          } else {
            if (current.image) {
              insertImage(current.name, current.url);
            } else {
              editor.insertContent(editor.dom.createHTML('a', {
                href: current.url,
                target: null,
                rel: null
              }, current.name));
            }
          }
          self.win.close();
        }},
        {text: 'Cancel', onclick: function(e){
          self.win.close();
        }}
      ]
    }, {
      prefix: prefix,
      source: source
    });
  };


  editor.addButton('filechooser', {
    tooltip: 'Insert file',
    icon: 'browse',
    onclick: openDialog
  });

  editor.addMenuItem('filechooser', {
    text: 'Insert file',
    context: 'inset',
    onclick: openDialog
  });

  editor.settings.file_browser_callback = function(field, url, type, win) {
    openDialog(type, function(value) {
      win.document.getElementById(field).value = value;
    });
  };

  this.openDialog = openDialog;
  this.setCurrentItem = setCurrentItem;

});