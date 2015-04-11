class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :src
    end
  end
end
