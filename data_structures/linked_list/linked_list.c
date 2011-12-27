#include <stdlib.h>
#include <stdio.h>

/* Linked List (C)
 *
 * A linked list is a data structure that consists of nodes. Each node stores
 * some bit of data, and contains pointers to the next node (if singly-linked)
 * or the previous node (if double-linked). A singly-linked list starts with a
 * pointer to the head of the list:
 *
 *   HEAD -> node1 -> node2 -> node3 -> ... -> NULL
 *
 * while a double-linked LIST looks like this:
 *
 *   HEAD <-> node1 <-> node2 <-> node3 <-> ... <-> TAIL
 *
 * A doubly-linked list allows traversal in the reverse direction.
 *
 */
struct LL_node {
  double value;         // The data
  struct LL_node *next; // Pointer to the next node
  struct LL_node *prev; // Pointer to the previous node
};

typedef struct LL_node LL_node;

void LL_init(LL_node **head, LL_node **tail, double value) {

  LL_node *node;

  node = malloc( sizeof(LL_node) );
  node->value = value;
  node->next  = NULL;
  node->prev  = NULL;

  *head = node;
  *tail = *head;
};

void LL_push(LL_node **tail, double value) {
  LL_node *node;

  node = malloc( sizeof(LL_node) );
  node->value = value;
  node->next  = NULL;
  node->prev  = *tail;

  (*tail)->next = node;
  *tail = node;
};

void LL_unshift(LL_node **head, double value) {
  LL_node *node;

  node = malloc( sizeof(LL_node) );
  node->value = value;
  node->next  = *head;
  node->prev  = NULL;

  (*head)->prev = node;
  *head = node;
};

double LL_pop(LL_node **tail) {

  LL_node *popped;
  double popped_value;

  popped = *tail;
  popped_value = popped->value;

  *tail = popped->prev;
  free( popped );

  return popped_value;
};

double LL_shift(LL_node **head) {
  LL_node *unshifted;
  double unshifted_value;

  unshifted = *head;
  unshifted_value = unshifted->value;

  *head = unshifted->next;
  free( unshifted );

  return unshifted_value;
};

void LL_free(LL_node **head, LL_node **tail) {

  LL_node *curr_node, *stale_node;

  curr_node = *tail;

  while (curr_node->prev) {
    stale_node = curr_node;
    curr_node  = curr_node->prev;
    free(stale_node);
  }

  *head = NULL;
  *tail = NULL;
};
