class VentaController < ApplicationController
  def new
  	x = ""
  	x = params[:tc][:tc] unless params[:tc].nil?
  	if x == "yes"
  		@tc_tc = rand(1000000000000)
  		@venta = Ventum.new(tc: @tc_tc, cliente: "", bodega:"", pago: "", cantidad: 0, descuento: 0)
  		@venta.save!
  	end
  	@clientes = Cliente.all
  	@venta = Ventum.last
  	render 'edit'
  end

  def create
  	@venta = Ventum.new(venta_params)

  	if @venta.save
  		#flash[:success] = "Welcome to my app"
      #log_in(@)
  		redirect_to new_ventum_path
  	else
  		render 'new'
  	end
  end
  def show
    @venta = Ventum.find(params[:id])
    productos = Producto.where(tc: @venta.tc)
    productos.each do |producto|
      inventario = Inventario.find_by(upc: producto.upc)
      if inventario.cantidad < @venta.cantidad
        flash[:danger] = "La venta no tiene suficiente inventario"
        redirect_to new_ventum_path
      end
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf =  OrderPdf.new(@venta, "Venta")
        send_data pdf.render, filename: "venta_#{@venta.tc}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def update
  	venta = Ventum.last
  	producto = params[:ventum][:producto][:producto]
    
  	result = Producto.find_by(tc: venta.tc, upc: producto)
  	inventario = Inventario.find_by(upc: producto)
	  	if producto && result == nil && inventario
	  		
	  		producton = Producto.new(tc: venta.tc, upc: producto, nombre: inventario.descripcion, cantidad: inventario.cantidad, precio: inventario.venta, bodega: inventario.bodega)
	  		if producton.save
	  			redirect_to new_ventum_path
	  		else
		  		render 'new'
		  	end
	  		product =  params.require(:ventum).require(:producto).permit(:producto)
	  	elsif producto == ""
	  		@venta = Ventum.last

		    if @venta.update_attributes(venta_params)
         redirect_to ventum_path(@venta)
		    	#flash[:success] = "Profile updated"
		    	#redirect_to root_path
		    else
		      render 'new'
		    end
	  	else
	  		redirect_to new_ventum_path
	  	end    
  end

  def destroy
    Producto.find(params[:id]).destroy
    redirect_to new_ventum_path
  end

  private
  	def venta_params
  		params.require(:ventum).permit(:tc, :cliente, :bodega, :pago, :cantidad, :descuento)
  	end
end
