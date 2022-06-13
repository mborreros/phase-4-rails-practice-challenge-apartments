class LeasesController < ApplicationController

 rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def create
    new_lease = Lease.create!(lease_params)
    render json: new_lease, include: ['apartment', 'tenant'], status: :created
  end

  def destroy
    lease = Lease.find_by(id: params[:id])
    if lease
      lease.destroy
      head :no_content
    else
      render json: { error: "This lease does not exist and cannot be deleted." }, status: :not_found
    end
  end

  private

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
