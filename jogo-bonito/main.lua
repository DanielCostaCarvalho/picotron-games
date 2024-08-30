game = {
  score = {
    a = 0,
    b = 0,
  },
}

Jogador = {
  x = 100,
  y = 100,
  speed = 3
}

function Jogador:move()
  if btn(0) then
    self.x -= self.speed
  end
  if btn(1) then
    self.x += self.speed
  end
  if btn(2) then
    self.y -= self.speed
  end
  if btn(3) then
    self.y += self.speed
  end
end

function Jogador:draw()
  spr(1, self.x, self.y)
end

function _init()
  window({
    title = "Jogo Bonito",
  })
  palt(30, true)
  palt(0, false)
end

function _update()
  Jogador:move()
end

function _draw()
  cls()
  map()
  print("Framengo " .. game.score.a .. "x" .. game.score.b .. " Cortinas")
  Jogador:draw()
end
