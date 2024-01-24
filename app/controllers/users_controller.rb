class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def create
    @user = User.create!(user_params)
    @user.image.attach(params[:image])
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      render 'create.json.jbuilder', status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render 'update.json.jbuilder'
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render 'destroy.json.jbuilder'
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id].to_i)
  end

  def download_user_details
  	@user = User.find(params[:id])
    pdf_data = PdfGenerator.generate_user_pdf_data(@user)
    pdf_file_path = Rails.root.join('public', 'user_details.pdf')
    File.open(pdf_file_path, 'wb') { |file| file << pdf_data }
    pdf_url = request.base_url + '/user_details.pdf'
    render json: { pdf_url: pdf_url }
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :role_id, :image)
  end

  def not_found
    render json: { error: 'User not found' }, status: :not_found
  end
end
