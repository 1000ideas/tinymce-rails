class TinyMce::UploadsController < ActionController::Base

  layout false

  def index
    @folder = TinyMce::Folder.find(params[:parent]) if params.has_key? :parent

    @uploads = TinyMce::Upload
      .for_user(current_user_id)
      .folder(@folder.try(:id))

    @folders = TinyMce::Folder
      .for_user(current_user_id)
      .order('name')
      .roots

    TinyMCE.authentication_method.call(action_name, @uploads)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @upload = TinyMce::Upload
      .for_user(current_user_id)
      .create(upload_params)

    respond_to do |format|
      format.js
    end
  end

  def update
    @upload = TinyMce::Upload.find(params[:id])
    @current = TinyMce::Folder.find(params[:current]) if params.has_key?(:current)

    upload_params = params[:upload] || {}
    if params.has_key?(:column) &&  params.has_key?(:value)
      upload_params[params[:column]] = params[:value]
    end

    @upload.update_attributes(upload_params)

    respond_to do |format|
      format.js
    end
  end


  def folder
    @folder = TinyMce::Folder
      .for_user(current_user_id)
      .create(folder_params)

    @current = @folder.parent

    respond_to do |format|
      format.js
    end
  end


  def update_folder
    @folder = TinyMce::Folder.find(params[:id])
    @current = TinyMce::Folder.find(params[:current]) if params.has_key?(:current)

    @folder.send("#{params[:column]}=", params[:value])
    @folder.save

    @folders = TinyMce::Folder
      .for_user(current_user_id)
      .order('name')
      .roots

    respond_to do |format|
      format.js
    end
  end

  def destroy_folder
    @folder = TinyMce::Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @upload = TinyMce::Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.js
    end
  end

  def drop
    @upload = TinyMce::Upload.find(params[:id])
    @folder = TinyMce::Folder.where(id: params[:folder_id]).first

    respond_to do |format|
      if @upload.update_attributes(folder_id: @folder.try(:id))
        format.json { render json: {notice: t(".success") } }
      else
        format.json { render json: @upload.errors.full_messages, status: :unprocessable_entity}
      end
    end
  end


  private

  def current_user_id
    if TinyMCE.current_user_method_name and self.respond_to? TinyMCE.current_user_method_name
      self.send(TinyMCE.current_user_method_name).try :id
    end
  end

  def upload_params
    params[:upload].try(:slice, :file, :folder_id) || {}
  end

  def folder_params
    params[:folder].try(:slice, :name, :parent_id) || {}
  end
end
