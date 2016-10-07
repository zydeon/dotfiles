import sublime, sublime_plugin

class InsertSpacesCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    view = self.view
    for r in view.sel():
      self.view.replace(edit, r, ' '*r.size())
