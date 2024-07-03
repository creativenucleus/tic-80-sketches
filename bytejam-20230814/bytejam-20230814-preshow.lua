-- Greetz to: Aldroid, The Wolf,
-- Ferris, Mantratronic,
-- Alia, Gasman
-- Byte Jam Viewers!

function TIC()
	t=time()//32
	for y=0,136 do
		for x=0,240 do
			pix(239-x,y,(x+y+t)>>3)
		end
	end

	local word1s={"BYTE","NIGHT","ZEIT","MITE","BOAT","BOOT","KITE","BAIT","FLIGHT"}
	local word1=word1s[(t//37)%#word1s+1]

	local word2s={"JAM","HAM","CAN","CLAM","SPAM","FLAN","TRAM","JAAAAM"}
	local word2=word2s[(t//50)%#word2s+1]

	local w=print(word1,240,0,0,false,3)
	local y1=20+math.sin(t*.2)*10
	local y2=20+math.sin(t*.24)*10
	print(word1,115-w+1,y1+1,0,false,3)
	print(word1,115-w,y1,12,false,3)
	print(word2,125+1,y2+1,0,false,3)
	print(word2,125,y2,12,false,3)

	elli(120,80,25,20,2)
	print("jtruk",106,70+1,0)
	print("dialling",100,80+1,0)
	print("in",116,90+1,0)
	print("jtruk",106,70,12)
	print("dialling",100,80,12)
	print("in",116,90,12)

	l="Greetz to: Aldroid, The Wolf, Ferris, Mantratronic, Alia, Gasman, YOOU"
	w=print(l,240,0,0)
	local x=120-w/2+math.sin(t*.04)*70
	local y=110
	print(l,x+1,y+1,0)
	print(l,x,y,12)
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

