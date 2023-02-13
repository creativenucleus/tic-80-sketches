An experiment with sound, personality, and sizecoding.

Code should be pretty easy to follow.  

- Four alien characters, one for each sound channel, each configured by two arrays (V: volume, N: note frequency)
- A conditional statement that (1) keeps a sync beat (2) triggers off the voices in an interesting pattern.
- Some maths that makes sounds that trigger on a particular beat have harmonic frequency (hat-tip: some half-hour YouTube music theory tutorial!)
- Poking of memory to get sound. Needs to be done every frame- frequency, wave form (just 1 nybble out of a possible 32), volume
- Drawing the aliens (right/back to left/front), shifting them around to respect the voice volume.
- Decay the volume for each alien.

Released at [Lovebyte 2023](https://demozoo.org/productions/319383/)

If you pick this up, you could try:
- Mixing in the amazing [TIC-80 FFT hack](https://github.com/glastonbridge/TIC-80/releases)
- Different sound waves (not possible for the 256 byte compo, but square, sin, sawtooth, noise and blends all give nice character differentiation)
- Different harmonies
- Other character styles
