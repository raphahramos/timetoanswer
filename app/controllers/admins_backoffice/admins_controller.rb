class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :password_verify, only: [:update]
  before_action :set_admin, only: [:update, :edit, :destroy]
  def index
    @admins = Admin.all.page(params[:page])
  end
  def edit 
  end
  def update
    if @admin.update(params_admin)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to admins_backoffice_admins_path, notice: "Administrador Atualizado!"
      else
        render :edit
    end
  end
  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador Cadastrado!"
      else
        render :new
   end
  end
  def new
    @admin = Admin.new
  end
  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador Exluido!"
      else
        render :index
    end
  end
private
  def password_verify
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank? && 
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
  def set_admin
    @admin = Admin.find(params[:id])
  end
  def params_admin
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
