class ProfileController < ApplicationController
    before_action :verify_own_profile!, except: %i[show mine]

    class NotOwnAccountException < StandardError; end

    rescue_from NotOwnAccountException, with: :user_not_authorized

    def show
        @profile = User.find_by_username(params[:username]).profile
    end

    def mine
        @profile = current_user.profile

        render :show
    end

    def edit
        @profile = User.find_by_username(params[:username]).profile
    end

    def update
        @profile = User.find_by_username(params[:username]).profile

        if @profile.update(profile_params)
            redirect_to my_profile_path
        else
            render :edit
        end
    end

    private

    def user_not_authorized
        flash[:error] = "You don't have access to this section."
        redirect_to root_path
    end

    def verify_own_profile!
        raise NotOwnAccountException unless current_user == User.find_by_username(params[:username])
    end

    def profile_params
        params.require(:profile).permit(:about_me)
    end
end
