class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @forecast = WeatherService.call(lat: @location.latitude, lon: @location.longitude)
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)
    geo = GeocodingService.call(query: @location.query)

    status =
      if geo[:lat]
        :ok 
      elsif geo[:rate_limited] 
        :rate_limited
      elsif geo[:no_value]
        :no_value
      else 
        :unknown
      end

    case status
      when :ok
        @location.latitude = geo[:lat]
        @location.longitude = geo[:lon]
        @location.label = geo[:label]
      
        if @location.save
          redirect_to locations_path, notice: "Location was succesfully created."
        else 
          render :new, status: :unprocessable_entity
        end 
      when :rate_limited
        @location.errors.add(
          :query, 
          "Geocoding service is temporarily unavailable — please try again in a moment."
          )
        render :new, status: :unprocessable_entity
      when :no_value
        @location.errors.add(
          :query, 
          "could not be geocoded — try a more specific address (e.g., city + country)"
          )
        render :new, status: :unprocessable_entity
      when :unknown
        @location.errors.add(
          :query, 
          "Unexpected geocoding response — please try again."
          )
        render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: "Location was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_path, notice: "Location was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:query, :latitude, :longitude, :label)
    end
end


  
