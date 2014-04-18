Rails View Visualizer
===

Overview
---
A tool to help visualize the view structure of a Rails app.

Usage
---
To use Rails View Visualizer, run `rvv start`, or simply `rvv`.

Options:

    -d, --outputdir       Specify the output directory. Defaults to doc/view_visualizer/
    -f, --outputfile      Specify the output filename. Defaults to view_visualizer.html
    -i, --inputdir        Specify the Rails view directory. Defaults to app/views/
    -e, --extension       Specify the file extension to search. Defaults to *.html.*

Known Bugs
---

Todo
---
* Parse controllers for implicit and explicit rendering
* Parse "magic" renders, i.e. render @users
* Parse layouts directory
* Check for the existence of the view being rendered
* Account for dynamic view paths
* Account for local variables passed to render method
* Check for rendering loops (X renders Y which renders X)

# render "path/to/view"
# render("path/to/view")
# render :partial => "path/to/view"
# render(:partial => "path/to/view")
# render partial: "path/to/view"
# render(partial: "path/to/view")