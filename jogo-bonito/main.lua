game = {
  score = {
    a = 0,
    b = 0,
  },
}

ball = {
  x = 248,
  y = 255,
  hitbox_x = 246,
  hitbox_y = 253,
  hitbox_size = 4,
  speed = 0,
  acceleretion = 0,
  size = 2,

  moving_x = 0,
  moving_y = 0,
}

function ball:draw()
  circfill(self.x, self.y, self.size, 7)
  circ(self.x, self.y, self.size, 6)
end

function ball:move()
  if self.moving_x then
    self.x += self.moving_x * self.speed
    self.hitbox_x += self.moving_x * self.speed
  end
  if self.moving_y then
    self.y += self.moving_y * self.speed
    self.hitbox_y += self.moving_y * self.speed
  end

  self.speed += self.acceleretion

  if self.speed <= 0 then
    self.speed = 0
    self.acceleretion = 0
  end

  self.speed += self.acceleretion
end

function ball:kick(x, y, z, speed, acceleretion)
  self.moving_x = x
  self.moving_y = y
  self.speed = speed
  self.acceleretion = acceleretion or -0.5
end

camera_x = ball.x - 240
camera_y = ball.y - 120

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

  if
      (ball.hitbox_x >= self.shoot_x and ball.hitbox_x <= self.shoot_x + self.shoot_size)
      or (
        ball.hitbox_x + ball.hitbox_size >= self.shoot_x
        and ball.hitbox_x + ball.hitbox_size <= self.shoot_x + self.shoot_size
      )
  then
    is_x = true
  end

  if
      (ball.hitbox_y >= self.shoot_y and ball.hitbox_y <= self.shoot_y + self.shoot_size)
      or (
        ball.hitbox_y + ball.hitbox_size >= self.shoot_y
        and ball.hitbox_y + ball.hitbox_size <= self.shoot_y + self.shoot_size
      )
  then
    is_y = true
  end

  return is_x and is_y
end

function Player:touchedBall()
  local is_x = false
  local is_y = false

  if
      (ball.hitbox_x >= self.hitbox_x and ball.hitbox_x <= self.hitbox_x + self.hitbox_size)
      or (
        ball.hitbox_x + ball.hitbox_size >= self.hitbox_x
        and ball.hitbox_x + ball.hitbox_size <= self.hitbox_x + self.hitbox_size
      )
  then
    is_x = true
  end

  if
      (ball.hitbox_y >= self.hitbox_y and ball.hitbox_y <= self.hitbox_y + self.hitbox_size)
      or (
        ball.hitbox_y + ball.hitbox_size >= self.hitbox_y
        and ball.hitbox_y + ball.hitbox_size <= self.hitbox_y + self.hitbox_size
      )
  then
    is_y = true
  end

  return is_x and is_y
end

function Player:move()
  local moviment = { left = btn(0), right = btn(1), up = btn(2), down = btn(3) }
  local waiting = true
  local hypotenuse = false

  local speed = self.speed
  local x = 0
  local y = 0

  for _, value in pairs(moviment) do
    if value then
      if not waiting then
        hypotenuse = true
      end
      waiting = false
    end
  end

  if hypotenuse then
    speed *= 0.7
  end

  if btn(0) then
    x -= speed
    self.direction = 0
  end
  if btn(1) then
    x += speed
    self.direction = 1
  end
  if btn(2) then
    y -= speed
    self.direction = 2
  end
  if btn(3) then
    y += speed
    self.direction = 3
  end

  self.position += 0.15

  if waiting then
    self.position = 5
  end

  if self.position >= 5 then
    self.position = 1
  end

  local moving_x = 0
  local moving_y = 0

  if x < 0 then
    moving_x = -1
  end
  if x > 0 then
    moving_x = 1
  end

  if y < 0 then
    moving_y = -1
  end
  if y > 0 then
    moving_y = 1
  end

  if btn(5) and self:canShoot() then
    ball:kick(moving_x, moving_y, 0, 10)
  end

  if self.y + y < 76 then
    y = 0
  end
  if self.y + y > 404 then
    y = 0
  end

  if self.x + x < 114 then
    x = 0
  end
  if self.x + x > 368 then
    x = 0
  end

  self.y += y
  self.x += x
  self.hitbox_y += y
  self.hitbox_x += x
  self.shoot_y += y
  self.shoot_x += x

  if self:touchedBall() then
    ball:kick(moving_x, moving_y, 0, 5)
  end
end

function Player:draw()
  sprites = {
    {
      { sprite = 12, flip = true },
      { sprite = 13, flip = true },
      { sprite = 12, flip = true },
      { sprite = 14, flip = true },
    },
    {
      { sprite = 12, flip = false },
      { sprite = 13, flip = false },
      { sprite = 12, flip = false },
      { sprite = 14, flip = false },
    },
    {
      { sprite = 9,  flip = false },
      { sprite = 10, flip = false },
      { sprite = 9,  flip = false },
      { sprite = 10, flip = true },
    },
    {
      { sprite = 1,  flip = false },
      { sprite = 11, flip = false },
      { sprite = 1,  flip = false },
      { sprite = 11, flip = true },
    },
  }
  sprite_info = sprites[self.direction + 1][flr(self.position)]
  spr(sprite_info.sprite, self.x, self.y, sprite_info.flip)
end

function _init()
  vid(0) --480x270
  -- vid(3) --240x135
end

function _update()
  Player:move()
  ball:move()
end

function _draw()
  cls()
  layers = fetch("/ram/cart/map/0.map")
  map(layers[5].bmp)
  map(layers[4].bmp)
  map(layers[3].bmp)
  map(layers[2].bmp)

  local diff_x = ball.x - 240 - camera_x
  local diff_y = ball.y - 120 - camera_y

  local move = 1

  if diff_x != 0 and diff_y != 0 then
    move = 0.7
  end

  if diff_x < 0 then
    camera_x += (diff_x < -1 * move and -1 * move or diff_x)
  end

  if diff_x > 0 then
    camera_x += (diff_x > 1 * move and 1 * move or diff_x)
  end

  if diff_y < 0 then
    camera_y += (diff_y < -1 * move and -1 * move or diff_y)
  end

  if diff_y > 0 then
    camera_y += (diff_y > 1 * move and 1 * move or diff_y)
  end

  if camera_x < 0 then
    camera_x = 0
  end
  if camera_x + 480 > 512 then
    camera_x = 512 - 480
  end

  if camera_y < 0 then
    camera_y = 0
  end
  if camera_y + 270 > 512 then
    camera_y = 512 - 270
  end

  camera(camera_x, camera_y)
  print("Framengo " .. game.score.a .. "x" .. game.score.b .. " Cortinas", camera_x, camera_y, 0)
  ball:draw()
  Player:draw()
  map()
end
