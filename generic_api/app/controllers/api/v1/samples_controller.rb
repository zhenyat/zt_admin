class Api::V1::SamplesController < Api::ApiController
  def index
    @samples  = Sample.active
    render json: @samples
  end
end