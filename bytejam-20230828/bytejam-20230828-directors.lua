-- Greetz:
-- Aldroid, Synesthesia
-- T^Bach, Alia, Totetmatt
-- Sofa Jam watchers!

T=0

-- The mouse button state on last TIC
-- (used for debouncing input)
MOUSE_LAST_B=false

-- Trifan polygons
-- (colour) ((x),(y),...)
TF={
-- jacket
	{c=9,p={116,83,44,102,32,138,206,138,197,105,116,83}},
-- shirt
	{c=13,p={117,83,86,90,95,137,152,137,146,91,117,83}},
-- shirt neck (for prison outfit)
	{c=10,p={117,95,117,86,102,86,86,90,87,95,117,103,146,95,144,90,131,85,117,85}},
-- tie
	{c=14,p={118,114,117,103,108,107,113,115,110,137,129,137,122,113,125,106,117,103}},
-- head
 {c=3,p={116,50,109,93,132,92,152,70,157,40,149,18,112,11,80,35,81,55,101,88,109,93}},
-- hair
	{c=4,p={98,24,118,38,144,39,157,34,159,22,136,15,115,8,84,14,78,39,92,40,97,24}},	
-- nose
	{c=4,p={118,60,119,52,123,52,123,61,125,65,117,65,116,59,118,52}},	
-- eye mask
	{c=5,p={118,47,117,51,105,52,91,49,92,42,105,41,118,46,127,42,144,42,147,48,142,52,125,53,117,51}},	
-- hair white streak
	{c=12,p={135,20,125,13,119,15,133,23,150,26,150,22,137,18}},	
-- right eye
	{c=12,p={137,49,143,46,132,46,129,52,139,52,145,48,142,46}},
-- right iris
	{c=0,p={136,49,136,46,132,48,135,51,135,51,138,49,136,46}},	
-- right eyebrow
	{c=4,p={134,44,130,47,128,44,139,42,140,45}},
-- left eye
	{c=12,p={105,48,110,47,104,44,98,45,96,48,105,50,109,50,110,47}},
-- left eyeball
	{c=0,p={104,47,104,45,102,48,104,49,106,48,105,45,103,44}},	
-- left eyebrow
	{c=4,p={111,46,112,42,100,40,100,43}},	
-- mouth
	{c=2,p={121,79,120,77,111,77,108,80,109,82,121,81,130,81,131,79,130,76,124,77,120,77}},
-- ear
	{c=2,p={85,49,84,46,84,53,86,54,85,49}},
}

-- A table for drawing the next polygon
SCRATCH={}

function setCol(c,r,g,b)
	poke(0x3fc0+c*3,r)
	poke(0x3fc0+c*3+1,g)
	poke(0x3fc0+c*3+2,b)
end

function TIC()
 local move=math.sin(T/20)
 local fade=(.5+math.cos(T/200-math.pi/8)*.5)^2

 vbank(0)
 cls()
 for i=1,#TF do
  drawTrifan(TF[i],i,-move*15*(1-fade))
 end

	drawScratch()

 local mx,my,lb,mb,rb,msx,msy=mouse()
 if lb and MOUSE_LAST_B==false then
  SCRATCH[#SCRATCH+1]=mx
  SCRATCH[#SCRATCH+1]=my
  
  local str=""
  for i=1,#SCRATCH do
   if i==1 then
    str=string.format("%d",SCRATCH[i])
   else
	   str=string.format("%s,%d",str,SCRATCH[i])
			end
  end
  str=string.format("{p=15,c={%s}}",str)
  trace(str)
 end
 MOUSE_LAST_B=lb

-- colour fades...
 setCol(5,255,150,93)
 r=0*fade+(1-fade)*200
 g=0*fade+(1-fade)*100
 b=120*fade
 setCol(9,r,g,b)
 r=255
 g=255
 b=255
 setCol(10,r,g,b)
 r=255*fade+(1-fade)*200
 g=255*fade+(1-fade)*100
 b=255*fade
 setCol(13,r,g,b)
 r=255*fade+(1-fade)*200
 g=0*fade+(1-fade)*100
 b=0*fade
 setCol(14,r,g,b)

-- Bars and hands (small)
 vbank(1)
 cls()
	if fade<.5 then
	 local xofs=20+move*15

	 for x=-20,240,40 do
	  rect(x+xofs,0,10,137,15)
	  rect(x+xofs+2,0,3,137,14)
	 end
	
	 elli(xofs+12,120,10,20,9)
	 elli(xofs+190,120,10,20,9)
	 elli(xofs+12,110,5,13,3)
	 elli(xofs+190,110,5,13,3)
	 for y=0,3 do
		 elli(xofs+20,100+y*6,12,2,3)
		 elli(182+xofs,100+y*6,12,2,3)
	 end

		for y=0,135 do
			for x=0,239 do
			 if math.random()<fade*2 then
					pix(x,y,0)
				end
			end
		end
	end
 r=0*fade+(1-fade)*200
 g=0*fade+(1-fade)*100
 b=120*fade
 setCol(9,r,g,b)

	T=T+1
end

-- bump can be set to give each trifan
--  a bit of wobble- makes it look more
--  dynamic/trippy
-- When drawing a trifan, use the
--  first point, the previous point
--  and the current point as a triangle
function drawTrifan(tf,bump,xshift)
 local c=tf.c
 local x0,y0=tf.p[1],tf.p[2]
	local xL,yL=tf.p[3],tf.p[4]

	local bx=math.sin(T/10+bump)+xshift
	local by=math.cos(T/10+bump)
	for i=5,#tf.p,2 do
		local x,y=tf.p[i],tf.p[i+1]
		tri(x0+bx,y0+by,xL+bx,yL+by,x+bx,y+by,c)
		xL,yL=x,y
	end
end

function drawScratch()
	for i=1,#SCRATCH,2 do
	 local x,y=SCRATCH[i],SCRATCH[i+1]
	 pix(x,y,12)
	end
end
-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

