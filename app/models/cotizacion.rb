class Cotizacion < ApplicationRecord
	has_many :cotizacions_inventarios
  	has_many :inventarios, through: :cotizacions_inventarios
end
