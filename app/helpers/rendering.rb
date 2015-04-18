module AbstractController
  def render_with_flash(*args)
    flashes = args[:flash]
    flash.
  end
end