module Api::V2
  class ImageController < BaseController
    include Api::Concerns::ApipieDefinitions
    before_action :set_device
    before_action :set_image, only: [:show, :update]
    skip_before_action :authenticate_user

    api :GET, "api/images", "Images list "
    error :code => 404, :desc => "Device not found"
    error :code => 500, :desc => "Internal server error"
    formats ['file']
    returns :code => 200, :desc => "images list" do
      property :data, Array, of: Hash, :desc => "Information about saved image" do
        param_group :image_data
      end
      param_group :errors_data
    end
    param_group :device_token
    def index
      render_json data: images_set(@device.images)
    end

    api :GET, "api/images/:id", "Image show"
    error :code => 404, :desc => "Image not found"
    error :code => 500, :desc => "Internal server error"
    formats ['file']
    returns :code => 200, :desc => "image"
    param_group :device_token
    def show
      content = @image.file.read
      if stale?(etag: content, public: true)
        send_data content, content_type: @image.file.content_type, disposition: "inline"
        expires_in 0, public: true
      end
    end

    api :POST, "api/images/:id", "Image upload"
    error :code => 404, :desc => "Device not found"
    error :code => 500, :desc => "Internal server error"
    param :file, Hash, :desc => "Image data", :required => true do
      param :filename, String, :desc => "Name of file with extension", :required => true
      param :width, String, :desc => "Image width"
      param :height, String, :desc => "Image height"
      param :data, String, :desc => "Image in Base64 format", :required => true
    end
    formats ['json']
    param_group :image_json
    param_group :device_token
    def create
      command = ImageCreator.new(@device,
                                 post_params).call

      render_image_json(command)
    end

    api :PUT, "api/images/:id", "Resized already uploaded image"
    error :code => 404, :desc => "Image or Device not found"
    error :code => 500, :desc => "Internal server error"
    param :update, Hash, :desc => "Resize data", :required => true do
      param :width, String, :desc => "Image width"
      param :height, String, :desc => "Image height"
    end
    formats ['json']
    param_group :image_json
    param_group :device_token
    def update
      command =
        ImageResizer.new(@image.device,
                         @image,
                         update_params["width"],
                         update_params["height"]).call

      render_image_json(command)
    end

    private

    def render_image_json(command)
      if command.success?
        render_json data: image_response(command.result)
      else
        raise Api::ImageProcessingFailed
      end
    end

    def post_params
      params.require(:file).permit(:filename, :width, :height, :data)
    end

    def update_params
      params.require(:update).permit(:id, :width, :height)
    end

    def set_image
      begin
        @image = Image.find_by(id: params[:id], device_id: @device.id)
      rescue Mongoid::Errors::DocumentNotFound
        raise Api::RecordNotFound.new("Image not found")
      end
    end

    def set_device
      begin
        @device = Device.
          find_by(token: request.headers.fetch(:authorization, nil))
      rescue Mongoid::Errors::DocumentNotFound
        raise Api::DeviceNotFound.new
      end
    end

    def images_set(images)
      images.map do |image|
        image_response(image)
      end
    end

    def image_response(image)
      {
        id: image.id.to_s,
        filename: image.filename,
        url: api_image_url(id: image.id),
        width: image.width,
        height: image.height,
        width_param: image.width_param,
        height_param: image.height_param
      }
    end
  end
end
