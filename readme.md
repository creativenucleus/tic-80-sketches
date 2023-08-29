# @JTRUK TIC-80 Sketches

Source and explanations.

All licensed permissively as [Code Credit v1.1.0](https://codecreditlicense.com/license/1.1.0) unless otherwise stated.

Please play, and please let me know if you enjoy, or build anything neat based upon them :)

Open for collabs if you're into these kind of effects.

## Contact

- [@jtruk@mastodon.social / Mastodon](https://mastodon.social/@jtruk)
- [@jtruk / Twitter](https://twitter.com/jtruk)
- [Hire me!](https://www.creativenucleus.com)

## Sketches

### August 2023: Byte Jam / August 28 (Study #P01135809)

A recreation of this week's most famous photo - the Trump mug shot.

![Donald Trump Portrait](https://github.com/creativenucleus/tic-80-sketches/assets/567996/6e3be6de-975d-485c-a7f2-c6e679d93ca4)

I wanted to do something a bit different and hacked together a bootstrapping bit of code that allowed me to click around the screen a few times to make a polygon shape, which would then dump to the trace log, so I could copy+paste it back into the code. The Byte Jam version of TIC doesn't send mouse actions to the server, so this technique was a bit invisible to viewers.

I try to avoid being too political - partly because it can be divisive and partly because it's hard to say anything new... but everyone loves a wobbly Trump, and many like the look of prison bars.

Bonus: A pre-jam holding page featuring a sketchy recreation of jazz-painter Bob Ross.

![bob-ross](https://github.com/creativenucleus/tic-80-sketches/assets/567996/3e3e3200-5504-49d6-844e-56b27b53d70c)

- [Project / Code](./bytejam-20230828)


### August 2023: Byte Jam / August 14

A colourful, building vine/tentacle effect made from triangles.

This worked quite well. The colour effect was a last minute addition and I think I could do more with movement, but overall happy with that!

Bonus: A pre-jam holding page featuring mix-ups of the words 'Byte' and 'Jam'.

- [Project / Code](./bytejam-20230814)

https://github.com/creativenucleus/tic-80-sketches/assets/567996/0a1589bb-9899-4024-967b-b74b4c534eda

### May 2023: Unicorn Blend #256 (Outline 23) / May 18

Placed 3rd in the [256b Newskool Competition](https://demozoo.org/parties/4627/#competition_17919).

- [Project / Code](./outline-2023)
- [On tic80.com](https://tic80.com/play?cart=3367)

https://github.com/creativenucleus/tic-80-sketches/assets/567996/62d848ba-31e9-4fda-9582-e457890556f7

### May 2023: Byte Jam / May 15

Some bouncy cubes.

This was an attempt to do some structured palette switching. Usually I do some gradient colourwash, but this has bands across the screen in vbank0 and vbank1.

The technique works, and I think can be tuned and explored.  
Your periodic reminder that TIC-80 allows 16 colours on screen at once. Double that if you use vbank1, and you can have 16 per line if you mess with the palette in the BDR() call.

- [Project / Code](./bytejam-20230515)

https://github.com/creativenucleus/tic-80-sketches/assets/567996/4a42aaae-d11a-43ff-8ac8-bbd4388213a9

### May 2023: Byte Jam / May 1

A Byte Jam return for the [Martian Madrigal](#feb-2023-martian-madrigal).

Pretty happy with this one, so no major Director's Cut re-edit. Requires the FFT build of TIC-80, or the [Fake FFT shim](#mar-2023-fake-fft).

There are a few variables that may benefit from tweaking if you need to match it to music (the FFT ranges, boosting, voice decay, etc).

- [Project / Code](./bytejam-20230501)

https://user-images.githubusercontent.com/567996/235526238-fc20caa7-9e65-4c0a-a6b0-a7a564a6a87f.mp4

### April 2023: Byte Jam / Apr 17

Some stars on top of a colourful background. Uses both vbanks and some smooth colouring.

I broke the Byte Jam version when I tried to make it 3D, and also made a big error in the final pass effect, but spent another hour or so polishing it into the thing that was in my head, so there's a jam version and a director's cut here!

- [Project / Code](./bytejam-20230417)

https://user-images.githubusercontent.com/567996/232861072-2fe2d2dc-3f6e-4b8f-bed7-1d9586f05373.mp4

### April 2023: Livecoding Experiment / Apr 17

Inspired by some livecoded visuals/music I've seen, I've coaxed TIC-80 into showing an effect underneath the code that's running it.

- [Project / Code](./livecoding)
- [On tic80.com](https://tic80.com/play?cart=3320)

![livecoding](https://user-images.githubusercontent.com/567996/232860774-6438e9d5-e595-4644-aa39-4e1f4644c4db.gif)

### April 2023: Ready Error One / Apr 8

An entry into Revision 2023 demoparty's Wild competition. Music by Mantratronic.

- [Project / Code](./readyerrorone)

Click to watch on YouTube:  
[![Watch the video](https://user-images.githubusercontent.com/567996/232862033-fec86f63-e95a-482b-ad75-3cd9c2cbec8b.jpg)](https://www.youtube.com/watch?v=jBA7xwnnrWs)

### April 2023: Size Coding / Apr 5

A DNA twisting effect. Fits into 255 bytes when compressed.

- [Project / Code](./sizecode-20230405)

https://user-images.githubusercontent.com/567996/230115294-3601745c-677a-40eb-aee8-4d736e5e4d77.mp4

### Mar 2023: Lyte Jam / Mar 30

Inspired by [Orbital](https://www.orbitalofficial.com/) - a flying shapes tunnel.

- [Project / Code](./lytejam-20230330)

[![Orbital effect](https://user-images.githubusercontent.com/567996/229347340-7081dcad-9775-44ce-92cf-0ee5b595bc2d.gif)  Click for video](https://user-images.githubusercontent.com/567996/229346989-8b02d147-87be-4ce4-b083-6ff42f24c749.mp4 "Orbital effect")

### Mar 2023: Fake FFT

A fake `fft` function as a fallback for versions of TIC-80 that don't have it.

- [Project / Code](./fake-fft)

https://user-images.githubusercontent.com/567996/229523790-7f747fc5-dcfc-45e5-966d-29fd51584818.mp4

### Mar 2023: Lyte Jam / Mar 24

A wobbly fake-rotozoom effect with FFT bars and trippy colours.

- [Project / Code](./lytejam-20230324)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229347708-82b6e99d-e2d2-4ec2-966b-dd4e2c63fdfa.gif)  Click for video](https://user-images.githubusercontent.com/567996/229347709-3a8b916e-d5bc-46fa-97e7-81eba3f4e634.mp4 "TIC-80 effect")

### Mar 2023: Lyte Jam / Mar 16

Small circles stencilled on top of a zooming concentric circle, with wobble and palette shift.

- [Project / Code](./lytejam-20230316)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229347928-0e0684af-a1a7-4c71-bc43-252aa400e861.gif)  Click for video](https://user-images.githubusercontent.com/567996/229347925-fd087022-3d54-4c31-abb5-d544f23b8f92.mp4 "TIC-80 effect")

### Mar 2023: Lyte Jam / Mar 15

Colourful tube worms. They look so purposeful!

- [Project / Code](./lytejam-20230315)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229349479-324d2fe4-4bd2-494a-9a31-437bec5ac883.gif)  Click for video](https://user-images.githubusercontent.com/567996/229349482-5dfc852c-5202-48cf-a974-fa2ecd34d410.mp4 "TIC-80 effect")  


[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229349485-99723048-5aa6-43ac-9dda-d7363919ddb5.gif)  Click for video](https://user-images.githubusercontent.com/567996/229349489-01e1f5a0-922f-4a26-a976-299be5e8c843.mp4 "TIC-80 effect")

### Mar 2023: Byte Jam / Mar 13

Robot conveyor.

- [Project / Code](./bytejam-20230313)

### Mar 2023: Dotcube

A floating 3D dot cube, with jazzy background (needs the FFT build of TIC-80).

- [Project / Code](./dotcube)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229348163-49509aa9-3ce2-46ca-b24d-0189857fcd7c.gif)  Click for video](https://user-images.githubusercontent.com/567996/229348165-fdf58819-0ef0-40ca-9aef-01fa34a387fd.mp4 "TIC-80 effect")

### Feb 2023: Byte Jam / Feb 20

Robot disco.

- [Project / Code](./bytejam-20230220)

### Feb 2023: Martian Madrigal

- [Project / Code](./martian-madrigal)
- [On tic80.com](https://tic80.com/play?cart=3296)

An alien barbershop quartet.

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229348437-e101b924-4e0c-41a1-8849-db61d6dd1156.gif)  Click for video](https://user-images.githubusercontent.com/567996/229348340-32c04a6f-b1a0-402b-aec6-b599357effde.mp4 "TIC-80 effect")

### Feb 2023: Eye of the Machine

A chaotic cyber/organic eyeball.

- [Project / Code](./eye-of-the-machine)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229348650-14026e85-b8dd-44e6-be8a-f28150934831.gif)  Click for video](https://user-images.githubusercontent.com/567996/229348655-dd771a85-1641-440b-a00f-0166472ff6df.mp4 "TIC-80 effect")

### Feb 2023: FauxjiBoink!

A modern take on the classic Atari FujiBoink demo.

- [Project / Code](./fauxjiboink)
- [On tic80.com](https://tic80.com/play?cart=3297)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229348932-f57722dc-c2cf-4163-bc48-58f130c59269.gif)  Click for video](https://user-images.githubusercontent.com/567996/229349144-263a0816-ca38-4442-830c-a9c3c231b8bd.mp4 "TIC-80 effect")

### Jan 2023: Jelly Hearts

Glassy zooming sprites.

- [Project / Code](./jelly-hearts)

[![TIC-80 effect](https://user-images.githubusercontent.com/567996/229349245-e323b741-3c6d-4315-8fae-6b14970c2f56.gif)  Click for video](https://user-images.githubusercontent.com/567996/229349246-e709c4c8-2783-4802-8a84-09213d2192de.mp4 "TIC-80 effect")
