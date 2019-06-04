class ChangeColumnTypeInMembers < ActiveRecord::Migration
  def change
    change_column :members, :phone, :string
  end
end
