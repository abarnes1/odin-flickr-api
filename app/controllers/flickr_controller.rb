class FlickrController < ApplicationController
  def index
    return unless params[:flickr_user_id]

    flickr = Flickr.new

    photos_json = flickr.people.getPublicPhotos(user_id: '7702423@N04', per_page: 10)

    @photos = photos_json.each_with_object([]) do |photo, array|
      array << { thumbnail: Flickr.url_m(photo), full: Flickr.url(photo) }
    end
  end
end
