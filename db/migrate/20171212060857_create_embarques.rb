class CreateEmbarques < ActiveRecord::Migration[5.0]
  def change
    create_table :embarques do |t|
      t.string :numero_guia
      t.string :transportista
      t.datetime :fecha_salida
      t.string :numero_orden
      t.string :destino
      t.string :cliente
      t.string :status

      t.timestamps
    end
  end
end
