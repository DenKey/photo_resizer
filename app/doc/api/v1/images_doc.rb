module Api::V1
  module ImagesDoc
    extend Apipie::DSL::Concern
    include Api::ParamGroupsDocExtend

    api :GET, "api/images", "Images list"
    error :code => 401, :desc => "Unauthorized"
    error :code => 500, :desc => "Internal server error"
    formats ['file']
    returns :code => 200, :desc => "images list" do
      property :data, Array, of: Hash, :desc => "Information about saved image" do
        param_group :image_data
      end
      param_group :errors_data
    end
    def index
      # stub
    end

    api :GET, "api/images/:id", "Image show"
    error :code => 401, :desc => "Unauthorized"
    error :code => 404, :desc => "Image not found"
    error :code => 500, :desc => "Internal server error"
    formats ['file']
    returns :code => 200, :desc => "image"
    def show
      # stub
    end

    api :POST, "api/images/:id", "Image upload"
    error :code => 401, :desc => "Unauthorized"
    error :code => 500, :desc => "Internal server error"
    param :file, Hash, :desc => "Image data", :required => true do
      param :filename, String, :desc => "Name of file with extension", :required => true
      param :width, String, :desc => "Image width"
      param :height, String, :desc => "Image height"
      param :data, String, :desc => "Image in Base64 format", :required => true
    end
    formats ['json']
    param_group :image_json
    def create
      # stub
    end

    api :PUT, "api/images/:id", "Resized already uploaded image"
    error :code => 401, :desc => "Unauthorized"
    error :code => 404, :desc => "Image not found"
    error :code => 500, :desc => "Internal server error"
    param :update, Hash, :desc => "Resize data", :required => true do
      param :width, String, :desc => "Image width"
      param :height, String, :desc => "Image height"
    end
    formats ['json']
    param_group :image_json
    def update
      # stub
    end
  end
end
