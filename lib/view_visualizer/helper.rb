module ViewVisualizer

  class Helper

    def self.config(key)
      {
        :render_regex => /<%=\s*render.*%>/,
        :render_partial_regex => /:partial\s*=>\s*(?:\"|\')(.+)(?:\"|\')(?:,|\s*%>)/,
        :render_full_regex => /render\s*(?:\"|\')(.+)(?:\"|\')(?:,|\s*%>)/,
        :directories => ["app/views"],
        :file_exensions => ["html.erb", "html"]
      }[key.to_sym]
    end

  end

end