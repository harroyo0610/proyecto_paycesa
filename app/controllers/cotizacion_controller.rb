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

  def index
    @cotizacion = Cotizacion.last
    @movs = CotizacionInventario.where(cotizacion_id: @cotizacion.id) 
  end

  def show
    @cotizacion = Cotizacion.last
    productos = []
    @movs = CotizacionInventario.where(cotizacion_id: @cotizacion.id) 
    @movs.each do |mov|
        productos << inventario = Inventario.find(mov.inventario_id)
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf =  OrderPdf.new(@cotizacion, @movs, productos, "Cotizacion")
        send_data pdf.render, filename: "cotizacion_#{@cotizacion.tc}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def update
    cotizacion = Cotizacion.find(params[:id])
    productos = CotizacionInventario.where(cotizacion_id: cotizacion.id)
    suma = 0
    productos.each do |producto|
      inventario = Inventario.find_by(id: producto.inventario_id)
      suma = suma + (inventario.p_venta * producto.c_productos)
    end
    subtotal =  suma
    descuento =  ((subtotal / 100 ) * params[:cotizacion][:descuento].to_f)
    total = ((subtotal-descuento) * 1.16)
    iva = (subtotal-descuento)*0.16

    if cotizacion.subtotal == nil 
      cotizacion.update_attributes(cliente: params[:cotizacion][:cliente], bodega: params[:cotizacion][:bodega], pago: params[:cotizacion][:pago], subtotal: subtotal, descuento: descuento, iva: iva, total: total, status: "completada")
      redirect_to cotizacion_path(Cotizacion.last)
    else
      redirect_to cotizacioninventario_index_path
    end
  end

  def destroy
    CotizacionInventario.find_by(cotizacion_id: cotizacion.last.id, inventario_id: params[:id]).destroy
    redirect_to new_cotizacion_path
  end

  private
    def cotizacion_params
      params.require(:cotizacion).permit(:tc, :cliente, :bodega, :pago, :subtotal, :descuento, :iva, :total, :status)
    end
end
