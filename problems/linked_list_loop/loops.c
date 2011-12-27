/* Loops in Linked List
 *
 * Problem: Given a linked list, determine if the list has any loops in it. E.g.,
 *
 *     A -> B -> C -> D -> E -> ... -> NULL (No Loops)
 *     A -> B -> C -> D -> E -> ... -> C    (Loops back to C)
 *
 * Assume that you can't use any extra data structures to store anything.
 *
 * Solution:
 *
 * First, think of the loop in the linked list as a "racetrack":
 *
 *            A  -> B ->  C
 *            |           |
 *            Z <- ... <- D
 *
 * Now, in a closed loop, if we have two runners that both start at node A but
 * run at different rates, then one will eventually "lap" the other runner if
 * there is a closed loop. If the fast runner hits the end of the linked list
 * before lapping the slow runner, then the linked list doesn't contain a loop!
 *
 * This is the solution presented below, implemented in the method
 * "contains_loop." The method starts two pointers, one "fast" and the other one
 * "slow" at the head of the linked list. The "fast" pointer loops advances by
 * one node through each passage of the while loop; the "slow" pointer only
 * advances to the next node every 100 steps. Each trip through the loop, the
 * fast pointer checks to see if it's equal to the slow pointer. If it is, then
 * there is a loop. If the fast_pointer reaches the end of the linked list
 * before reaching the slow pointer, then the linked list is linear and doesn't
 * contain any loops.
 */

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "../../data_structures/linked_list/linked_list.h"

bool contains_loop(LL_node *head) {

  LL_node *ptr_fast, *ptr_slow;
  int i;

  i = 0;
  ptr_fast = ptr_slow = head;

  while (ptr_fast->next) {
    i++;

    if (i%100 == 0)
      ptr_slow = ptr_slow->next; // Only advance slow pointer every 100 steps

    ptr_fast = ptr_fast->next;   // Meanwhile, advance fast pointer every step

    if ((ptr_fast == ptr_slow) && (i>1))
      return true;
  }

  return false;
};


int main(int argc, char *argv) {
  int i;
  LL_node *head, *tail, *node;

  // Init the linked list using doubles from 0.0 -> 999.0
  LL_init(&head, &tail, 0.0);
  for (i=1; i<1000; i++) {
    LL_push(&tail, 1.0*i);
  }

  // Force the tail to loop back on itself
  tail->next = head;

  printf("Does this linked list contain a loop? %s\n", (contains_loop(head) ? "Yes" : "No"));

  return 0;
};

