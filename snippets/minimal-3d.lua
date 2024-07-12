-- A smallish code snippet to draw
--  a 3D checkerboard (jtruk)
-- 
-- This doesn't do any z-sorting, so
--  the triangles will fight
-- Before drawing, we could either
--  table.sort the triangles on z
--  or we could use ttri, which employs
--  a z-buffer

-- make some local aliases - for clean code and speed!
local SIN,COS,PI=math.sin,math.cos,math.pi
local MIN,MAX=math.min,math.max
local TAU=2*PI
local CAMX,CAMY,CAMZ=0,0,0

function TIC()
	T=time()*.03

	cls()
	
	-- +ve is right,down,into-screen	
	CAMZ=-9
	CAMY=-1.5
 
	drawFloor()
	drawSpheres({x=0,y=-2,z=0},3,T*.05)
end

function drawSpheres(centre,radius,t)
	local nSpheres=5
	for i=1,nSpheres do
		local aOfTau=(i/nSpheres)*TAU
		local a=aOfTau+t
		local p={
			x=COS(a)*radius,
			y=SIN(aOfTau+t*2),
			z=SIN(a)*radius,
		}
	
		p=trans(p,centre)
		p=proj(p)
		local size=MIN(MAX(20*p.z,.1),40)
		circ(p.x,p.y,size,12)
	end
end

function drawFloor()	
	-- mr? = model rotation in world
	local mrX=0 --T*.02
	local mrY=0 --T*.025
	local mrZ=0 --T*.03

	-- mt? = model transform in world
	local mtX=0 --SIN(T*.1)
	local mtY=0 --SIN(T*.07)
	local mtZ=0 --SIN(T*.08)

	-- lt? = local transform of tile within model
	for ltX=-3,3 do
		for ltZ=-3,3 do
		 local ltY=0 --SIN(ltX+ltZ+T*.1)
			
			-- lr? = local rotation of tile in model
			local lrX=0 --T*.05
			local lrY=0 --T*.03
			local lrZ=0 --T*.08

			-- c = colour (checkerboard)
			local c=1+(ltX+ltZ)%2

			drawTile(
				{x=lrX,y=lrY,z=lrZ},
				{x=ltX,y=ltY,z=ltZ},
				{x=mrX,y=mrY,z=mrZ},
				{x=mtX,y=mtY,z=mtZ},				
				c
			)
		end
	end
end

-- lr = local rotate
-- lt = local transform
-- mr = model rotate
-- mt = model transform
function drawTile(lr,lt,mr,mt, c)
	-- Four corners of a 1x1 square...
	local ps={
		{x=-.5, y=0, z=-.5},
		{x=.5, y=0, z=-.5},
		{x=-.5, y=0, z=.5},
		{x=.5, y=0, z=.5},
	}

	-- Move these points...
	for ip=1,#ps do
	 local p=ps[ip]
		
		-- rotate tile point around the tile origin
		p.x,p.y=rot(p.x,p.y,lr.z)
		p.x,p.z=rot(p.x,p.z,lr.y)
		p.y,p.z=rot(p.y,p.z,lr.x)

		-- transform tile point within the model
		p=trans(p,lt)

		-- rotate model in world
		p.x,p.y=rot(p.x,p.y,mr.z)
		p.x,p.z=rot(p.x,p.z,mr.y)
		p.y,p.z=rot(p.y,p.z,mr.x)

		-- transform model in world
		p=trans(p,mt)

		ps[ip]=proj(p)
	end

	drawTri(ps[1],ps[2],ps[3],c)
	drawTri(ps[2],ps[3],ps[4],c)
end

function drawTri(ps1,ps2,ps3,c)
	tri(
		ps1.x,ps1.y,
		ps2.x,ps2.y,
		ps3.x,ps3.y,
		c
	)
end

-- Translate point p(x,y,z) by t(x,y,z)
function trans(p,t)
	return {
		x=p.x+t.x,
		y=p.y+t.y,
		z=p.z+t.z
	}
end

-- Rotate coords (a,b) around r
-- See Tiny Code Christmas Day 11
-- 	for the expanded version
function rot(a,b,r)
	return
		a*COS(r)-b*SIN(r),
		a*SIN(r)+b*COS(r)
end

-- Project a point p(x,y,z) in 3D space
-- 120,68 is the pixel centre of the screen
-- All the rest are magic numbers
function proj(p)
	local projScale=2
	local zD=projScale/(p.z-CAMZ)
	local pixScale=80
	return {
		x=120+(p.x-CAMX)*zD*pixScale,
		y=68+(p.y-CAMY)*zD*pixScale,
		z=zD,
	}
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

