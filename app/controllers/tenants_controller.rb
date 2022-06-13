class TenantsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  def index
    all_tenants = Tenant.all
    render json: all_tenants, status: :ok
  end

  def show
    one_tenant = Tenant.find_by(id: params[:id])
    if one_tenant
      render json: one_tenant, status: :ok
    else
      render json: {error: "Tenant record not found"}, status: :not_found
    end
  end

  def create
    new_tenant = Tenant.create!(tenant_params)
    render json: new_tenant, status: :created
  end

  def destroy
    tenant = Tenant.find_by(id: params[:id])
    if tenant
      tenant.destroy
      head :no_content
    else
      render json: { error: "This tenant does not exist and cannot be deleted." }, status: :not_found
    end
  end

  def update
    update_tenant = Tenant.find_by(id: params[:id])
    update_tenant.update!(tenant_params)
    render json: update_tenant, status: :ok
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def render_not_found_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :not_found
  end

  def render_invalid_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

end
