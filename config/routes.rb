Rails.application.routes.draw do
  root 'spreadsheet#index'

  mount ActionCable.server => '/cable'
end
