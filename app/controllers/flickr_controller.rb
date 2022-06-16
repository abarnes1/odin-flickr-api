class FlickrController < ApplicationController
  def index
    if params[:flickr_user_id]
      # flickr = Flickr.new ENV['flickr_api_key'], ENV['flickr_api_secret']
      debugger
      flickr = Flickr.new

      # @photos = flickr.photos.search(tags: params[:flickr_user_id])
      photos = flickr.people.getPublicPhotos(user_id: '7702423@N04', per_page: 5)
      @images = photos.map do |url|
        Flickr.url_m(url)
      end
    end
  end
end
