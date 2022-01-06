class Users::InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters
    before_action :verify_invites_available, only: %i[new]

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :password, :password_confirmation, :invitation_token])
    end

    def verify_invites_available
      raise ActionController::RoutingError.new('Not Found') unless current_user.has_invites_available?
    end
end
