module ViewVisualizer

  class Render

    public

      def self.config
        {
          :render_regex => /<%=\s*render.*%>/,
          :render_partial_regex => /:partial\s*=>\s*(?:\"|\')(.+)(?:\"|\')(?:,|\s*%>)/,
          :render_full_regex => /render\s*(?:\"|\')(.+)(?:\"|\')(?:,|\s*%>)/,
          :directories => ["app/views"],
          :file_exensions => ["html.erb", "html", "html.slim", "html.haml"]
        }
      end

      def self.visualize(view)
        @@parsed_views = []
        @@found_base_file = false

        results = self.find_and_parse_view(view)
        if !results.empty?
          results = [:path => view, :renders => results]
          self.display_output(results)
          return true
        elsif @@found_base_file
          puts "#{view} does not render any other views"
        else
          puts "Could not find a view for #{view}"
        end

      rescue SystemStackError
        puts "ERROR: You have a cycle in your view rendering."
        puts "For example, view A renders view B, which renders view A"
        puts

        show_last = 10
        puts "Here are the last #{show_last} views parsed:"
        for i in 1..show_last
          parsed_view_path = @@parsed_views[@@parsed_views.size - i]
          puts parsed_view_path if parsed_view_path
        end

        return false
      end

    private

      def self.display_output(results)
        display_text_tree(results)
      end

      def self.display_html(results)
        html_str = ""
        html_str << "<html><body>"
        html_str << display_html_inner(results)
        html_str << "</body></html>"

        puts html_str
      end

      def self.display_html_inner(results, depth = 0)
        html_str = ""
        html_str << "<ul>"

        results.each do |res|
          html_str << "<li>#{res[:path]}</li> "
          html_str << self.display_html_inner(res[:renders], depth + 1)
        end
        html_str << "</ul>"
      end

      def self.display_text_tree(results, depth = 0)
        results.each do |res|
          print ". " * depth
          puts res[:path]
          self.display_text_tree(res[:renders], depth + 1)
        end
      end

      def self.find_and_parse_view(view)
        self.config[:directories].each do |dir|
          self.config[:file_exensions].each do |ext|
            res = parse_view("#{dir}/#{view}.#{ext}")
            return res if !res.empty?
          end
        end

        []
      end

      def self.parse_view(view_path)
        return [] unless File.exists?(view_path)
        @@found_base_file = true
        @@parsed_views << view_path

        view_data = File.read(view_path)
        renders = self.parse_render_calls(view_data)
        results = []
        renders.each do |render_path|
          results << {:path => render_path, :renders => self.find_and_parse_view(render_path)}
        end

        results
      end

      def self.parse_render_calls(file_data)
        matches = file_data.scan(self.config[:render_regex])
        results = []

        matches.each do |render_call|
          file = render_call.match(self.config[:render_partial_regex])
          if file
            file_parts = file[1].split("/")
            file_parts[-1] = "_#{file_parts[-1]}"
            results << file_parts.join("/")
          else
            file = render_call.match(self.config[:render_full_regex])
            if file
              results << file[1]
            else
              puts "Could not find file for render call: #{render_call}"
            end
          end
        end

        return results
      end

  end

end