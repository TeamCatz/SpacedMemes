class ImagesController < ApplicationController

  before_filter :set_headers

  def post_image_data

    png = Base64.decode64(params[:image].gsub(/\n/, '').gsub(' ', '+'))
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





  private

  def set_headers
    if request.headers["HTTP_ORIGIN"]
      # better way check origin
      # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end


end
