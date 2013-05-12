class AddUniqueIndexToEmailOnBetaUsers < ActiveRecord::Migration
  def up
    add_index :beta_users, :email, :unique => true
  end

  def down
    remove_index :beta_users, :email, :unique => true
  end
end
