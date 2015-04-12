class AppController < ApplicationController

  def browse
    @LoadLimit = 50
    @tags = Tags.select(:tag, 'count(*)').all.group(:tag).order(count: :desc)
    @images = Images.all.order(created_at: :desc).limit(10)
    if params[:tag] and params[:tag].length > 0 then
      @total_count = Tags.where(tag: params[:tag]).count
      tags = Tags.where(tag: params[:tag]).limit @LoadLimit
      @base_images = []
      tags.each do |tag|
        @base_images << tag.base_image
      end
    else
      @total_count = BaseImage.all.count
      @base_images = BaseImage.all.limit @LoadLimit
    end

  end

  def create
    @base_image = BaseImage.find(params[:id])
  end

  def share
  end

end
