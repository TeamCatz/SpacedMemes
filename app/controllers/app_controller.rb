class AppController < ApplicationController
  def browse
    @tags = Tags.select(:tag, 'count(*)').all.group(:tag).order(count: :desc)
    @images = Images.all.order(created_at: :desc).limit(10)
    if params[:tag] and params[:tag].length > 0 then
      @base_images = Tags.where(tag: params[:tag]).limit 50
    else
      @base_images = Tags.all.limit 50
    end

  end

  def create
    @base_image = BaseImage.find(params[:id])
  end

  def share
  end

end
