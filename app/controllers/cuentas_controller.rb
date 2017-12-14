class CuentasController < ApplicationController
  def index
  	@ventas = Ventum.where(pago: "credito") 
  end
end
