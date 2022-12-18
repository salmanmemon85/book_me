class WebhooksController < ApplicationController
    skip_before_action :authenticity_token

    def create
        payload = request.body.read
        signature_header = request.env
        ['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :whsc)
    event = nil
    begin 
        event = Stripe::Webhook.construct_event(
            payload. signature_header, endpoint_secret
        )
        
    rescue JSON::ParserError => e
    render json: {message: e}, status: 400        
       rescue Stripe::SignatureVerificationError => e
    render json: {message: e}, status: 400        
        return
end
case event.type
when "payment_intent.succeeded"
    @user = User.find(event.data.object.metadata['user_id'])
    @bookings = Booking.where(booking_type_id: @user.booking_type_ids)
    @booking = @bookings.last
    @booking.update(customer_paid: true, status: "approved")
when "payment_intent.processing"
when "payment_intent.payment_faild"
else
    puts "Unhandle event type: #{event.type}"
    end
end