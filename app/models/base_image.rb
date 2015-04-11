# == Schema Information
#
# Table name: base_images
#
#  id    :integer          not null, primary key
#  src   :string           not null
#  title :string           not null
#  date  :date             not null
#

class BaseImage  < ActiveRecord::Base

  self.table_name = 'base_images'



end
