module Api::V1
  module BuildDoc
    extend Apipie::DSL::Concern
    include Api::ParamGroupsDocExtend

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
      # stub
    end
  end
end
