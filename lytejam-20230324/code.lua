-- Lyte Jam (a personal Byte Jam)
-- Needs the fft build of TIC80 to run

mCos=math.cos
mSin=math.sin
mAtan=math.atan2
mPi=math.pi
mPi2=mPi*2
mMin=math.min
mMax=math.max
T=0
FFT={}
FFT[1]=0
FFT[2]=0
FFT[3]=0
FFT[4]=0

function fftGet(start,count)
	local acc=0
	for i=0,count do
		acc=acc+fft(start+i)
	end
	return acc/count
end

function SCN(n)
 rgb1=127+64+mSin(T*.01+n*.012)*64
 rgb2=127+64+mCos(T*.012-n*.023)*64
 rgb3=127+64+mSin(T*.023-n*.014)*64
	for c=1,15 do
		local addr=0x3fc0+c*3
		local p1=0.5+mSin(c*.2+T*.05)*0.5
		local p2=0.5+mSin(c*.23+T*.07)*0.5
		local p3=0.5+mSin(c*.19+T*.06)*0.5
		poke(addr,p1*rgb1)
		poke(addr+1,p2*rgb2)
		poke(addr+2,p3*rgb3)
	end
	local wibble=(
		mSin(n*.01+T*.03)
		+mCos(n*.014+T*.021)
	)/2
	poke(0x3FF9,wibble*50)
end

function TIC()
	FFT[1]=fftGet(0,6)
	FFT[2]=fftGet(40,6)*10
	FFT[3]=fftGet(100,6)*30
	FFT[4]=fftGet(200,6)*80

	vbank(1)
	cls(12)

	for i=1,100,.02 do
		x=120+(
			mCos(T*.02+i*.1)
			+mSin(T*.04+i*.17)
		)/2*180
		y=68+(
			mSin(T*.03+i*.1)
			+mCos(T*.05+i*.2)
		)/2*80
		s=15+mSin(i*.12+T*.05)*10
		circ(x,y,s,i*.4//1)
	end

	vbank(0)
	cls()
	steps=10
	for i=0,steps do
		srcXC=120+mCos(T*.12)*20
		srcYC=68+mSin(T*.13)*20
		destXC=120+mCos(T*.1)*100
		destYC=68+mSin(T*.17)*100
		srcA0=i*(mPi2/steps)
		srcA1=(i+1)*(mPi2/steps)
		ofs=(
			mCos(T*.010)
			+mSin(T*.017)
		)/2*4
		destA0=srcA0+ofs--+T*.01+i*.2
		destA1=srcA1+ofs--+T*.01+i*.2
		srcExtent=150--+mSin(T*.1)*60
		destExtent=500+mSin(T*.012)*500
		srcX0=120+mCos(srcA0)*srcExtent
		srcY0=68+mSin(srcA0)*srcExtent
		srcX1=120+mCos(srcA1)*srcExtent
		srcY1=68+mSin(srcA1)*srcExtent
		destX0=120+mCos(destA0)*destExtent
		destY0=68+mSin(destA0)*destExtent
		destX1=120+mCos(destA1)*destExtent
		destY1=68+mSin(destA1)*destExtent
		ttri(
			srcXC,srcYC,
			srcX0,srcY0,
			srcX1,srcY1,
			destXC,destYC,
			destX0,destY0,
			destX1,destY1,
			2
		)
	end
	
	vbank(1)
	cls()

 vbank(0)		

	for y=0,136 do
		fftIndex=(T*.03+(y/(34)))//1%4
		local str=FFT[fftIndex+1]*200
		for x=0,240 do
			c=0
			if(x<120)then
				if(120-x>str)then
					c=(y+x)/2//1>>4
				end
			else
				if(x-120>str)then
					c=(y+x)/2//1>>4
				end
			end
			
			pix(x,y,(pix(x,y)+c)%15+1)
		end
	end

	T=T+1
end
