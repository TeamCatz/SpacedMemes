# == Schema Information
#
# Table name: images
#
#  id  :integer          not null
#  src :string           not null
#

class Images < ActiveRecord::Base

  self.table_name = 'images'

end
