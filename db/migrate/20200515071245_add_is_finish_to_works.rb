class AddIsFinishToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :is_finish, :boolean, after: :expired_at
  end
end
