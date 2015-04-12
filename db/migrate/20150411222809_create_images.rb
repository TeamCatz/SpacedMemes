class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :src
      t.date :created_at
    end
  end
end
