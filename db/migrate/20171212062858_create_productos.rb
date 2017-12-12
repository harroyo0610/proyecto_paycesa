class CreateProductos < ActiveRecord::Migration[5.0]
  def change
    create_table :productos do |t|
      t.string :tc
      t.string :upc
      t.string :nombre
      t.integer :cantidad
      t.float :precio
      t.string :bodega

      t.timestamps
    end
  end
end
