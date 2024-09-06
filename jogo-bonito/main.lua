game = {
  score = {
    a = 0,
    b = 0,
  },
}

bola = {
  x = 240,
  y = 240,
  speed = 3,
}

function bola:draw()
  circfill(self.x, self.y, 2, 7)
  circ(self.x, self.y, 2, 6)
end

Jogador = {
  x = 240,
  y = 240,
  speed = 3,
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
    width = 180,
    height = 180,
  })
end

function _update()
  Jogador:move()
end

function _draw()
  cls()
  layers = fetch("/ram/cart/map/0.map")
  map(layers[3].bmp)
  map(layers[2].bmp)
  camera_x = Jogador.x - 90
  camera_y = Jogador.y - 90
  camera(camera_x, camera_y)
  print("Framengo " .. game.score.a .. "x" .. game.score.b .. " Cortinas", camera_x, camera_y, 7)
  bola:draw()
  Jogador:draw()
  map()
end
