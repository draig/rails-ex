require 'authy'

class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def send_sms
    phone_number = params[:phone_number]
    country_code = params[:country_code]

    if !phone_number || !country_code
      render json: { error: 'Not all required params present' }, status: :internal_server_error and return
    end

    response = Authy::PhoneVerification.start(
        via: 'sms',
        country_code: country_code,
        phone_number: phone_number
    )

    if ! response.ok?
      render json: { error: 'Error delivering code verification' }, status: :internal_server_error and return
    end

    render json: response, status: :ok

  end

  def verify_code
    phone_number = params[:phone_number]
    country_code = params[:country_code]
    verification_code = params[:verification_code]

    if !phone_number || !country_code || !verification_code
      render json: { error: 'Not all required params present' }, status: :internal_server_error and return
    end

    response = Authy::PhoneVerification.check(
        verification_code: verification_code,
        country_code: country_code,
        phone_number: phone_number
    )

    if ! response.ok?
      render json: { error: 'Verify Token Error' }, status: :internal_server_error and return
    end

    render json: response, status: :ok
  end
end
