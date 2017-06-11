class AddColumnsToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :postal_code, :string, after: :status_id, default: "", comment: '郵便番号'
    add_column :carts, :address, :string, after: :postal_code, default: '', comment: '住所'
  end
end
