# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  base_image_id :integer          not null
#  tag           :string           not null
#

class Tags < ActiveRecord::Base

  self.table_name = 'tags'

end
