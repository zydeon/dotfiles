import sublime, sublime_plugin

class Styles:
  italic    = staticmethod(lambda text : '\\textit{'+ text +'}')
  bold      = staticmethod(lambda text : '\\textbf{'+ text +'}')
  underline = staticmethod(lambda text : '\\underline{'+ text +'}')
  large     = staticmethod(lambda text : '{\\large '+ text +'}')
  text      = staticmethod(lambda text : '\\text{'+ text +'}')
  math      = staticmethod(lambda text : '$'+ text +'$')
  emph      = staticmethod(lambda text : '\\emph{'+ text +'}')

def style_regions(view, edit, style):
  syntax = view.settings().get('syntax').lower()
  for r in view.sel():
    if "latex" in syntax:
      view.replace(edit, r, style(view.substr(r)))

class ToItalicCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.italic)

class ToBoldCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.bold)

class ToUnderlineCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.underline)

class ToTextCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.text)

class ToMathCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.math)

class ToEmphCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    style_regions(self.view, edit, Styles.emph)
