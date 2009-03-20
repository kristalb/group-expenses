class ChangeUsersToAuthlogic < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      say "Rename salt to password_salt"
      t.rename :salt, :password_salt
      say "Remove remember_token and remember_token_expires_at"
      t.remove :remember_token
      t.remove :remember_token_expires_at
      say "Add authlogic columns"
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
    end
  end

  def self.down
    change_table :users do |t|
      say "Rename password_salt to salt"
      t.rename :password_salt, :salt
      say "Add remember_token and remember_token_expires_at"
      t.column :remember_token, :string
      t.column :remember_token_expires_at, :datetime
      say "Remove authlogic columns"
      t.remove :persistence_token
      t.remove :login_count
      t.remove :last_request_at
      t.remove :last_login_at
      t.remove :current_login_at
      t.remove :last_login_ip
      t.remove :current_login_ip
    end
  end
end
