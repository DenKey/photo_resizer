class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :filename, type: String
  field :width, type: String
  field :height, type: String

  mount_base64_uploader :file, ImageUploader

  MIME::Types.add(
    MIME::Type.new('data:image/jpg').tap do |type|
      type.add_extensions 'jpg'
    end
  )

  belongs_to :device
end
