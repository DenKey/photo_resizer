class ImageResizer
  prepend SimpleCommand

  def initialize(device, image, width, height)
    @device = device
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

    new_image = @device.images.new(filename: @image.filename,
                                   width_param: @width,
                                   height_param: @height)
    new_image.file = base64_data
    new_image.save!
    new_image
  end
end
