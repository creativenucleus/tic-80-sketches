-- anaglyph (unfinished)
-- Mixes two colour planes
-- Could be improved by having a fixed focal plane (colors are red-cyan infront of it and cyan-red behind it)

local GRAB={}
local T=0
local CAMX,CAMY,CAMZ=0,0,0

function rgb(i,r,g,b)
	local a=16320+i*3
	poke(a,r)
	poke(a+1,g)
	poke(a+2,b)
end

function BOOT()
	rgb(0,0,0,0)
	rgb(1,255,0,0)
	rgb(2,0,255,255)
	rgb(3,255,255,255)
end

function TIC()
	poke(0x3ffb,0)
	draw(1)
	grabScreen()
	
	vbank(0)
	cls()
	draw(0)
	mixScreen()
	
	vbank(1)
	cls()
	
	T=T+1
end

function draw(side)
	local off=side*10
	local c=side+1
	for i=0,10 do
		local a=i*.5+T*.02
		local x=math.sin(a*.6)
		local y=math.cos(a)
		local z=5+math.sin(T*.02-i*.4+T*.02)*4.5
		local p=proj({x=x,y=y,z=z})
		if p.z>0 then
			local s=math.min(100,p.z*10)
			circ(p.x+off*(1/z),p.y,s,c)
		end
	end
end

function grabScreen()
	for i=0,32640 do
		GRAB[i]=peek4(i)
	end
end

function mixScreen()
	for i=0,32640 do
		poke4(i,peek4(i)|GRAB[i])
	end
end	

function proj(p)
	local projScale=2
	local zD=projScale/(p.z-CAMZ)
	local pixScale=30
	return {
		x=120+(p.x-CAMX)*zD*pixScale,
		y=68+(p.y-CAMY)*zD*pixScale,
		z=zD,
	}
end
