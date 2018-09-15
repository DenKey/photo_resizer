class ImageCreator
  prepend SimpleCommand

  def initialize(device, params)
    @device = device
    @params = params
  end

  def call
    image = @device.images.new(filename: @params["filename"])
    image.file = @params["data"]
    image.save!

    width = @params["width"]
    height = @params["height"]
    if width && height
      image = ImageResizer.new(@device,
                               image,
                               width,
                               height).call.result
    end

    image
  end
end
