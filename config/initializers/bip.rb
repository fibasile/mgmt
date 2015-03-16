module BestInPlace
  module ControllerExtensions
    def respond_bip_ok(obj, options = {})
      param_key = options[:param] ||= BestInPlace::Utils.object_to_key(obj)
      updating_attr = params[param_key].keys.first
      renderer = BestInPlace::DisplayMethods.lookup(obj.class, updating_attr)
      return render json: renderer.render_json(obj)
    end
  end
end
