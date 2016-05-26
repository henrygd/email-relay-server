Rails.application.routes.draw do

  root      'landing#index'
  get       'sendmail' => 'relay_mail#send_mail'
  resources :keys, only: [:create]

end