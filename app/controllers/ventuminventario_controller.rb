class VentuminventarioController < ApplicationController
	 skip_before_action :verify_authenticity_token
	def show
		inventario =  params[:id].to_i
		carrito = VentumInventario.find_by(ventum_id: Ventum.last.id, inventario_id: inventario)
		if carrito != nil
			flash[:danger] = "El producto que eligio ya habia sido agregado anteriormente"
			redirect_to new_ventum_path	
		else
			mov = VentumInventario.new(ventum_id: Ventum.last.id, inventario_id: inventario)
			if mov.save
				flash[:success] = "Producto agregado satisfactoriamente"
				redirect_to new_ventum_path	
			end
			
		end
	end

	def create
	    venta = Ventum.last
	    movs = VentumInventario.where(ventum_id: venta.id)
	    flag = false
	    movs.each do |mov|
	    	params.each do |key, value| 
	    		if key.include?("c_producto")
		    		i = key.split(/[^\d]/)[-1].to_i
		    		inventario = Inventario.find(i)
		    		if inventario.cantidad < value.to_i
		    			flag = true
		    			flash[:danger] = "La cantidad de producto que desea es mayor a la que existe en inventario"
		    			return redirect_to venta_path
		    		end
		    		if key.include?("c_producto") && mov.inventario_id == i
			    		mov.update_attributes(c_productos: value.to_i)
			    		cantidad = inventario.cantidad - value.to_i
		    			inventario.update_attributes(cantidad: cantidad)
			    	end	
		    	end
		    end
	    end
	    if flag == false
	    	flash[:success] = "Venta hecha correctamente"
	    	redirect_to ventuminventario_index_path
	    end
  	end

  	def destroy
    VentumInventario.find_by(ventum_id: Ventum.last.id, inventario_id: params[:id]).destroy
    flash[:success] = "Producto eliminado"
    return redirect_to venta_path
  end

end
