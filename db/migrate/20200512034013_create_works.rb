class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :site_type
      t.string :url
      t.string :title
      t.integer :reward_min
      t.integer :reward_max
      t.text :detail
      t.date :expired_at

      t.timestamps
    end
  end
end
