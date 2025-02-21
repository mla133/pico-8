pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--cave diver tutorial
--by matt allen
function _init()
  game_over=false
  make_cave()
  make_player()
end

function _update()
 if (not game_over) then
  update_cave()
  move_player()
  check_hit()
 else
  if (btnp(5)) _init() --restart
 end
end

function _draw()
  cls()
  draw_cave()
  draw_player()
  
  if (game_over) then
    print("game over!",44,44,7)
    print("your score:"..player.score,34,54,7)
    print("press x to play again!",18,72,6)
  else
    print("score:"..player.score,2,2,7)
  end
end
-->8
function make_player()
  player={}
  player.x=24    --position
  player.y=60
  player.dy=0    --fall speed
  player.rise=1  --sprites
  player.fall=2
  player.dead=3
  player.speed=2 --fly speed
  player.score=0
end

function draw_player()
  if (game_over) then
    spr(player.dead,player.x, player.y)
  elseif (player.dy<0) then
    spr(player.rise,player.x, player.y)
  else
    spr(player.fall, player.x, player.y)
  end
end

function move_player()
  gravity=0.2   --bigger means more gravity!
  player.dy += gravity --add gravity
  
  --jump
  if (btnp(2)) then
    player.dy-=5
    sfx(0)
  end
  
  --move to new position
  player.y+=player.dy
  
  --update score
  player.score+=player.speed
end

function check_hit()
  for i=player.x,player.x+7 do
    if (cave[i+1].top>player.y
     or cave[i+1].btm<player.y+7) then
     game_over=true
     sfx(1)
    end
  end
end
-->8
function make_cave()
  cave={{["top"]=5,["btm"]=119}}
  top=45 --how low can the ceiling go?
  btm=85 --how high can the floor get?
end

function update_cave()
  --remove the back of the cave
  if (#cave>player.speed) then
    for i=1,player.speed do
      del(cave,cave[1])
    end
  end
  
  --add more cave
  while(#cave<128) do
    local col={}
    local up=flr(rnd(7)-3)
    local dwn=flr(rnd(7)-3)
    col.top=mid(3,cave[#cave].top+up,top)
    col.btm=mid(btm,cave[#cave].btm+dwn,124)
    add(cave,col)
  end
end

function draw_cave()
  top_color=5 --play with these!
  btm_color=12 --choose your own colors
  for i=1, #cave do
    line(i-1,0,i-1,cave[i].top,top_color)
    line(i-1,150,i-1,cave[i].btm,btm_color)
  end
end
__gfx__
00000000000000000000000000808800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000090000000000000000a889880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070004000000040000008898a988000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000044cc000044cc0008880a880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700094444440044444409a099889000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700040000000400000088980988000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000090000000000000000089a880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55577557755775777577755555775577757775555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55755575557575757575555755575555755575555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55777575557575775577555555575577757775555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55557575557575757575555755575070007555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55775557757755757577755555777077707775555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555000005055555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555550000000055555505555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555550000000050505500555555555555555555555555555555555555555555555555555555555555555555555555555555555555
05555555555555555555555555000000000000000500555555555555555555555555555555555555555555555555555555555555555555555555555555555555
00555555555555555550055555000000000000000000555555555500550055555055555555555555555555555555555555555555555555555555555555555555
00555555555555555500055550000000000000000000055555055500000050555055555555555555555555555555555555555555555555555555555555555555
00555555555555555500005550000000000000000000055555050500000050555055555555555555555555555555555555555555555555555555555555555555
00000055055555555500005500000000000000000000005555000000000000550005555555555555555555555555555555555555555555555555555555555555
00000055055555555000000500000000000000000000005550000000000000000005555555555555555555555555555555555555555555555555555555555555
00000050005555505000000500000000000000000000005500000000000000000000505555555555555555555555555555555555555505555555555555555555
00000000005555000000000000000000000000000000000500000000000000000000505555555555555555555555555555555505505500555555555555555555
00000000005555000000000000000000000000000000000000000000000000000000005055555555555555555555555555555505005000555555055555555555
00000000000050000000000000000000000000000000000000000000000000000000000055555555555555555555555555555505000000055555005555555555
00000000000050000000000000000000000000000000000000000000000000000000000055555555555555555555555555555000000000005005000505055555
00000000000050000000000000000000000000000000000000000000000000000000000000555055555555055555555555555000000000000000000500005055
00000000000000000000000000000000000000000000000000000000000000000000000000555050055005055555555555555000000000000000000500000055
00000000000000000000000000000000000000000000000000000000000000000000000000555000050005055555555555550000000000000000000000000055
00000000000000000000000000000000000000000000000000000000000000000000000000000000050000005505555555500000000000000000000000000005
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005505555555000000000000000000000000000005
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005505555555000000000000000000000000000005
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555550000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000009999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099099099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099900999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000009900990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c000ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000ccc0ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ccccccccccc0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccc000
00ccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccc
0ccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccccccc
cccccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccccccc
cccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccccccccc
ccccccccccccccccc000cc0c000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000cc0ccccccccc
cccccccccccccccccc00cccc0c000000000000000000000000000000000000000000000000000000000000000000000000000c00000cc0000000cc0ccccccccc
cccccccccccccccccc0ccccc0c000000000000000000000000000000000000c0cc00000000000000000000000000000000000c00c00cc0c00000cccccccccccc
cccccccccccccccccc0cccccccc00000000000000000000000000000000000c0cc000000000000c000000000000000000000ccc0cc0cccc00c0ccccccccccccc
ccccccccccccccccccccccccccc000c0c00000000000000000000000000000cccc0c000000000cc0000000c0000000000cc0cccccccccccccc0ccccccccccccc
ccccccccccccccccccccccccccc0ccccc0000000000000000000000000000cccccccc00000000cc000000cc000000000ccc0cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc0000000000000000000000000c0cccccccc00000000ccc00000ccc00000000cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc000c000000000000000000000c0cccccccc0c00000cccccc000ccc00000000cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc0cc00000000000000000000cccccccccccc00000ccccccc0cccccc00000ccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccc0000000000000c0000cccccccccccccc0000ccccccc0cccccc00cccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccc000c0000000c0c0c00cccccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccc00ccc00c000ccc0c00cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccc0ccc00c00cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccc0cccccc00cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

__sfx__
00010000190501d050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d0500000026050000001f050000000805008050080500805008050080500805008050080500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
