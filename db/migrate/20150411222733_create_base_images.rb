class CreateBaseImages < ActiveRecord::Migration
  def change
    create_table :base_images do |t|
      t.string :src
      t.string :title
      t.date :date
    end
  end
end
