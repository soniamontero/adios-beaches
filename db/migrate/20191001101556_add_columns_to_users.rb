class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :batch_number, :integer
    add_column :users, :batch_location, :string
    add_column :users, :github_username, :string, null: false
    add_column :users, :slack_username, :string
    add_column :users, :visited_bali, :boolean, default: false
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :github_picture_url, :string
    add_column :users, :token, :string
    add_column :users, :first_login, :boolean, default: true
  end
end
