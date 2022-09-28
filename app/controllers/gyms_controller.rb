class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

def index
  gyms = Gym.all
  render json: gyms
end

def show
  gym = Gym.find(params[:id])
  render json: gym
end

def update
  gym = Gym.find(params[:id])
  gym.update!(gym_params)
  render json: gym
end

def destroy
  gym = Gym.find_by(id: params[:id])
  if gym
    gym.destroy
    head :no_content
  else
    render json: { error: "Gym not found" }, status: :not_found
  end
end



private

def render_not_found_response
  render json: { error: "Gym not found" }, status: :not_found
end

def render_unprocessable_entity_response(exception)
  render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
end

def gym_params
  params.permit(:name, :address)
end


end
