function TIC()
	cls()
	T=time()//32
	print("BYTE JAM",14+math.sin(T/12)*10,30,2,false,5)
	for y=0,136 do
		for x=0,240 do
			p=pix(x,y)
			c=p+((x+y-T>>5)%2==0 and 6 or 9)
			pix(x,y,c)
		end
	end
	
	circ(120,60,60,3)
	rect(90,55,60,68,4)
	elli(110,75,10,5,12)
	elli(130,75,10,5,12)
	circ(110,75,3,0)
	circ(130,75,3,0)
	rect(100,65-math.abs(math.sin(T/5))*10,15,3,3)
	rect(125,65-math.abs(math.sin(T/5+1))*10,15,3,3)
	elli(115,95,3,2,0)
	elli(125,95,3,2,0)
	elli(120,115,30,10,3)
	elli(120,115,15,3,12)
	elli(120,112,15,3,3)

	local y=math.sin(T/8)*10	
	rect(200,70+y,20,5,T//10)
	rect(200,75+y,20,20,0)
	rect(200,90+y,20,5,2)
	rect(205,90+y,10,25,2)
	circ(210,110+y,10,4)
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

