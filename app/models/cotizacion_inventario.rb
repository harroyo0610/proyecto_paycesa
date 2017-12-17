class CotizacionInventario < ApplicationRecord
	belongs_to :cotizacion
  	belongs_to :inventario
end
