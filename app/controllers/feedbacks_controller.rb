class FeedbacksController < ApplicationController
  before_action :current_user_must_be_feedback_user, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_feedback_user
    feedback = Feedback.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == feedback.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @feedbacks = Feedback.all

    render("feedback_templates/index.html.erb")
  end

  def show
    @feedback = Feedback.find(params.fetch("id_to_display"))

    render("feedback_templates/show.html.erb")
  end

  def new_form
    @feedback = Feedback.new

    render("feedback_templates/new_form.html.erb")
  end

  def create_row
    @feedback = Feedback.new

    @feedback.user_id = params.fetch("user_id")
    @feedback.comments = params.fetch("comments")

    if @feedback.valid?
      @feedback.save

      redirect_back(:fallback_location => "/feedbacks", :notice => "Feedback created successfully.")
    else
      render("feedback_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @feedback = Feedback.find(params.fetch("prefill_with_id"))

    render("feedback_templates/edit_form.html.erb")
  end

  def update_row
    @feedback = Feedback.find(params.fetch("id_to_modify"))

    
    @feedback.comments = params.fetch("comments")

    if @feedback.valid?
      @feedback.save

      redirect_to("/feedbacks/#{@feedback.id}", :notice => "Feedback updated successfully.")
    else
      render("feedback_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @feedback = Feedback.find(params.fetch("id_to_remove"))

    @feedback.destroy

    redirect_to("/users/#{@feedback.user_id}", notice: "Feedback deleted successfully.")
  end

  def destroy_row
    @feedback = Feedback.find(params.fetch("id_to_remove"))

    @feedback.destroy

    redirect_to("/feedbacks", :notice => "Feedback deleted successfully.")
  end
end
