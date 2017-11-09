# Lab 8 Notes

- **No walking in the mazes!**  You will break the floor!

- It's probably a good idea to choose one maze and stick with it - different shadows in other mazes can impact your sensor readings.
- Stick with the same battery as well - weight can impact your speed through the maze and throw off your algorithm

- You cannot dead-reckon for the competition or for functionality!  Functionality must use at least one sensor.

- My recommendation: keep your algorithm simple!  That way, there's less to debug when things go wrong.
  - My robot uses a left wall following technique and this solves for all levels of functionality.
  - My code:
    - Very short (~ 10 lines, using my libs)
    - Only uses "too close" thresholds

- The charge level of your battery can impact your sensor readings and motor speed - be wary of this!

- Naming your robot something cool is critical!  Mine is Sir Mix-a-Bot

- **Good first step**: Go from the entrance to the first wall and stop - while avoiding left and right walls.
