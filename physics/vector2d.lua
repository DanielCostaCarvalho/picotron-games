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
}
