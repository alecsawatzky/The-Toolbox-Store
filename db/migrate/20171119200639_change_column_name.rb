class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :Products, :sale, :new
  end
end
