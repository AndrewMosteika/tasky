class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  after_action :verify_pundit_authorization

  rescue_from Pundit::NotAuthorizedError, with :not_authorized

  private

  def verify_pundit_authorization
    if action_name == "index"
      verify_policy_scoped
    else
      verify_authorized
    end
  end

  def pundit_user
    Current.user
  end

  def not_authorized
    redirect_back_or_to root_path, alert: "You're not allowed to do that."
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
