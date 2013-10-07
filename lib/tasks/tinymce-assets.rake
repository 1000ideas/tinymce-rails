assets_task = Rake::Task.task_defined?('assets:precompile:primary') ? 'assets:precompile:primary' : 'assets:precompile'

Rake::Task[assets_task].enhance do
  config   = Rails.application.config
  target   = File.join(Rails.public_path, config.assets.prefix, 'tinymce')
  
  tinymce_assets_paths = []
  tinymce_assets_paths << Pathname.new(File.expand_path(File.dirname(__FILE__) + "/../../vendor/assets/javascripts/tinymce"))
  tinymce_assets_paths << ::Rails.root.join('vendor', 'assets', 'javascripts', 'tinymce')

  [:langs, :plugins, :skins, :themes].each do |folder|
    tinymce_assets_paths.each do |path|
      src = path.join(folder.to_s)
      FileUtils.cp_r(src, target) if File.exists?(src)
    end
  end
end