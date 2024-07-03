-- title: Fake FFT
-- author: @jtruk
-- desc: A shim to run effects that use the TIC-80 FFT fork on non-FFT builds
-- script: lua
-- group: Hex Heroes
-- date: Apr 2023
-- license: Code Credit License v1.1.0

-- Feel welcome to use this function
-- Explanation/send improvements via:
--  https://github.com/creativenucleus/tic-80-sketches/tree/main/fake-fft
fakeFft=function(n)
	local bpm=100
	local cycle=(60*1000)/bpm

	local peaks={}
	peaks={{
		pos=3,
		t=1-(time()%cycle)/cycle
	},{
		pos=50,
		t=1-((time()+cycle/4)%cycle)/cycle
	},{
		pos=90,
		t=1-((time()+cycle/2)%cycle)/cycle
	},{
		pos=130,
		t=1-((2*time()+cycle/8)%cycle)/cycle
	},{
		pos=230,
		t=1-((2*time()+cycle/4)%cycle)/cycle
	}}

	local d=0
	for p=1,#peaks do
		peak=peaks[p]
		d=d+math.max(0,peak.t*(1-math.abs((n-peak.pos)/10^0.4)))
	end
	
	d=math.max(0,d+math.random()*.3)
		
	return math.min(1,d/(n+1)^.4)
end
	
EQ={}
function BOOT()
	for i=0,255 do
		EQ[i]=0
	end
end

