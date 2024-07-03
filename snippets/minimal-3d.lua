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
local SIN,COS=math.sin,math.cos

function TIC()
	T=time()*.03

	cls()
	
	-- mr? = model rotation in world
	local mrX=0 --T*.02
	local mrY=0 --T*.025
	local mrZ=0 --T*.03

	-- mt? = model transform in world
	local mtX=0 --SIN(T*.1)
	local mtY=3 --SIN(T*.07)
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
	local camZ=6
	local scaleZ=3
	local pixScale=100
	local zD=camZ-p.z/scaleZ
	return {
		x=120+p.x/zD*pixScale,
		y=68+p.y/zD*pixScale,
		z=zD,
	}
end
