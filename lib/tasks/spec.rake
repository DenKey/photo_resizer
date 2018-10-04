if Rails.env.test?
  begin
    require 'rspec/core/rake_task'

    namespace :spec do
      desc "Run specs for physical models"
      RSpec::Core::RakeTask.new(:models) do |t|
        t.pattern = 'spec/models/**/*_spec.rb'
        t.fail_on_error = false
      end
    end
  rescue LoadError
    # no rspec available
  end
end