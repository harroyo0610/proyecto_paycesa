class Ventum < ApplicationRecord
	has_many :venta_inventarios
  	has_many :inventarios, through: :venta_inventarios
end
