class CreateGroupUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :group_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
