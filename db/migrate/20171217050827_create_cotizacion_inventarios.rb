class CreateCotizacionInventarios < ActiveRecord::Migration[5.0]
  def change
    create_table :cotizacion_inventarios  do |t|
    	t.belongs_to :cotizacion, index: true
    	t.belongs_to :inventario, index: true
    	t.integer 	:c_productos
    end
  end
end
