class RolesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def index
    @roles = Role.all
  end

  def show
  	@role = Role.find(params[:id].to_i)
  end

  def create
    @role = Role.create!(role_params)
    if @role.save
      render 'create.json.jbuilder', status: :created
    else
      render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      render 'update.json.jbuilder'
    else
      render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
  	@role=Role.find(params[:id].to_i)
    @role.destroy
    render 'destroy.json.jbuilder'
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def not_found
    render json: { error: 'Role not found' }, status: :not_found
  end
end
