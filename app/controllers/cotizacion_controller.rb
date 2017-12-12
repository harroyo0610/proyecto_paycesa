class CotizacionController < ApplicationController
  def new
  	x = ""
  	x = params[:tc][:tc] unless params[:tc].nil?
  	if x == "yes"
  		@tc_tc = rand(1000000000000)
  		@cotizacion = Cotizacion.new(tc: @tc_tc, cliente: "", bodega:"", pago: "", cantidad: 0, descuento: 0)
  		@cotizacion.save!
  	end
  	@clientes = Cliente.all
  	@cotizacion = Cotizacion.last
  	render 'edit'
  end

  def create
  	@cotizacion = Cotizacion.new(cotizacion_params)

  	if @cotizacion.save
  		#flash[:success] = "Welcome to my app"
      #log_in(@)
  		redirect_to new_cotizacion_path
  	else
  		render 'new'
  	end
  end
  

  def update
  	cotizacion = Cotizacion.last
  	producto = params[:cotizacion][:producto][:producto]
    producto
  	result = Producto.find_by(tc: cotizacion.tc, upc: producto)
  	inventario = Inventario.find_by(upc: producto)
	  	if producto && result == nil && inventario
	  		
	  		producton = Producto.new(tc: cotizacion.tc, upc: producto, nombre: inventario.descripcion, cantidad: inventario.cantidad, precio: inventario.venta, bodega: inventario.bodega)
	  		if producton.save
	  			redirect_to new_cotizacion_path
	  		else
		  		render 'new'
		  	end
	  		product =  params.require(:cotizacion).require(:producto).permit(:producto)
	  	elsif producto == ""
	  		@cotizacion = Cotizacion.last

		    if @cotizacion.update_attributes(cotizacion_params)
         p "si" * 100
		    	#flash[:success] = "Profile updated"
		    	redirect_to cotizacion_path(@cotizacion)
		    else
		      render 'new'
		    end
	  	else
	  		redirect_to new_cotizacion_path
	  	end    
  end

  def show

    @cotizacion = Cotizacion.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf =  OrderPdf.new(@cotizacion, "Cotización")
        send_data pdf.render, filename: "cotizacion_#{@cotizacion.tc}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def destroy
    Producto.find(params[:id]).destroy
    redirect_to new_cotizacion_path
  end

  private
  	def cotizacion_params
  		params.require(:cotizacion).permit(:tc, :cliente, :bodega, :pago, :cantidad, :descuento)
  	end
end
