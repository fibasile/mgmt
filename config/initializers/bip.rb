module BestInPlace
  module ControllerExtensions
    def respond_bip_ok(obj, options = {})
      if params[:grade] and params[:grade][:value]
        render json: {display_as: obj.to_s}.to_json#renderer.render_json(obj)
      else
        head :no_content
      end
    end
  end
end
