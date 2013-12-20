module TinyMCE
  module Generators
    require 'rails/generators/active_record'

    class InstallGenerator < ::Rails::Generators::Base
      namespace "tinymce:install"
      include ::Rails::Generators::Migration

      source_root  File.dirname(__FILE__)

      desc "Install TinyMCE gem migration files"

      class << self
        delegate :next_migration_number, to: ActiveRecord::Generators::Base
      end

      def create_migration
        migration_template 'migrations/uploads_and_folders.rb', 'db/migrate/create_uploads_and_folders.rb'
      end

      def add_routing
        route "mount TinyMCE::Rails::Engine => '/tinymce'"
      end
    end
  end
end