#include <stdlib.h>
#include <stdio.h>
#include "../../data_structures/linked_list/linked_list.h"

/* Problem: Deleting a node in a linked list in O(1)
 *
 * Given a node in a singly linked list, deleting it in
 * constant time appears impossible because its
 * predecessor's next field has to be updated. Surprisingly,
 * it can be done with one small caveat --- the node to
 * delete cannot be the last one in the list and it is easy
 * to copy the value part of a node.
 *
 * (11.9 in AFT)
 *
 * Solution: Elegant solution is to take the pointer to the
 * node (say, 'node') and copy the value of its next node.
 * Then, point the node to its next next node. Then free
 * the next node. Illustration:
 *
 * Say node points to "X"
 *
 * A -> B -> ... -> X -> Y -> Z -> NULL
 *                  ^
 *                  |
 *                 node
 *
 * First, copy the value of the next node:
 *
 * A -> B -> ... -> Y -> Y -> Z -> NULL
 *
 * Then, repoint to Z:
 *
 *                    _______
 *                   /       \
 * A -> B -> ... -> Y    Y -> Z -> NULL
 *
 *
 * Then free the next node:
 *
 * A -> B -> ... -> Y -> Z -> NULL
 *
 * Voila! A singled node deleted out of the list. The caveat,
 * of course, being that you can't do this to the tail.
*/

void delete_node(LL_node *node) {

  LL_node *next_node, *next_next_node;

  next_node      = node->next;
  next_next_node = next_node->next;


  node->value = next_node->value;
  node->next  = next_next_node;

  free( next_node );
};

int main(int argc, char **argv) {

  LL_node *head, *tail, *internal_node, *node;
  int i;

  // Initialize a linked list from 0->100. Set a pointer
  // to point to the 50th element of the array;
  LL_init(&head, &tail, 0.0);
  for (i=1; i<50; i++)
    LL_push(&tail, (double) i);

  internal_node = tail;

  for (i=50; i<100; i++)
    LL_push(&tail, (double) i);

  // Delete the node pointed to by the internal pointer
  delete_node( internal_node );

  // This should print out the numbers 0->99, skipping
  // over the value that was deleted (i.e., 49)
  node = head;
  while (node) {
    printf("%f\n", node->value);
    node = node->next;
  }
};
