class ImageCreator
  prepend SimpleCommand

  def initialize(device, params)
    @device = device
    @params = params
  end

  def call
    width = @params["width"]
    height = @params["height"]

    image = @device.images.new(filename: @params["filename"],
                               width_param: width,
                               height_param: height)
    image.file = @params["data"]
    image.save!

    if width && height
      image = ImageResizer.new(@device,
                               image,
                               width,
                               height).call.result
    end

    image
  end
end
