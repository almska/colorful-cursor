class ColorfulCursor
  activate: (state) ->
    atom.config.coolsor = {}
    atom.config.coolsor.time = 0
    console.log atom.config

    setInterval ->
      wrap = (t) -> t - Math.floor t
      rainbow = (t, s = 60) -> "hsl(#{t * 360}, #{s}%, 50%)"
      textEditor = atom.workspace.getActiveTextEditor()
      view = atom.views.getView(textEditor)
      if view?

        atom.config.coolsor.time = wrap(atom.config.coolsor.time + 0.001)
        c = rainbow atom.config.coolsor.time
        s = rainbow (wrap (atom.config.coolsor.time - 0.1), 100)
        cs = view.querySelector('.cursors .cursor')
        if cs?
          cs.style.borderColor = c
          cs.style.boxShadow = "-4px 0 10px -1px " + s 
        view.onkeydown = (e) ->
          atom.config.coolsor.time = wrap(atom.config.coolsor.time + 0.42)

module.exports = new ColorfulCursor()
