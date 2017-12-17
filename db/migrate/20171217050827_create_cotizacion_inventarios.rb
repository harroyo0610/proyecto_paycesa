class CreateCotizacionInventarios < ActiveRecord::Migration[5.0]
  def change
    create_table :cotizacion_inventarios, id: false  do |t|
    	t.belongs_to :cotizacion, index: true
    	t.belongs_to :inventario, index: true
    end
  end
end
