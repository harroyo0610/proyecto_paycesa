Rails.application.routes.draw do
  get 'cuentas/index'

  get 'venta/edit'

  get 'user/edit'

  get 'user/new'

  get 'user/show'

  get 'static_pages/home'

  get 'sessions/new'

  get 'inventario/edit'

  get 'inventario/index'

  get 'inventario/new'

  get 'inventario/show'

  get 'embarque/edit'

  get 'embarque/index'

  get 'embarque/new'

  get 'venta/edit'
  resources :inventario
  resources :cliente
  resources :embarque
  resources :cotizacion
  resources :venta
    get 'sessions/new'
  root                  'static_pages#home'
  get     'about'   =>  'static_pages#about'
  get     'help'      =>  'static_pages#help'
  get     'contact'   =>  'static_pages#contact'
  get     'cuentas'   =>  'static_pages#cuentas_cobrar'
  get     'signup'    =>  'users#new'
  get     'login'   =>  'sessions#new'
  post    'login'   =>  'sessions#create'
  delete  'logout'  =>  'sessions#destroy'
  resources :users

end
