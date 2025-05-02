include 'vector2d.lua'

position = vector2d:new({ x = 1, y = 0 })
position:scale(50)
velocity = vector2d:new({ x = 3, y = 0 })
gravity = vector2d:new({ x = 0, y = 1 })

function _update()
  velocity:add(gravity)
  position:add(velocity)
end

function _draw()
  cls()
  circfill(position.x, position.y, 1)
end
