class VentaController < ApplicationController
  def new
  	x = ""
  	x = params[:tc][:tc] unless params[:tc].nil?
  	if x == "yes"
  		@tc_tc = rand(1000000000000)
  		@venta = Ventum.new(tc: @tc_tc, cliente: "", bodega:"", pago: "", cantidad: 0, descuento: 0)
  		@venta.save!
  	end
  	@venta = Ventum.last
  	render 'edit'
  end

  def create
  end

  def index
    @venta = Ventum.last
    @movs = VentumInventario.where(ventum_id: @venta.id) 
  end

  def show
    @venta = Ventum.last
    productos = []
    @movs = VentumInventario.where(ventum_id: @venta.id) 
    @movs.each do |mov|
        productos << inventario = Inventario.find(mov.inventario_id)
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf =  OrderPdf.new(@venta, @movs, productos, "Venta")
        send_data pdf.render, filename: "venta_#{@venta.tc}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end

  def update
    venta = Ventum.find(params[:id])
    productos = VentumInventario.where(ventum_id: venta.id)
    suma = 0
    productos.each do |producto|
      inventario = Inventario.find_by(id: producto.inventario_id)
      suma = suma + (inventario.p_venta * producto.c_productos)
      if inventario.cantidad < venta.cantidad
        flash[:danger] = "La venta no tiene suficiente inventario"
        redirect_to new_ventum_path
      end
    end
    subtotal =  suma
    descuento =  ((subtotal / 100 ) * params[:ventum][:descuento].to_f)
    total = ((subtotal-descuento) * 1.16)
    iva = (subtotal-descuento)*0.16

    if venta.subtotal == nil 
      venta.update_attributes(cliente: params[:ventum][:cliente], bodega: params[:ventum][:bodega], pago: params[:ventum][:pago], subtotal: subtotal, descuento: descuento, iva: iva, total: total, status: "completada")
      redirect_to ventum_path(Ventum.last)
    else
      redirect_to ventuminventario_index_path
    end
  end

  def destroy
    VentumInventario.find_by(ventum_id: Ventum.last.id, inventario_id: params[:id]).destroy
    redirect_to new_ventum_path
  end

  private
  	def venta_params
  		params.require(:ventum).permit(:tc, :cliente, :bodega, :pago, :subtotal, :descuento, :iva, :total, :status)
  	end
end