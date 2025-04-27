class AddCheckpostToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :checkpost, :string
  end
end
