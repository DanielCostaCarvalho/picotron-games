vector3d = {
  x = nil,
  y = nil,
  z = nil,

  new = function(self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
  end,

  -- add = function(self, vector)
  --   self.x += vector.x
  --   self.y += vector.y
  -- end,
  -- sub = function(self, vector)
  --   self.x -= vector.x
  --   self.y -= vector.y
  -- end,
  scale = function(self, scale)
    self.x *= scale
    self.y *= scale
    self.z *= scale
  end,
  cross = function(self, vector)
    return vector3d:new({
      x = self.y * vector.z - self.z * vector.y,
      y = self.z * vector.x - self.x * vector.z,
      z = self.x * vector.y - self.y * vector.x,
    })
  end
}
