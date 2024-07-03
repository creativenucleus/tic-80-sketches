-- For testing FFT builds of TIC (jtruk)
--
-- This will error out on
--  non-FFT builds
-- Also, FFTS is a modern addition
--  so that will error out on
--  earlier FFT builds
function TIC()
	cls()
	for i=0,1023 do
		local x=i/1023*240
		
		local fftv=fft(i)
		print("FFT",220,10,12)
		line(x,0,x,fftv*68,1)
		
		local fftsv=ffts(i)
		print("FFTS",215,120,12)
		line(x,135,x,135-fftsv*68,3)
		
		local diff=fftv-fftsv
		print("DIFF",215,72,12)
		line(x,68,x,68+diff*100,5)
	end
end
