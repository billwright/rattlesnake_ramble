class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # If an old friendly id or a numeric id was used to find the record, then
  # the request id will not match the current friendly id, and we should do
  # a 301 redirect that uses the current friendly id.
  def friendly_redirect(resource, id_param)
    if request.request_method_symbol == :get && resource.friendly_id != id_param
      redirect_to request.params.merge(id: resource.friendly_id), status: :moved_permanently
    end
  end
end
