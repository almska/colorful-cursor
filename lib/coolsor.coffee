class Coolsor
  activate: (state) ->
    wrap = (t) -> if t < 0 then 1 + t else if t > 1 then t % 1 else t
    HUEJUMP = 0.15420
    FPS = 24
    COOLRATE = (1 / FPS) * 1.666
    CYCLERATE = (1 / FPS) * 0.1
    PRESSFORCE = 0.314
    TIME = 0
    PRESS = 0
    setInterval(
      (() ->
        view = atom.views.getView( atom.workspace.getActiveTextEditor() )
        if view?
          PRESS = Math.max(PRESS - COOLRATE, 0) if PRESS > 0
          TIME = wrap(TIME + CYCLERATE + 0.1 * PRESS)
          c = "hsla(#{TIME * 360}, #{60 + 20 * PRESS}%, #{50 + 10 * PRESS}%, #{1 - PRESS * 0.3})"
          t = wrap (TIME - 0.2)
          s = "hsl(#{t * 360}, #{100}%, #{50 + 50 * PRESS}%)"
          cs = view.querySelector('.cursors .cursor')
          if cs?
            cs.style.borderColor = c
            cs.style.boxShadow = "-4px 0 10px -1px " + s
            cs.style.borderLeftWidth = "#{2 +  6 * PRESS}px"
          view.onkeydown = (e) ->
            TIME = wrap(TIME + HUEJUMP)
            PRESS = Math.min(1, PRESS + PRESSFORCE)
      ), (1000 / FPS)
    )
module.exports = new Coolsor()
