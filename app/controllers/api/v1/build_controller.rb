module Api::V1
  class BuildController < Api::BaseController
    include Api::V1::BuildDoc

    skip_before_action :authenticate_user
    before_action :get_build, only: [:show]

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
