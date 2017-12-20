require 'action_view'
class OrderPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper
	def initialize(cotizacion, movimientos, productos, tipo)
		super(page_size: "LETTER", margin: 1)
		font "Helvetica"
		font_size 10
		@cotizacion = cotizacion
		if tipo == "Venta"
			productos = VentumInventario.where(ventum_id: @cotizacion.id)
			 #fondo
	  		image "public/images/fondo.png", :at => [0,780], :width => 600 
	  		draw_text "#{tipo}", :at => [220,635], :size => 24
			draw_text "#{@cotizacion.tc}", :at => [460,730]
			draw_text "#{@cotizacion.created_at.to_s[0..9]}", :at => [465,690]
			draw_text "#{@cotizacion.cliente}", :at => [100,595]
			draw_text "#{@cotizacion.bodega.capitalize}", :at => [100,575]
			draw_text "#{@cotizacion.pago.capitalize}", :at => [100,555]

			y = 500
			productos.each do |item|
				item = Inventario.find_by(id: item.inventario_id)
				mov = VentumInventario.find_by(ventum_id: @cotizacion.id, inventario_id: item.id)
				
				draw_text "#{item.upc}", :at => [20,y]
				draw_text "#{item.descripcion}", :at => [80,y]
				draw_text "#{mov.c_productos}", :at => [500,y]
				draw_text "$#{item.p_venta}", :at => [550,y]
				y = y + 20
			end
			draw_text "#{number_to_currency(@cotizacion.subtotal, precision: 2)} MXN", :at => [460,200]
			draw_text "#{number_to_currency(@cotizacion.descuento, precision: 2)} MXN", :at => [460,180]
			draw_text "#{number_to_currency(@cotizacion.iva, precision: 2)} MXN", :at => [460,160]
			draw_text "#{number_to_currency(@cotizacion.total, precision: 2)} MXN", :at => [460,140]
			draw_text "#{@cotizacion.total.to_words.upcase} PESOS", :at => [60,160]
			#text "Prodcutos: #{productos.each { |producto| producto.upc }} "		
		else
			productos = CotizacionInventario.where(cotizacion_id: @cotizacion.id)
			 #fondo
	  		image "public/images/fondo.png", :at => [0,780], :width => 600 
	  		draw_text "#{tipo}", :at => [220,635], :size => 24
			draw_text "#{@cotizacion.tc}", :at => [460,730]
			draw_text "#{@cotizacion.created_at.to_s[0..9]}", :at => [465,690]
			draw_text "#{@cotizacion.cliente}", :at => [100,595]
			draw_text "#{@cotizacion.bodega.capitalize}", :at => [100,575]
			draw_text "#{@cotizacion.pago.capitalize}", :at => [100,555]

			y = 500
			productos.each do |item|
				item = Inventario.find_by(id: item.inventario_id)
				mov = CotizacionInventario.find_by(cotizacion_id: @cotizacion.id, inventario_id: item.id)
				
				draw_text "#{item.upc}", :at => [20,y]
				draw_text "#{item.descripcion}", :at => [80,y]
				draw_text "#{mov.c_productos}", :at => [500,y]
				draw_text "$#{item.p_venta}", :at => [550,y]
				y = y + 20
			end
			draw_text "#{number_to_currency(@cotizacion.subtotal, precision: 2)} MXN", :at => [460,200]
			draw_text "#{number_to_currency(@cotizacion.descuento, precision: 2)} MXN", :at => [460,180]
			draw_text "#{number_to_currency(@cotizacion.iva, precision: 2)} MXN", :at => [460,160]
			draw_text "#{number_to_currency(@cotizacion.total, precision: 2)} MXN", :at => [460,140]
			draw_text "#{@cotizacion.total.to_words.upcase} PESOS", :at => [60,160]
		end
		
	end

end


	