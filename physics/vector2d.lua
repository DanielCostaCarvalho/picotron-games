vector2d = {
  x = nil,
  y = nil,
  new = function(self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
  end,
  add = function(self, vector)
    self.x += vector.x
    self.y += vector.y
  end,
  sub = function(self, vector)
    self.x -= vector.x
    self.y -= vector.y
  end,
  scale = function(self, scale)
    self.x *= scale
    self.y *= scale
  end,
  dot = function(self, vector)
    return self.x * vector.x + self.y * vector.y
  end,
  perpendicular = function(self)
    return vector2d:new({
      x = self.y,
      y = -self.x,
    })
  end,
  mag = function(self)
    return sqrt((self.x * self.x) + (self.y * self.y))
  end,
  normalize = function(self)
    mag = self.mag()
    self.x /= mag
    self.y /= mag
  end,
}
