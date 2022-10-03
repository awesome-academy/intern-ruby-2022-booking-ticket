class Admin::UsersController < AdminController
  before_action :find_user, except: %i(index)
  before_action :admin_filter, only: %i(update destroy)

  def index
    @pagy, @users = pagy User.sort_list,
                         items: Settings.digits.admin_movie_per_page
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "changed"
      redirect_to admin_user_path(id: @user.id)
    else
      flash[:error] = t "not_changed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "deleted"
      redirect_to request.referer || admin_users_path
    else
      flash[:error] = t "not_deleted"
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t "not_found_user"
    redirect_to admin_users_path
  end

  def admin_filter
    return unless @user.admin

    flash[:error] = t "not_change_admin"
    redirect_to admin_users_path
  end
end