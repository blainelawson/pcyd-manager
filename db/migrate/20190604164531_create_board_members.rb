class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_table :board_members do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :password_digest
      t.string :title
    end
  end
end
