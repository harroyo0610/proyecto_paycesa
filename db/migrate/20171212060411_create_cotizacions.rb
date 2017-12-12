class CreateCotizacions < ActiveRecord::Migration[5.0]
  def change
    create_table :cotizacions do |t|
      t.string :tc
      t.string :cliente
      t.string :bodega
      t.string :pago
      t.integer :cantidad
      t.integer :descuento

      t.timestamps
    end
  end
end
