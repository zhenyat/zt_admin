class Api::ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
end