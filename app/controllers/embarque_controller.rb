class EmbarqueController < ApplicationController
	def index
  	@embarques = Embarque.all
  end

  def new
  	@clientes = Cliente.all
  	@embarque = Embarque.new
  end
  def create
  	@embarque = Embarque.new(embarque_params)

  	if @embarque.save
      flash[:success] = "Embarque guardado"
  		#flash[:success] = "Welcome to my app"
      #log_in(@)
  		redirect_to embarque_index_path
  	else
      flash[:danger] = "Todos los campos deben estar llenos"
  		render 'new'
  	end
  end

  def edit
  	@clientes = Cliente.all
    @embarque = Embarque.find(params[:id])
  end

  def update
    @embarque = Embarque.find(params[:id])
    if @embarque.update_attributes(embarque_params)
      flash[:success] = "Embarque actualizado"
      #flash[:success] = "Profile updated"
      redirect_to embarque_index_path
    else
      flash[:danger] = "Todos los campos deben estar llenos"
      render 'edit'
    end
  end

  def destroy
		Embarque.find(params[:id]).destroy
		flash[:success] = "Embarque borrado"
		redirect_to embarque_index_path
	end

  private
  	def embarque_params
  		params.require(:embarque).permit(:numero_guia, :transportista, :fecha_salida, :numero_orden, :destino, :cliente, :status)
  	end
end
