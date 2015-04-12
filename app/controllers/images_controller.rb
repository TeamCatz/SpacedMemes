class ImagesController < ApplicationController
def post_image_data
  require 'base64'
  require 'securerandom'

  return render :json => {
    :success => false,
    :message => 'you need to specify the data and module parameter.'
  } unless params[:data] && params[:module]

  file = "#{Rails.root}/public/images/pics#{params[:module]}.png"

  png = Base64.decode64(params[:data].gsub(/\n/, '').gsub(' ', '+'))

  File.open(file, 'wb') { |f| f << png }

  if File.exist?(file)
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
end
