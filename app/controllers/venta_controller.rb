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
    productos = VentumInventario.where(ventum_id: @venta.id)
    suma = 0
    productos.each do |producto|
      inventario = Inventario.find_by(id: producto.inventario_id)
      suma = suma + inventario.p_venta
      if inventario.cantidad < @venta.cantidad
        flash[:danger] = "La venta no tiene suficiente inventario"
        redirect_to new_ventum_path
      end
    end

    subtotal =  (suma * @venta.cantidad)
    descuento =  (((suma*@venta.cantidad) / 100 ) * @venta.descuento)
    total = ((subtotal-descuento) * 1.16)
    iva = (subtotal-descuento)*0.16

    if @venta.subtotal ==nil
      @venta.update_attributes(subtotal: subtotal, descuento: descuento, iva: iva, total: total, status: "completada")
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
    inventario = Inventario.find_by(upc: producto)
    if inventario == nil && producto != ""
      flash[:danger] = "Producto con el upc que busco no existe"
      return redirect_to new_ventum_path
    end
    result = VentumInventario.find_by(ventum_id: venta.id, inventario_id: inventario.id) if producto != ""
	  	if producto && inventario && result == nil
	  		producton = VentumInventario.new(ventum_id: venta.id, inventario_id: inventario.id)
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
		    else
		      render 'new'
		    end
	  	else
	  		redirect_to new_ventum_path
	  	end    
  end

  def destroy
    VentumInventario.find_by(ventum_id: Ventum.last.id, inventario_id: params[:id]).destroy
    redirect_to new_ventum_path
  end

  private
  	def venta_params
  		params.require(:ventum).permit(:tc, :cliente, :bodega, :pago, :cantidad, :subtotal, :descuento, :iva, :total, :status)
  	end
end