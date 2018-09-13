module OhmExtends
  extend ActiveSupport::Concern

  class_methods do
    def find_by(attrs)
      find(attrs).first
    end

    def create!(attrs)
      self.new(attrs).save!
    end
  end
end
