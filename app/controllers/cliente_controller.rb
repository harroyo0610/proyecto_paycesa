class ClienteController < ApplicationController

  def index
    @clientes = Cliente.all
    respond_to do |format|
      format.html
      format.csv{ send_data  @clientes.to_csv  }
      format.xls{ send_data  @clientes.to_csv(col_sep: "\t") }
    end
  end

  def new
    @cliente = Cliente.new
  end
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      flash[:success] = "Cliente guardado"
      #flash[:success] = "Welcome to my app"
      #log_in(@)
      redirect_to cliente_index_path
    else
      flash[:danger] = "Todos los campos deben estar llenos"
      render 'new'
    end
  end

  def edit
    @cliente = Cliente.find(params[:id])
  end

  def update
    @cliente = Cliente.find(params[:id])
    if @cliente.update_attributes(cliente_params)
      flash[:success] = "Cliente actualizado"
      #flash[:success] = "Profile updated"
      redirect_to cliente_index_path
    else
      flash[:danger] = "Todos los campos deben estar llenos"
      render 'edit'
    end
  end

  def show
    
  end

  def destroy
    Cliente.find(params[:id]).destroy
    flash[:success] = "Cliente borrado"
    redirect_to cliente_index_path
  end

  private
    def cliente_params
      params.require(:cliente).permit(:nombre, :telefono, :email, :direccion, :direccion_entrega)
    end
end
