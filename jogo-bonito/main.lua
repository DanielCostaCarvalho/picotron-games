game = {
  score = {
    a = 0,
    b = 0,
  },
}

ball = {
  x = 240,
  y = 240,
  hitbox_x = 238,
  hitbox_y = 238,
  hitbox_size = 4,
  speed = 5,
  size = 2,
}

function ball:draw()
  circfill(self.x, self.y, self.size, 7)
  circ(self.x, self.y, self.size, 6)
end

function ball:move(x, y, z)
  self.x += x
  self.y += y
  self.hitbox_x += x
  self.hitbox_y += y
end

Player = {
  x = 240,
  y = 240,
  shoot_size = 9,
  shoot_x = 240 + 3,
  shoot_y = 240 + 10,
  hitbox_size = 5,
  hitbox_x = 240 + 5,
  hitbox_y = 240 + 12,
  speed = 1,
  direction = 0,
  position = 1,
}

function Player:canShoot()
  local is_x = false
  local is_y = false

  if (ball.hitbox_x >= self.shoot_x and ball.hitbox_x <= self.shoot_x + self.shoot_size) or (ball.hitbox_x + ball.hitbox_size >= self.shoot_x and ball.hitbox_x + ball.hitbox_size <= self.shoot_x + self.shoot_size) then
    is_x = true
  end

  if (ball.hitbox_y >= self.shoot_y and ball.hitbox_y <= self.shoot_y + self.shoot_size) or (ball.hitbox_y + ball.hitbox_size >= self.shoot_y and ball.hitbox_y + ball.hitbox_size <= self.shoot_y + self.shoot_size) then
    is_y = true
  end

  return is_x and is_y
end

function Player:hasBall()
  local is_x = false
  local is_y = false

  if (ball.hitbox_x >= self.hitbox_x and ball.hitbox_x <= self.hitbox_x + self.hitbox_size) or (ball.hitbox_x + ball.hitbox_size >= self.hitbox_x and ball.hitbox_x + ball.hitbox_size <= self.hitbox_x + self.hitbox_size) then
    is_x = true
  end

  if (ball.hitbox_y >= self.hitbox_y and ball.hitbox_y <= self.hitbox_y + self.hitbox_size) or (ball.hitbox_y + ball.hitbox_size >= self.hitbox_y and ball.hitbox_y + ball.hitbox_size <= self.hitbox_y + self.hitbox_size) then
    is_y = true
  end

  return is_x and is_y
end

function Player:move()
  local movimento = false

  local speed = self.speed
  local x = 0
  local y = 0

  if btn(0) then
    movimento = true
    x -= speed
    self.direction = 0
  end
  if btn(1) then
    movimento = true
    x += speed
    self.direction = 1
  end
  if btn(2) then
    movimento = true
    y -= speed
    self.direction = 2
  end
  if btn(3) then
    movimento = true
    y += speed
    self.direction = 3
  end

  self.position += 0.15

  if not movimento then
    self.position = 5
  end

  if self.position >= 5 then
    self.position = 1
  end

  if btn(5) and self:canShoot() then
    ball:move(x * 10, y * 10, 0)
  end

  self.y += y
  self.x += x
  self.hitbox_y += y
  self.hitbox_x += x
  self.shoot_y += y
  self.shoot_x += x

  if self:hasBall() then
    ball:move(x, y, 0)
  end
end

function Player:draw()
  sprites = {
    { { 12, true },  { 13, true },  { 12, true },  { 14, true } },
    { { 12, false }, { 13, false }, { 12, false }, { 14, false } },
    { { 9, false },  { 10, false }, { 9, false },  { 10, true } },
    { { 1, false },  { 11, false }, { 1, false },  { 11, true } },
  }
  sprite_info = sprites[self.direction + 1][flr(self.position)]
  rect(self.hitbox_x, self.hitbox_y, self.hitbox_x + self.hitbox_size, self.hitbox_y + self.hitbox_size, 10)
  rect(self.shoot_x, self.shoot_y, self.shoot_x + self.shoot_size, self.shoot_y + self.shoot_size, 2)
  spr(sprite_info[1], self.x, self.y, sprite_info[2])
end

function _init()
  vid(3) --240x135
end

function _update()
  Player:move()
end

function _draw()
  cls()
  layers = fetch("/ram/cart/map/0.map")
  map(layers[3].bmp)
  map(layers[2].bmp)
  camera_x = Player.x - 120
  camera_y = Player.y - 50
  camera(camera_x, camera_y)
  print("Framengo " .. game.score.a .. "x" .. game.score.b .. " Cortinas", camera_x, camera_y, 0)
  ball:draw()
  Player:draw()
  map()
end
