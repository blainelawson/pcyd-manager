class ChangeColumnTypeInBoardMembers < ActiveRecord::Migration
  def change
    change_column :board_members, :phone, :string
  end
end
