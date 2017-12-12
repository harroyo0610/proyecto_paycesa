class CreateClientes < ActiveRecord::Migration[5.0]
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :telefono
      t.string :email
      t.string :direccion
      t.string :direccion_entrega

      t.timestamps
    end
  end
end
