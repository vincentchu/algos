#include <stdio.h>
#include <stdlib.h>
#include "linked_list.h"

int main(int argc, char* argv) {

  LL_node *head, *tail, *node;
  int i;

  // Initialize the linked list with 0.0,
  // then push on numbers until 99.0
  LL_init(&head, &tail, 0.0);
  for(i=1; i<10; i++) LL_push(&tail, 1.0*i);

  // Iterate over the linked list
  printf("** Iteratate in the forward direction\n");
  node = head;
  while (node != NULL) {
    printf("%6.2f\n", node->value);
    node = node->next;
  }

  // Iterate over the linked list in reverse
  printf("** Iteratate in the reverse direction\n");
  node = tail;
  while (node != NULL) {
    printf("%6.2f\n", node->value);
    node = node->prev;
  }

  // free the linked list
  LL_free(&head, &tail);

  return 0;
}

