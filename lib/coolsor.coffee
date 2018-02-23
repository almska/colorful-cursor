class Coolsor
  activate: (state) ->
    HUEJUMP = 0.15420
    FPS = 24
    COOLRATE = (1 / FPS) * 1.666
    CYCLERATE = (1 / FPS) * 0.1
    PRESSFORCE = 0.314

    TIME = 0
    PRESS = 0
    atom.config.coolsor = {time : 0, press : 0}
    config = atom.config.coolsor
    wrap = (t) -> t - Math.floor t
    setInterval(
      (() ->
        view = atom.views.getView( atom.workspace.getActiveTextEditor() )
        if view?
          config.press = Math.max(config.press - COOLRATE, 0) if config.press > 0
          config.time = wrap(config.time + CYCLERATE + 0.1 * config.press)
          c = "hsla(#{config.time * 360}, #{60 + 20 * config.press}%, #{50 + 10 * config.press}%, #{1 - config.press * 0.3})"
          t = wrap (config.time + 0.5)
          s = "hsl(#{t * 360}, #{100}%, #{50 + 50 * config.press}%)"
          cs = view.querySelector('.cursors .cursor')
          if cs?
            cs.style.borderColor = c
            cs.style.boxShadow = "-4px 0 10px -1px " + s
            cs.style.borderLeftWidth = "#{2 +  6 * config.press}px"
          view.onkeydown = (e) ->
            config.time = wrap(config.time + HUEJUMP)
            config.press = Math.min(1, config.press + PRESSFORCE)
      ), (1000 / FPS)
    )
module.exports = new Coolsor()
