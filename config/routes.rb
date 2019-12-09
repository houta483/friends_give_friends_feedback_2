Rails.application.routes.draw do
  root :to => "feedbacks#index"
  # Routes for the Feedback resource:

  # CREATE
  get("/feedbacks/new", { :controller => "feedbacks", :action => "new_form" })
  post("/create_feedback", { :controller => "feedbacks", :action => "create_row" })

  # READ
  get("/feedbacks", { :controller => "feedbacks", :action => "index" })
  get("/feedbacks/:id_to_display", { :controller => "feedbacks", :action => "show" })

  # UPDATE
  get("/feedbacks/:prefill_with_id/edit", { :controller => "feedbacks", :action => "edit_form" })
  post("/update_feedback/:id_to_modify", { :controller => "feedbacks", :action => "update_row" })

  # DELETE
  get("/delete_feedback/:id_to_remove", { :controller => "feedbacks", :action => "destroy_row" })

  #------------------------------

  devise_for :users
  # Routes for the User resource:

  # READ
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:id_to_display", { :controller => "users", :action => "show" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
