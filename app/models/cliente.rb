class Cliente < ApplicationRecord
	validates :nombre, :telefono, :email, :direccion, :direccion_entrega,   presence: true
	def self.to_csv(options = {})
			CSV.generate(options) do |csv|
				csv << column_names
				all.each do |i|
					csv << i.attributes.values_at(*column_names)
				end
			end
	end
end
