require 'action_view'
class OrderPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper
	def initialize(cotizacion, tipo)
		super(page_size: "LETTER", margin: 1)
		font "Helvetica"
		font_size 12
		@cotizacion = cotizacion
		productos = VentumInventario.where(ventum_id: @cotizacion.id)
		 #fondo
  		image "public/images/fondo.png", :at => [0,780], :width => 600 
  		draw_text "#{tipo}", :at => [220,635], :size => 24
		draw_text "#{@cotizacion.tc}", :at => [460,730]
		draw_text "#{@cotizacion.created_at.to_s[0..9]}", :at => [465,690]
		draw_text "#{@cotizacion.cliente}", :at => [100,595]
		draw_text "#{@cotizacion.bodega.capitalize}", :at => [100,575]
		draw_text "#{@cotizacion.pago.capitalize}", :at => [100,555]

		y = 440
		productos.each do |item|
			item = Inventario.find_by(id: item.inventario_id)
			draw_text "#{item.upc}", :at => [20,y]
			draw_text "#{@cotizacion.cantidad}", :at => [80,y]
			draw_text "#{item.unidad_medida}", :at => [110,y]
			draw_text "#{item.descripcion}", :at => [150,y]
			draw_text "$#{item.p_venta}", :at => [450,y]
			y = y + 20
		end
		draw_text "#{number_to_currency(@cotizacion.subtotal, precision: 2)} MXN", :at => [460,200]
		draw_text "#{number_to_currency(@cotizacion.descuento, precision: 2)} MXN", :at => [460,180]
		draw_text "#{number_to_currency(@cotizacion.iva, precision: 2)} MXN", :at => [460,160]
		draw_text "#{number_to_currency(@cotizacion.total, precision: 2)} MXN", :at => [460,140]
		draw_text "#{@cotizacion.total.to_words.upcase} PESOS", :at => [60,160]
		#text "Prodcutos: #{productos.each { |producto| producto.upc }} "		
	end

	def place_image(img,x,y,w,h)
		image "public/images/#{img}.png", at: [x.send(:mm), [790-y.send(:mm)]], width: w.send(:mm), heigth: h.send(:mm)
	end
end


	