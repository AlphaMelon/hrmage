class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(organization_id: current_organization.id).order(created_at: :desc).page(params[:page]).per(8)
  end
end
