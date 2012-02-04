#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int main(int argc, char **argv) {

  int len, i, j;
  char *str, cchar;

  len = strlen( argv[1] );
  str = malloc( sizeof(char[len]) );

  strncpy(str, argv[1], len);
  printf("original string = %s\n", str );

  for (i=0; i<(len/2); i++) {
    j        = (len - i - 1);
    cchar    = *(str+i);
    *(str+i) = *(str+j);
    *(str+j) = cchar;
  }

  printf("reversed string = %s\n", str );

  free(str);

  return 0;
};
