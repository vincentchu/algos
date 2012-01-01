#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "../../data_structures/linked_list/linked_list.h"

/* Problem: Reversing a singly linked list
 *
 * Suppose you were given a singly linked list of integers
 * sorted in ascending order and you need to return a list
 * with the element sorted in descending order. Suppose
 * memory is scarce but you can reuse nodes in the orignal
 * list. (AFT 11.7)
 *
 * Solution: Use pointer-fu. Definitely a bit confusing
 * because you have to keep track of a lot of different
 * pointers to different places. But the basic idea is to
 * traverse your original linked list:
 *
 *   A -> B -> C -> ... -> X -> Y -> Z
 *
 * As you traverse, set the "next" pointer of the next
 * node to the previous node and continue. After you're
 * done, you'll have a reversed linked list!
*/

void LL_reverse(LL_node **head, LL_node **tail) {

  LL_node *new_head, *new_tail, *node, *prev_node, *next_node;

  new_tail = *head;

  prev_node = *head;
  node = (*head)->next;
  prev_node->next = NULL;

  while (node) {
    next_node = node;
    node = node->next;

    next_node->next = prev_node;
    prev_node = next_node;
  }

  *head = prev_node;
};

int main(int argc, char **argv) {

  LL_node *head, *tail, *node;
  int i;

  LL_init(&head, &tail, 0.0);
  for (i=1; i<10; i++)
    LL_push(&tail, (double) i);

  LL_reverse(&head, &tail);

  node = head;
  while (node) {
    printf("%f\n", node->value);
    node = node->next;
  }

  return 0;
};
