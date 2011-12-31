/* Problem: Computing Square Roots (1.1 in AFT)
 *
 * Implement a fast integer square root function that takes in
 * a 32-bit unsigned integer and returns another 32-bit unsigned
 * integer that is the floor of the square root of the input.
 *
 * Solution: Use a binary search tree
 *
 * At first look, this problem doesn't really seem like it should
 * be a binary search tree. However, consider the following
 * algorithm:
 *
 *   - Use a binary search to quickly find the rough
 *     magnitude of the input number
 *   - Use bitwise operations to find the rough answer
 *   - Then do a search in the vicinity to find the
 *     proper answer.
*/

#include <math.h>
#include <stdio.h>

unsigned long int square_root(unsigned long int input) {
  unsigned long int result;

  int hi_bit, lo_bit, curr_bit;

  hi_bit = 31; lo_bit = 0;

  while (lo_bit <= hi_bit) {

    curr_bit = lo_bit + (hi_bit - lo_bit)/2;
    result = (1 << curr_bit);

    if (result < input) {
      lo_bit = curr_bit + 1;
    } else if (result == input) {
      break;
    } else {
      hi_bit = curr_bit - 1;
    }
  }

  curr_bit /= 2;
  result = (input >> curr_bit);

  while(result*result > input) {
    result -= 1;
  }

  return result;
};

int main(int argc, char **argv) {
  unsigned long int input, output, real_answer;

  if (argc < 2) {
    printf("Please enter input as an argument\n");
    return(1);
  }

  sscanf(argv[1], "%lu", &input);
  output = square_root(input);
  real_answer = (unsigned long int) floor(sqrt( (double) input ));

  printf("input:  %lu\n", input);
  printf("output: %lu\n", output);
  printf("real:   %lu\n", real_answer);

  return 0;
};
