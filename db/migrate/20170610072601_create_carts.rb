class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts, comment: 'カート' do |t|
      t.references :user, foreign_key: true
      t.integer :status_id, default: 1, null: false, comment: 'ステータスID'

      t.timestamps
    end
  end
end
