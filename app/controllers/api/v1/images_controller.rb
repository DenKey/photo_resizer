module Api::V1
  class ImagesController < BaseController
    include Api::V1::ImagesDoc

    before_action :set_image, only: [:show, :update]

    def index
      render_json data: images_set(current_user.images)
    end

    def show
      content = @image.file.read
      if stale?(etag: content, public: true)
        send_data content, content_type: @image.file.content_type, disposition: "inline"
        expires_in 0, public: true
      end
    end

    def create
      command = ImageCreator.new(current_user,
                                 post_params).call

      render_image_json(command)
    end

    def update
      command =
        ImageResizer.new(current_user,
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
        @image = Image.find_by(id: params[:id], user_id: current_user.id)
      rescue Mongoid::Errors::DocumentNotFound
        raise Api::RecordNotFound.new("Image not found")
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
        url: api_image_v1_url(id: image.id),
        width: image.width,
        height: image.height,
        width_param: image.width_param,
        height_param: image.height_param
      }
    end
  end
end
