class CreateVenta < ActiveRecord::Migration[5.0]
  def change
    create_table :venta do |t|
      t.string :tc
      t.string :cliente
      t.string :bodega
      t.string :pago
      t.integer :cantidad
      t.float :descuento

      t.timestamps
    end
  end
end
