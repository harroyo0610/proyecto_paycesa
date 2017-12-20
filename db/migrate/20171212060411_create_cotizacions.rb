class CreateCotizacions < ActiveRecord::Migration[5.0]
  def change
    create_table :cotizacions do |t|
      t.string :tc
      t.string :cliente
      t.string :bodega
      t.string :pago
      t.integer :cantidad
      t.float :subtotal
      t.float :descuento
      t.float :iva
      t.float :total
      t.string :status

      t.timestamps
    end
  end
end
