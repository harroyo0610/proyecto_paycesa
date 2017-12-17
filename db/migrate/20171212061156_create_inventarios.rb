class CreateInventarios < ActiveRecord::Migration[5.0]
  def change
    create_table :inventarios do |t|
      t.string :upc
      t.string :unidad_medida
      t.string :tipo
      t.string :bodega
      t.string :modelo
      t.string :descripcion
      t.float :compra
      t.float :p_venta
      t.integer :cantidad

      t.timestamps
    end
  end
end
