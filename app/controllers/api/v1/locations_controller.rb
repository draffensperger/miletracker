class Api::V1::LocationsController < Api::V1::BaseController
  def bulk_create
    locs = params[:locations]
    
    if locs.nil? or locs.length == 0
      num_created = 0
    else
      old_num_locs = current_user.locations.count
      Location.import locs.map { |attrs|
        l = Location.new attrs           
        
        # Hack to make it parse the date for the active record import to work      
        l.recorded_time = l.recorded_time
        
        l.calc_n_vector
        l.user = current_user
        l
      }      
      num_created = current_user.locations.count - old_num_locs
    end
    
    # Calculate the new trips as new locations are uploaded
    TripSeparator.new(current_user).calc_and_save_trips
    
    render json: {num_created_locations: num_created}     
  end
end
