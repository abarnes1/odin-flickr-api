class FlickrController < ApplicationController
  def index
    return unless params[:flickr_user_id].present?

    begin
      @photos = photos_array(params[:flickr_user_id])
    rescue Flickr::FailedResponse => e
      flash.now[:alert] = if e.message == "'flickr.people.getPublicPhotos' - User not found"
                            'User not found!'
                          else
                            'Unknown error!'
                          end
    end
  end

  private

  def photos_array(user_id)
    flickr = Flickr.new
    photos_json = flickr.people.getPublicPhotos(user_id: user_id, per_page: 10)

    photos_json.each_with_object([]) do |photo, array|
      array << { thumbnail: Flickr.url_m(photo), full: Flickr.url(photo) }
    end
  end
end
