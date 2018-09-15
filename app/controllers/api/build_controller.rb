module Api
  class BuildController < Api::BaseController
    include Api::Concerns::ApipieDefinitions
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
      param_group :errors_data
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
