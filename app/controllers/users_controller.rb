class UsersController < ApplicationController
    def index
        @users = User.includes(:profile).postable
    end
end
