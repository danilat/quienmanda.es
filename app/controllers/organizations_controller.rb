class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = (can? :manage, Entity) ? Entity.organizations : Entity.organizations.published
    @organizations = @organizations.order("updated_at DESC").page(params[:page]).per(16)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    authorize! :read, @organization
    @relations = (can? :manage, Entity) ? @organization.relations : @organization.relations.published
  end

  private
    def set_organization
      @organization = Entity.organizations.find_by_slug(params[:id])
    end
end
