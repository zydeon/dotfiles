import sublime, sublime_plugin
import operator as op

class CountWordsCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        v = self.view
        wc = reduce(op.add, map(lambda s:len(s.split()), map(v.substr, v.sel())))
        sublime.message_dialog(str(wc) + " words")

