class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :base_image_id
      t.string :tag
    end
  end
end
