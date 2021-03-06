class ImageResizer
  prepend SimpleCommand

  def initialize(receiver, image, width, height)
    @receiver = receiver
    @image = image
    @width = width
    @height = height
  end

  def call
    file = Tempfile.new(@image.filename || "temp.jpg")
    file.write(@image.file.read.force_encoding(Encoding::UTF_8))
    file.close

    resized_image = MiniMagick::Image.open(file.path)
    resized_image.resize("#{@width}x#{@height}")

    base64_image = Base64.encode64(File.read(resized_image.path))
    base64_data = "data:image/jpg;base64,#{base64_image}"

    new_image = @receiver.images.new(filename: @image.filename,
                                     width_param: @width,
                                     height_param: @height)
    new_image.file = base64_data
    begin
      new_image.save!
    rescue Mongoid::Errors::Validations => e
      errors.add(:validation, e.message)
      return nil
    end
    new_image
  end
end
