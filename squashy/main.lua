--[[pod_format="raw",created="2024-08-25 18:23:42",modified="2024-08-25 18:23:47",revision=1]]
window_info = {
	width = 270,
	height = 270,
}

game = {
	score = 0,
	life = 3,
}

paddle = {
	x = window_info.width / 2,
	y = window_info.height - 50,
	width = 24,
	height = 4,
	draw = function()
		rectfill(paddle.x, paddle.y, paddle.x + paddle.width, paddle.y + paddle.height)
	end,
	move = function()
		if btn(0) and paddle.x > 0 then
			paddle.x -= 3
		end
		if btn(1) and paddle.x + paddle.width < window_info.width then
			paddle.x += 3
		end
	end,
}

ball = {
	x = 64,
	y = 64,
	size = 3,
	xdirection = 2,
	ydirection = -1,
	draw = function()
		circfill(ball.x, ball.y, ball.size)
	end,
	move = function()
		if ball.y <= 0 then
			ball.ydirection = -ball.ydirection
			game.score += 1

			sfx(0)
		end

		if ball.y >= window_info.height then
			ball.y = 64
			game.life -= 1
			sfx(2)
		end

		if ball.x >= window_info.width or ball.x <= 0 then
			ball.xdirection = -ball.xdirection
			sfx(1)
		end

		if ball.x >= paddle.x and ball.x <= paddle.x + paddle.width and ball.y + ball.size == paddle.y then
			ball.ydirection = -ball.ydirection
			sfx(0)
		end

		ball.x += ball.xdirection
		ball.y += ball.ydirection
	end,
}

function _init()
	window({
		height = window_info.height,
		width = window_info.width,
		resizeable = false,
		title = "Squashy",
	})
end

function _update()
	paddle.move()
	ball.move()
end

function _draw()
	cls()
	print("Potuacao: " .. game.score)
	print("Vidas: " .. game.life)
	paddle.draw()
	ball.draw()
end
