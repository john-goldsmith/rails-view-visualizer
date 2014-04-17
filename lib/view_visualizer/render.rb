module ViewVisualizer

  class Render

    # render "..."
    # render("...")
    # render partial: "..."
    # render(partial: "...")
    # render :partial => "..."
    # render(:partial => "...")
    # render(:partial=>"...")

    # Locals?
    # Controller rendering?

    RENDER_REGEX = /render/
    RENDER_PARTIAL_REGEX = /partial/
    DIRECTORIES = ["app/views"]
    FILE_EXTENSIONS = ["html.erb", "html", "html.slim", "html.haml"]

    def initialize
    end

  end

end