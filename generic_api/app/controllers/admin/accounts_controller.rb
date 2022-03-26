class Admin::AccountsController < Admin::BaseController
  before_action :set_account, only: :show

  def index
    @accounts = policy_scope(Account)
  end

  def show
    authorize @account
  end

  private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:provider, :uid, :password, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :name, :nickname, :image, :email, :tokens)
    end
end
