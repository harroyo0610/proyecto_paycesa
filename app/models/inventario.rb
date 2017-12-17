class Inventario < ApplicationRecord
	has_many :cotizacions_inventarios
  	has_many :cotizacions, through: :cotizacions_inventarios
  	has_many :venta_inventarios
  	has_many :venta, through: :venta_inventarios
	validates :upc, :unidad_medida, :tipo, :bodega, :modelo, :descripcion, :compra, :p_venta, :cantidad,   presence: true
	def self.to_csv(options = {})
			CSV.generate(options) do |csv|
				csv << column_names
				all.each do |i|
					csv << i.attributes.values_at(*column_names)
				end
			end
	end

end
