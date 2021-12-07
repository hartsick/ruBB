module ProfileHelper
    def my_profile?
        current_user == @profile.user
    end
end
