module Api::V1
  module UserEnrollmentDoc
    extend Apipie::DSL::Concern
    include Api::ParamGroupsDocExtend

    api :POST, "api/user_enrollment", "User enrollment"
    error :code => 400, :desc => "Enrollment parameters error"
    error :code => 500, :desc => "Internal server error"
    param :enroll, Hash, :desc => 'Enrollment data' do
      param :email, String, :desc => "Email for login", :required => true
      param :password, String, :desc => "Password for login. At least 6 symbols", :required => true
    end
    formats ['json']
    returns :code => 200, :desc => "a successful response" do
      property :data, NilClass, :desc => "Empty field"
      param_group :errors_data
    end
    def create
      # stub
    end
  end
end
