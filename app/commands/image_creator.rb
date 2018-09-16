class ImageCreator
  prepend SimpleCommand

  def initialize(receiver, params)
    @receiver = receiver
    @params = params
  end

  def call
    width = @params["width"]
    height = @params["height"]

    image = @receiver.images.new(filename: @params["filename"],
                                 width_param: width,
                                 height_param: height)
    image.file = @params["data"]
    begin
      image.save!
    rescue Mongoid::Errors::Validations => e
      errors.add(:validation, e.message)
      return nil
    end

    if width && height
      image = ImageResizer.new(@receiver,
                               image,
                               width,
                               height).call.result
    end

    image
  end
end
