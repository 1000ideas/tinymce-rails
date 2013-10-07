class TinyMce::Upload < ActiveRecord::Base
  self.table_name = 'tinymce_uploads'

  belongs_to :folder

  has_attached_file :file,
    styles: lambda {|a| a.instance.send :styles_for_attachment }

  
  scope :for_user, lambda {|uid| where(user_id: uid) }
  scope :folder, lambda {|fid| where(folder_id: fid) }

  validates :file, attachment_presence: true
  validates :title, presence: true

  before_validation :set_default_title

  def image?
    !!file_content_type.match(/^image/)
  end

  def thumb
    if image?
      file.url(:thumb)
    else
      nil
    end    
  end

  private

  def set_default_title
    if title.blank?
      self.title = file_file_name.gsub(/\.[a-z]+$/i, '').titleize
    end
  end

  def styles_for_attachment
    if self.image?
      {thumb: "100x100#"}
    else
      {}
    end
  end


end