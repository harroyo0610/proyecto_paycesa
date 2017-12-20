class CotizacioninventarioController < ApplicationController
	skip_before_action :verify_authenticity_token
	def show
		inventario =  params[:id].to_i
		carrito = CotizacionInventario.find_by(cotizacion_id: Cotizacion.last.id, inventario_id: inventario)
		if carrito != nil
			flash[:danger] = "El producto que eligio ya habia sido agregado anteriormente"
			redirect_to new_cotizacion_path	
		else
			mov = CotizacionInventario.new(cotizacion_id: Cotizacion.last.id, inventario_id: inventario)
			if mov.save
				flash[:success] = "Producto agregado satisfactoriamente"
				redirect_to new_cotizacion_path	
			end
			
		end
	end

	def create
	    cotizacion = Cotizacion.last
	    movs = CotizacionInventario.where(cotizacion_id: cotizacion.id)
	    flag = false
	    movs.each do |mov|
	    	params.each do |key, value| 
	    		if key.include?("c_producto")
		    		i = key.split(/[^\d]/)[-1].to_i
		    		inventario = Inventario.find(i)
		    		if key.include?("c_producto") && mov.inventario_id == i
			    		mov.update_attributes(c_productos: value.to_i)
			    	end	
		    	end
		    end
	    end
	    if flag == false
	    	flash[:success] = "Cotizacion hecha correctamente"
	    	redirect_to cotizacioninventario_index_path
	    end
  	end

  	def destroy
  		p "#"*50
  		p id = params[:id]
  		p c = Cotizacion.last.id
  		
    	CotizacionInventario.find_by(cotizacion_id: Cotizacion.last.id, inventario_id: params[:id]).destroy
    	flash[:success] = "Producto eliminado"
    	return redirect_to cotizacion_index_path
  end
end
