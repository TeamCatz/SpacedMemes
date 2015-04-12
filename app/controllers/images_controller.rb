class ImagesController < ApplicationController
  def post_image_data
    require 'base64'
    require 'securerandom'

    return render :json => {
                      :success => false,
                      :message => 'you need to specify the data and module parameter.'
                  } unless params[:data] && params[:module]

    #file = "#{Rails.root}/public/images/pics#{params[:module]}.png"

    png = Base64.decode64(params[:data].gsub(/\n/, '').gsub(' ', '+'))
    key =  SecureRandom.uuid
    object = S3_BUCKET.put_object(:key => key, :body => png )#, :content_length => png.length)
    if object and object.key == key then
      Images.create(:src => key)
      render :json => {
                 :success => true
             }
    else
      render :json => {
                 :success => false,
                 :message => 'something went wrong when saving ' + file
             }
    end

  end

  def getImage
    base_image = BaseImage.find(params[:id])
    #@image = Net::HTTP.get(URI.parse(base_image.src))
    data =  Net::HTTP.get(URI.parse(base_image.src))
    send_data data, disposition: 'inline'
  end

  def loadMore
      more = 50
      start = params[:start].to_i
      if params[:tag] and params[:tag].length > 0 then
        @total_count = Tags.where(tag: params[:tag]).count
        tags = Tags.where(tag: params[:tag]).limit(more).offset(start)
        @base_images = []
        tags.each do |tag|
          @base_images << tag.base_image
        end
      else
        @total_count = BaseImage.all.count
        @base_images = BaseImage.all.limit(more).offset(start)
      end
      if @total_count > start + more
        has_more = true
      else
        has_more = false
      end
      images = []

      result = {
          :has_more => has_more.to_s,
          :images => @base_images
      }
    send_data result.to_json
  end
end
