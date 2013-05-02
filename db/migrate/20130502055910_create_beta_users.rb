class CreateBetaUsers < ActiveRecord::Migration
  def change
    create_table :beta_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :beta_interest

      t.timestamps
    end
  end
end
