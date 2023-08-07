class ImagesFacade
  def images_search(query)
    images_data = ImagesService.endpoint("search/photos?page=1", query)
    create_images(images_data[:results])
  end

  private
  def create_images(image_data)
    image_data.map do |image_datum|
      Image.new(image_datum)
    end
  end
end