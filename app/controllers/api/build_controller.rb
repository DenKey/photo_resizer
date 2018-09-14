module Api
  class BuildController < Api::BaseController
    skip_before_action :authenticate_user
    before_action :get_build, only: [:show]

    api :GET, "api/build", "Build status"
    error :code => 404, :desc => "Build not found"
    error :code => 500, :desc => "Internal server error"
    param :build_number, String, :desc => "Build number"
    formats ['json']
    returns :code => 200, :desc => "a successful response" do
      property :data, Hash, :desc => "Data body" do
        property :support_level, Build::SUPPORT_LEVELS, :desc => "Supported level"
      end
      property :errors, Array, of: Hash, :desc => "Arrays wih errors hash" do
        property :code, String, :desc => "Error code"
        property :message, String, :desc => "Ruby error message"
        property :public_message, String, :desc => "Prepared error message for client"
      end
    end
    def show
      render_json data: { support_level: @build.support_level }
    end

    private

    def get_build
      begin
        @build = Build.find_by(build_params)
      rescue Mongoid::Errors::DocumentNotFound
        raise Api::RecordNotFound
      end
    end

    def build_params
      params.permit(:build_number).to_hash.symbolize_keys
    end
  end
end
