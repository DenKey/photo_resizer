module Api::Concerns::ApipieDefinitions
  extend ActiveSupport::Concern

  included do
    def_param_group :image_data do
      property :id, String, :desc => "Image id"
      property :filename, String, :desc => "Name of file with extension"
      property :url, String, :desc => "Full url address to image"
      property :width, String, :desc => "Image final width"
      property :height, String, :desc => "Image final height"
      property :width_param, String, :desc => "Image height from user"
      property :height_param, String, :desc => "Image height from user"
    end

    def_param_group :errors_data do
      property :errors, Array, of: Hash, :desc => "Arrays wih errors hash, if present" do
        property :code, String, :desc => "Error code"
        property :message, String, :desc => "Ruby error message"
        property :public_message, String, :desc => "Prepared error message for client"
      end
    end

    def_param_group :image_json do
      returns :code => 200, :desc => "a successful response" do
        property :data, Hash, :desc => "Information about saved image" do
          param_group :image_data
        end
        param_group :errors_data
      end
    end

    def_param_group :device_token do
      meta :message => "Authorization header must contain device token"
    end
  end
end
