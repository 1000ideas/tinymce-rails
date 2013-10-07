class CreateUploadsAndFolders < ActiveRecord::Migration
  def change
    create_table(:tinymce_folders) do |t|
      t.string :name
      t.integer :parent_id
      t.integer :user_id

      t.timestamps
    end

    create_table(:tinymce_uploads) do |t|
      t.string :title
      t.attachment :file
      t.references :folder
      t.integer :user_id

      t.timestamps
    end

    add_index :tinymce_folders, :parent_id
    add_index :tinymce_folders, :user_id
    add_index :tinymce_uploads, :folder_id
    add_index :tinymce_uploads, :user_id
  end
end
