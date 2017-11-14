# Lab 8 Notes

- **No walking in the mazes!**  You will break the floor!

- It's probably a good idea to choose one maze and stick with it.  There are slight differences between the two.
- Weight can impact your speed through the maze and throw off your algorithm
- Your robot may "drift" at higher speeds

- You cannot dead-reckon for the competition or for functionality!  Functionality must use at least one sensor.

- My recommendation: keep your algorithm simple!  That way, there's less to debug when things go wrong.
  - My robot uses a left wall following technique and this solves for all levels of functionality.
  - My code:
    - Very short (~ 10 lines, using my libs)
    - Only uses "too close" thresholds

- The charge level of your battery can impact your sensor readings and motor speed - be wary of this!

- Naming your robot something cool is critical!  Mine is Sir Mix-a-Bot.  A label maker is provided in class.

- **Good first step**: Go from the entrance to the first wall and stop - while avoiding left and right walls.
