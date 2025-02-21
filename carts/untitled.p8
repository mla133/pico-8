pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
point1={}
point1.x=64
point1.y=64
point1.a=90
point1.s=2

point2={}
point2.x=64
point2.y=64
point2.a=270
point2.s=2

point3={}
point3.x=64
point3.y=64
point3.a=180
point3.s=2

point4={}
point4.x=64
point4.y=64
point4.a=0
point4.s=2

point5={}
point5.x=64
point5.y=64
point5.a=0
point5.s=2

function _update()
  point1=animate(point1)
  point2=animate(point2)
  point3=animate(point3)
  point4=animate(point4)
  point5=animate(point5)
end

function animate(point)
  angleoffset=((point.a)%360)/360

  point.x=point.x+point.s*cos(angleoffset)
  point.y=point.y+point.s*sin(angleoffset)
  --collision detection
  if point.x>128 then
    point.a=135+flr(rand(90))
  end
  if point.x<0 then
    point.a=45-flr(rand(90))
  end
  if point.y>128 then
    point.a=45-flr(rand(90))
  end
  if point.y<0 then
    point.a=225+flr(rnd(90))
  end

  return point
end

function _draw()
  rectfill(0,0,127,127,0)

  --main prism
  line(point1.x,point1.y, point3.x, point3.y,8)
  line(point2.x,point2.y, point4.x, point4.y,8)
  line(point3.x,point3.y, point5.x, point5.y,8)
  line(point4.x,point4.y, point1.x, point1.y,8)
  line(point5.x,point5.y, point2.x, point2.y,8)

  --red lines
  line(point1.x,point1.y, point2.x, point2.y,8)
  line(point2.x,point2.y, point3.x, point3.y,8)
  line(point3.x,point3.y, point5.x, point5.y,8)
  line(point4.x,point4.y, point1.x, point1.y,8)
  line(point5.x,point5.y, point1.x, point1.y,8)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
