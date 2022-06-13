class ApartmentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  def index
    all_apartments = Apartment.all
    render json: all_apartments, status: :ok
  end

  def show
    one_apartment = Apartment.find_by(id: params[:id])
    if one_apartment
      render json: one_apartment, status: :ok
    else
      render json: {error: "Apartment record not found"}, status: :not_found
    end
  end

  def create
    new_apartment = Apartment.create!(apartment_params)
    render json: new_apartment, status: :created
  end

  def destroy
    apartment = Apartment.find_by(id: params[:id])
    if apartment
      apartment.destroy
      head :no_content
    else
      render json: { error: "This apartment does not exist and cannot be deleted." }, status: :not_found
    end
  end

  def update
    update_apartment = Apartment.find_by(id: params[:id])
    update_apartment.update!(apartment_params)
    render json: update_apartment, status: :ok
  end

  private

  def apartment_params
    params.permit(:number)
  end

  def render_not_found_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :not_found
  end

  def render_invalid_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
  
end
