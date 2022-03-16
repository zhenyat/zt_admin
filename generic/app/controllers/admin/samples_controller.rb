###########################################################
#   samples_controller.rb
#
#   Demo controller for Admin with Active Storage
#
#   05.11.2020  ZT
###########################################################
class Admin::SamplesController < Admin::BaseController
  before_action :set_sample,    only: [:show, :edit, :update,:destroy]
  after_action  :remove_images, only: :update

  def index
    @samples = policy_scope(Sample)
  end

  def show
    authorize @sample
  end

  def new
    @sample = Sample.new
    authorize @sample
  end

  def edit
    authorize @sample
  end

  def create
    @sample = Sample.new(sample_params)
    authorize @sample
    if @sample.save
      flash[:success] = t('messages.created', model: @sample.class.model_name.human)
      redirect_to [:admin, @sample]
    else      
      render :new
    end
  end

  def update
    authorize @sample
    if @sample.update(sample_params)
      flash[:success] = t('messages.updated', model: @sample.class.model_name.human)
      redirect_to [:admin, @sample]
    else      
      render :edit
    end
  end

  def destroy
    authorize @sample
    @sample.destroy
    flash[:success] = t('messages.deleted', model: @sample.class.model_name.human)
    redirect_to admin_samples_path
  end

  private
    # Uses callbacks to share common setup or constraints between actions
    def set_sample
      @sample = Sample.find(params[:id])
    end

    # Removes images, selected during Editing
    def remove_images
      @sample.cover_image.purge if sample_params[:remove_cover_image] == '1'
      image_to_remove_ids = params['image_to_remove_ids']
      if image_to_remove_ids.present?
        image_to_remove_ids.each do |image_to_remove_id|
          @sample.images.find(image_to_remove_id).purge
        end
      end
    end
  
    # Only allows a trusted parameter 'white list' through
    def sample_params
      params.require(:sample).permit(:name, :title, :sku, :price, :description, :status, :content, :cover_image, :remove_cover_image, images: [])
    end
end
