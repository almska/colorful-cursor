class Coolsor
  activate: (state) ->
    HUEJUMP = 0.15420
    COOLRATE = 0.042
    CYCLERATE = 0.001
    PRESSFORCE = 0.314

    TIME = 0
    PRESS = 0
    # VIEW = null
    CURSOR = null
    wrap = (t) -> if t < 0 then 1 + t else if t > 1 then t % 1 else t

    changeView = (editor) ->
      if editor?
        VIEW = atom.views.getView editor
        CURSOR = VIEW.querySelector('.cursors .cursor')
        VIEW.onkeydown = (e) ->
          TIME = wrap(TIME + HUEJUMP)
          PRESS = Math.min(1, PRESS + PRESSFORCE)

    main = () ->
      if CURSOR?
        PRESS = Math.max(PRESS - COOLRATE, 0) if PRESS > 0
        TIME = wrap(TIME + CYCLERATE + 0.1 * PRESS)
        c = "hsla(#{TIME * 360}, #{60 + 20 * PRESS}%, #{50 + 10 * PRESS}%, #{1 - PRESS * 0.42})"
        t = wrap (TIME - 0.2)
        s = "hsl(#{t * 360}, #{100}%, #{50 + 50 * PRESS}%)"
        if CURSOR?
          CURSOR.style.borderColor = c
          CURSOR.style.boxShadow = "-4px 0 10px -1px " + s
          CURSOR.style.borderLeftWidth = "#{2 +  6 * PRESS}px" if PRESS > 0
      requestAnimationFrame main

    init = () ->
      atom.workspace.onDidChangeActivePaneItem changeView
      changeView atom.workspace.getActiveTextEditor()
      main()

    init()
module.exports = new Coolsor()