useRealFftFn=true
function TIC()
	if btnp(4) then
		useRealFftFn=not useRealFftFn
	end

	cls()
	for n=0,255 do
		local fftval=0
		if useRealFftFn then
			fftval=fft and fft(n) or 0
		else
			fftval=fakeFft(n)
		end

		local x=(n//64)*60
		local y=60+n%64
		
  line(x,y,x+EQ[n]*50,y,1)
  line(x,y,x+fftval*50,y,2+(n%10))
		if(fftval>EQ[n])then
			EQ[n]=fftval
		else
			-- decay
			EQ[n]=EQ[n]*.995
		end
	end

	print("Fake FFT generator",0,0,12,false,2)
	print("Press button A (keyboard: Z) to toggle",0,15,12)
	local str="FFT: "
	if(useRealFftFn)then
		if fft then
			str=str.."Real"
		else
			str=str.."[!Real is not available]"
		end
	else
		str=str.."Fake"
	end
	print(str,0,50,12)
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SCREEN>
-- 000:cccccccccc00000000000000cccc0000000000000000000000000000cccccccccc00cccccccccc00cccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000
-- 001:cccccccccc00000000000000cccc0000000000000000000000000000cccccccccc00cccccccccc00cccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000
-- 002:cccc0000000000cccccccc00cccc0000cc0000cccccc000000000000cccc00000000cccc0000000000cccc00000000000000cccccc000000cccccc0000cccccccc000000cccccc0000cccccccc000000cccccccc00cccccccccc0000cccccc0000cccccccc00000000000000000000000000000000000000
-- 003:cccc0000000000cccccccc00cccc0000cc0000cccccc000000000000cccc00000000cccc0000000000cccc00000000000000cccccc000000cccccc0000cccccccc000000cccccc0000cccccccc000000cccccccc00cccccccccc0000cccccc0000cccccccc00000000000000000000000000000000000000
-- 004:cccccccc0000cc0000cccc00cccccccc0000cccc00cccc0000000000cccccccc0000cccccccc000000cccc000000000000cc0000cccc00cccc00cccc00cccc0000cc00cccc00cccc00cccc0000cc00cc0000cccc0000cccc000000cccc0000cc00cccc0000cc000000000000000000000000000000000000
-- 005:cccccccc0000cc0000cccc00cccccccc0000cccc00cccc0000000000cccccccc0000cccccccc000000cccc000000000000cc0000cccc00cccc00cccc00cccc0000cc00cccc00cccc00cccc0000cc00cc0000cccc0000cccc000000cccc0000cc00cccc0000cc000000000000000000000000000000000000
-- 006:cccc00000000cc0000cccc00cccc0000cc00cccccc00000000000000cccc00000000cccc0000000000cccc000000000000cccccccccc00cccccc000000cccc0000cc00cccccc000000cccc00000000cc0000cccc0000cccc000000cccc0000cc00cccc000000000000000000000000000000000000000000
-- 007:cccc00000000cc0000cccc00cccc0000cc00cccccc00000000000000cccc00000000cccc0000000000cccc000000000000cccccccccc00cccccc000000cccc0000cc00cccccc000000cccc00000000cc0000cccc0000cccc000000cccc0000cc00cccc000000000000000000000000000000000000000000
-- 008:cccc0000000000cccccccc00cccc0000cc0000cccccc000000000000cccc00000000cccc0000000000cccc000000000000000000cccc0000cccccc0000cccc0000cc0000cccccc0000cccc0000000000cccccccc000000cccccc0000cccccc0000cccc000000000000000000000000000000000000000000
-- 009:cccc0000000000cccccccc00cccc0000cc0000cccccc000000000000cccc00000000cccc0000000000cccc000000000000000000cccc0000cccccc0000cccc0000cc0000cccccc0000cccc0000000000cccccccc000000cccccc0000cccccc0000cccc000000000000000000000000000000000000000000
-- 010:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 015:cccc000000000000000000000000000000cc00000000000cc0000cc00000000000000000000ccc0000000c0cc0000000000000000cc0000000000000000000000000cc0cc00000ccccc0c0000000cc00000000000000cc000000000000000000000cc0000000000000000000000000000000000000000000
-- 016:cc00c0cccc000ccc000cccc00cccc00000cccc00cc00c0ccccc0ccccc00ccc00cccc000000cc00c00000c00cc00c00ccc00c00cc0cccc000ccc000cccc0cccc000cccc0cc0000000cc000c00000ccccc00ccc000000ccccc00ccc000ccc000ccc00cc0000ccc000000000000000000000000000000000000
-- 017:cc00c0cc00c0cc0cc0ccc000ccc0000000cc00c0cc00c00cc0000cc000cc00c0cc00c00000cc00c00000c00cccc00cc0cc0c00cc0cc00c0cc00c0c00cc0cc00c0c00cc000000000cc0000c000000cc000cc00c000000cc000cc00c0c00cc0c00cc0cc000cc0cc00000000000000000000000000000000000
-- 018:cccc00cc0000ccc00000ccc000ccc00000cc00c0cc00c00cc0000cc000cc00c0cc00c00000ccccc00000c00cc00c0ccc0000cccc0cc00c0cc00c0c00cc0cc0000c00cc0cc00000cc00000c000000cc000cc00c000000cc000cc00c0ccccc0ccccc0cc000ccc0000000000000000000000000000000000000
-- 019:cc0000cc00000ccc00cccc00cccc000000cccc000ccc0000ccc000ccc00ccc00cc00c00000cc00c000000c0cc00c00ccc00000cc0cccc000ccc000cccc0cc00000cccc0cc00000ccccc0c00000000ccc00ccc00000000ccc00ccc00000cc0000cc00ccc00ccc000000000000000000000000000000000000
-- 020:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccc000000000000000000000000000000000000000000000000000000000000000000000000000000000ccc000ccc00000000000000000000000000000000000000000000000
-- 050:ccccc0ccccc0cccc0cc00000ccccc0000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 051:cc0000cc00000cc00cc00000cc00000cccc0cc00c00ccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 052:cccc00cccc000cc000000000cccc00c00cc0cccc00cc0cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 053:cc0000cc00000cc00cc00000cc0000c00cc0cc00c0ccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 054:cc0000cc00000cc00cc00000cc00000cccc0cc00c00ccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 060:222222211111110000000000000000000000000000000000000000000000661000000000000000000000000000000000000000000000000000000000aa1100000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000
-- 061:333333333333333311000000000000000000000000000000000000000000711000000000000000000000000000000000000000000000000000000000bb1111000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000
-- 062:444444444444444411111111110000000000000000000000000000000000811000000000000000000000000000000000000000000000000000000000222111110000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000
-- 063:555555555555555555555555555111111000000000000000000000000000911000000000000000000000000000000000000000000000000000000000333111000000000000000000000000000000000000000000000000000000770000000000000000000000000000000000000000000000000000000000
-- 064:666666666666666666611000000000000000000000000000000000000000a11000000000000000000000000000000000000000000000000000000000441000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000
-- 065:777777771110000000000000000000000000000000000000000000000000bbb000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000
-- 066:888811100000000000000000000000000000000000000000000000000000211000000000000000000000000000000000000000000000000000000000666000000000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000000000000000000
-- 067:911111000000000000000000000000000000000000000000000000000000333000000000000000000000000000000000000000000000000000000000771000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000
-- 068:aaaaa1000000000000000000000000000000000000000000000000000000441000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000
-- 069:bbbb11000000000000000000000000000000000000000000000000000000511000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000330000000000000000000000000000000000000000000000000000000000
-- 070:221111000000000000000000000000000000000000000000000000000000611000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000
-- 071:333331000000000000000000000000000000000000000000000000000000771000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000
-- 072:444440000000000000000000000000000000000000000000000000000000811000000000000000000000000000000000000000000000000000000000221000000000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000
-- 073:555510000000000000000000000000000000000000000000000000000000911000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000
-- 074:661110000000000000000000000000000000000000000000000000000000a11000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000
-- 075:711110000000000000000000000000000000000000000000000000000000b11000000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000
-- 076:811110000000000000000000000000000000000000000000000000000000222000000000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000000000000000000
-- 077:999910000000000000000000000000000000000000000000000000000000331000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000
-- 078:a11100000000000000000000000000000000000000000000000000000000441000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000
-- 079:bbbb10000000000000000000000000000000000000000000000000000000555000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000
-- 080:211100000000000000000000000000000000000000000000000000000000611000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000
-- 081:333300000000000000000000000000000000000000000000000000000000711000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000
-- 082:444440000000000000000000000000000000000000000000000000000000881000000000000000000000000000000000000000000000000000000000220000000000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000
-- 083:555100000000000000000000000000000000000000000000000000000000911000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000770000000000000000000000000000000000000000000000000000000000
-- 084:666110000000000000000000000000000000000000000000000000000000aa1100000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000
-- 085:771100000000000000000000000000000000000000000000000000000000bbb111100000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000
-- 086:811100000000000000000000000000000000000000000000000000000000222111111000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000
-- 087:911100000000000000000000000000000000000000000000000000000000331111000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000
-- 088:a11100000000000000000000000000000000000000000000000000000000444100000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000
-- 089:bb1100000000000000000000000000000000000000000000000000000000511000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000330000000000000000000000000000000000000000000000000000000000
-- 090:222100000000000000000000000000000000000000000000000000000000611000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000
-- 091:311100000000000000000000000000000000000000000000000000000000711000000000000000000000000000000000000000000000000000000000bb0000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000
-- 092:441100000000000000000000000000000000000000000000000000000000881000000000000000000000000000000000000000000000000000000000220000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000
-- 093:551100000000000000000000000000000000000000000000000000000000991000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000
-- 094:666100000000000000000000000000000000000000000000000000000000aa1000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000
-- 095:711100000000000000000000000000000000000000000000000000000000b11000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000
-- 096:888100000000000000000000000000000000000000000000000000000000222000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000aa1000000000000000000000000000000000000000000000000000000000
-- 097:911100000000000000000000000000000000000000000000000000000000333000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000bb1100000000000000000000000000000000000000000000000000000000
-- 098:a11100000000000000000000000000000000000000000000000000000000444000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000221111100000000000000000000000000000000000000000000000000000
-- 099:b11100000000000000000000000000000000000000000000000000000000511000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000311110000000000000000000000000000000000000000000000000000000
-- 100:211000000000000000000000000000000000000000000000000000000000611000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000441000000000000000000000000000000000000000000000000000000000
-- 101:311100000000000000000000000000000000000000000000000000000000771000000000000000000000000000000000000000000000000000000000bb0000000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000
-- 102:411000000000000000000000000000000000000000000000000000000000881000000000000000000000000000000000000000000000000000000000220000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000
-- 103:555500000000000000000000000000000000000000000000000000000000991000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000
-- 104:666600000000000000000000000000000000000000000000000000000000aa1000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000
-- 105:777000000000000000000000000000000000000000000000000000000000bb1000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000
-- 106:881000000000000000000000000000000000000000000000000000000000221000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000
-- 107:911100000000000000000000000000000000000000000000000000000000331000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000bb0000000000000000000000000000000000000000000000000000000000
-- 108:aaaa10000000000000000000000000000000000000000000000000000000441000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000
-- 109:bbbbbbb11000000000000000000000000000000000000000000000000000511000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000
-- 110:222222211111100000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000410000000000000000000000000000000000000000000000000000000000
-- 111:333333111000000000000000000000000000000000000000000000000000770000000000000000000000000000000000000000000000000000000000bb0000000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000
-- 112:441110000000000000000000000000000000000000000000000000000000888000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000
-- 113:551000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000330000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000
-- 114:661000000000000000000000000000000000000000000000000000000000aaa000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000
-- 115:771000000000000000000000000000000000000000000000000000000000bb0000000000000000000000000000000000000000000000000000000000510000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000
-- 116:811000000000000000000000000000000000000000000000000000000000211000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000000000000000000
-- 117:991000000000000000000000000000000000000000000000000000000000331000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000
-- 118:a11000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000810000000000000000000000000000000000000000000000000000000000210000000000000000000000000000000000000000000000000000000000
-- 119:bbb000000000000000000000000000000000000000000000000000000000551000000000000000000000000000000000000000000000000000000000910000000000000000000000000000000000000000000000000000000000330000000000000000000000000000000000000000000000000000000000
-- 120:221000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000000000a10000000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000000000000000000000000
-- 121:333000000000000000000000000000000000000000000000000000000000770000000000000000000000000000000000000000000000000000000000b10000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000
-- 122:411000000000000000000000000000000000000000000000000000000000881000000000000000000000000000000000000000000000000000000000220000000000000000000000000000000000000000000000000000000000660000000000000000000000000000000000000000000000000000000000
-- 123:511000000000000000000000000000000000000000000000000000000000999000000000000000000000000000000000000000000000000000000000310000000000000000000000000000000000000000000000000000000000710000000000000000000000000000000000000000000000000000000000
-- </SCREEN>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>
