Rails.application.routes.draw do
  get 'meetings/new'
  post 'meetings/create'
  put 'meetings/accept'
end
