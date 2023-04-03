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

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

