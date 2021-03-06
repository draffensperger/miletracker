class Api::V1::LocationsController < Api::V1::BaseController
  def bulk_create
    render json: {
      num_created_locations: Location.bulk_create_and_process(current_user,
                                                              location_param)
    }
  end

  private

  def location_param
    params.permit(locations: [:recorded_time, :provider,
                              :latitude, :longitude, :altitude,
                              :accuracy, :speed, :bearing])[:locations]
  end
end
