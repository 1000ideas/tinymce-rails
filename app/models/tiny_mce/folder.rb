class TinyMce::Folder < ActiveRecord::Base
  self.table_name = 'tinymce_folders'

  has_many :uploads, dependent: :destroy
  belongs_to :parent, class_name: self.name
  has_many :children, foreign_key: :parent_id, class_name: self.name, order: 'name', dependent: :destroy

  scope :for_user, lambda {|uid| where(user_id: uid) }
  scope :roots, lambda { where(parent_id: nil) }
  scope :folder, lambda {|fid| where(parent_id: fid) }
  validates :name, presence: true, uniqueness: {scope: :parent_id}

  attr_accessible :name, :parent_id

  def path
    _path = [self]
    _path << _path.last.parent until _path.last.parent_id.nil?
    _path.reverse
  end

  def ancestor?(folder)
    path.include?(folder)
  end

end