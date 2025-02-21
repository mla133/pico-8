p1 = {}
p1.x = 64
p1.x = 64
p1.y = 64
p1.dir = 1

function _init()
	cls()
end

function _update()
	if (p1.dir == 1) then p1.y = p1.y-1 end
	if (p1.dir == 2) then p1.x = p1.x+1 end
	if (p1.dir == 3) then p1.y = p1.y+1 end
	if (p1.dir == 4) then p1.x = p1.x-1 end

	if (btnp(0)) then p1.dir = p1.dir - 1 end
	if (btnp(1)) then p1.dir = p1.dir + 1 end

	if (p1.dir > 4) then p1.dir = 1
	if (p1.dir < 1) then p1.dir = 4
end

function _draw()
	pset(p1.x, p1.y, 12)
end
