# Fake FFT (TIC-80)

A crack at a fake `fft(n)` function for non-modified builds of TIC-80.

This sounds a bit back to front, but bear with me...

## Overview

Since I got started with TIC-80, one of my favourite things is noodling some visual effect into existence over an hour. The most entertaining way of doing that is playing some background music (usually breakbeat here, please) and using a special build of [TIC-80 with a FFT hack that does some sound spectrum analysis](https://github.com/glastonbridge/TIC-80/releases). This adds a `fft(n)` function for your code to use. Bliss-state follows.

There are some environments that won't have `fft` available. You can download a Windows build with a click from the page linked above, but Mac users will need to build it for themselves, and it won't be possible in the [browser version](https://tic80.com/create) without some elegant pyramid of human engineering.

So I thought I'd have a stab at making a fake `fft` function - then, when I put code for my sketches online and someone wants to try one it'll run without errors, and look close-ish to what was intended, irrespective of how they run it.

This takes advantage of the way Lua treats function stubs as variables, so you can query if a function exists and also easily assign / reassign them e.g.:

```
if not fft then
    fft=function(n)
        return math.random()
    end
end
```

That structure could sit at the top of any code and TIC-80 would either use the built-in `fft` or, if not available, this default.

The code in this repo is a bit more complicated than just inserting an fft function - it has a harness that allows you to switch between fake and real FFT responses to compare them. You can run it on a non-FFT build of TIC-80 and it won't fail (but the FFT:Real option won't do anything).

## History

26 Mar 2023: Released (Just for fun)
3 Apr 2023: Some improvement to the FFT function

## Play!

The function at the moment is super rough. The individual response values and curve don't look like real music, other than it has a periodic beat (adjustable with a local `bpm` variable) and it decays off as you head towards the high end... lots of room for improvement!

There's *plenty* of scope for improvement. I'd also like to ensure it stays small. Suggestions / forks welcome!

*DO* Get in touch and show me if you make anything! Contact details [here](https://github.com/creativenucleus/tic-80-sketches/blob/main/readme.md#contact)

## Thanks

- [TIC-80](https://tic80.com/)
- Aldroid, Gasman [FFT hack](https://github.com/glastonbridge/TIC-80/releases)
