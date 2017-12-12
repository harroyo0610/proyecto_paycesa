class Embarque < ApplicationRecord
	validates :numero_guia, :transportista, :fecha_salida, :numero_orden, :destino, :cliente, :status, presence: true
end
