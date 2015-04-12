class AppController < ApplicationController
  def browse
    @tags = Tags.select(:tag, 'count(*)').all.group(:tag).order(count: :desc)
    @images = Images.all.order(created_at: :desc).limit(10)
  end

  def create
  end

  def share
  end

  def byTag
    tag = params[:tag]
    @tags = Tags.where(tag: tag)
  end
end
