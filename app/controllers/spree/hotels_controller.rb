class Spree::HotelsController < Spree::StoreController

  def index
  	@taxonomies = Spree::Taxonomy.includes(root: :children)

      ean_response = $api.get_list( Ean.to_ean(params) )

      if ean_response.class == Expedia::APIError
          flash.notice = ean_response.presentation_message
          redirect_to root_path
      else
        data = ean_response.body
        @hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']
      end

  end

  def show
  	ean_hotel_info = $api.get_information( :hotelId => params[:id] )
  	data = ean_hotel_info.body
  	@hotel_summary   = data['HotelInformationResponse']['HotelSummary']
    @hotel_detail    = data['HotelInformationResponse']['HotelDetails']
    @room_types      = data['HotelInformationResponse']['RoomTypes']
    @hotel_images    = data['HotelInformationResponse']['HotelImages']

      ean_availability = $api.get_availability( :hotelId => @hotel_summary['hotelId'],
                                          :arrivalDate => params[:arrivalDate],
                                          :departureDate => params[:departureDate],
                                          :includeDetails=> true,
                                          :includeRoomImages=>true,
                                          :room1 => '1,3,5', :room2=>'2', :room3 => '3'
                                          )
    @rooms = []
    params.each do |key, value|
      if  key == key.scan(/room[0-9]*$/).first
         @rooms<<key
      end
    end


    if ean_availability.class == Expedia::APIError
        flash.notice = ean_availability.presentation_message
        redirect_to :back
    else
      data = ean_availability.body
      @availability = data['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    end


  end

end
