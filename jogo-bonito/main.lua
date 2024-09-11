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
	direction = 0,
	position = 1,
}

function Jogador:move()
	movimento = false
	if btn(0) then
		movimento = true
		self.x -= self.speed
		self.direction = 0
	end
	if btn(1) then
		movimento = true
		self.x += self.speed
		self.direction = 1
	end
	if btn(2) then
		movimento = true
		self.y -= self.speed
		self.direction = 2
	end
	if btn(3) then
		movimento = true
		self.y += self.speed
		self.direction = 3
	end

	self.position += 0.15

	if not movimento then
		self.position = 5
	end

	if self.position >= 5 then
		self.position = 1
	end
end

function Jogador:draw()
	sprites = {
		{ { 12, true }, { 13, true }, { 12, true }, { 14, true } },
		{ { 12, false }, { 13, false }, { 12, false }, { 14, false } },
		{ { 9, false }, { 10, false }, { 9, false }, { 10, true } },
		{ { 1, false }, { 11, false }, { 1, false }, { 11, true } },
	}
	sprite_info = sprites[self.direction + 1][flr(self.position)]
	circ(self.x + 7, self.y + 15, 5, 28)
	spr(sprite_info[1], self.x, self.y, sprite_info[2])
end

function _init()
	vid(3) --240x135
end

function _update()
	Jogador:move()
end

function _draw()
	cls()
	layers = fetch("/ram/cart/map/0.map")
	map(layers[3].bmp)
	map(layers[2].bmp)
	camera_x = Jogador.x - 120
	camera_y = Jogador.y - 50
	camera(camera_x, camera_y)
	print("Framengo " .. game.score.a .. "x" .. game.score.b .. " Cortinas", camera_x, camera_y, 7)
	bola:draw()
	Jogador:draw()
	map()
end
