class ChangePhoneColumn < ActiveRecord::Migration
  def change
    remove_column :contacts, :phone
    add_column :contacts, :phone, :string
  end
end
