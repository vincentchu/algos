#include <stdlib.h>
#include <stdio.h>
#include "../../data_structures/linked_list/linked_list.h"

/* You have two numbers represented by a linked list, where
 * each node contains a single digit The digits are stored
 * in reverse order, such that the 1’s digit is at the head
 * of the list Write a function that adds the two numbers
 * and returns the sum as a linked list
 *
 * EXAMPLE
 * Input: (3 -> 1 -> 5) + (5 -> 9 -> 2)
 * Output: 8 -> 0 -> 8
 *
 * Solution:
 *
 * Traverse the linked lists. Compute the sum of the values
 * in each corresonding node, compute the remainder and the
 * carry. Push this on the answer linkled list.
 *
 * Note: The following solution doesn't check to see if the
 * lenghts of the two linked lists are equal.
*/

void LL_add(LL_node **head_result, LL_node **tail_result, LL_node *num1, LL_node *num2) {
  LL_node *node1, *node2;
  int sum, remainder, carry;


  *head_result = *tail_result = NULL;
  node1 = num1;
  node2 = num2;

  carry = 0;
  while (num1) {

    sum       = (int) (num1->value + num2->value) + carry;
    remainder = (sum % 10);
    carry     = (sum / 10);

    if (*head_result == NULL)
      LL_init(head_result, tail_result, (double) remainder);
    else
      LL_push(tail_result, (double) remainder);

    num1 = num1->next;
    num2 = num2->next;
  };
};

void LL_print(LL_node *head) {
  LL_node *node;

  node = head;
  while (node) {
    if (node->next)
      printf("%d -> ", (int)node->value);
    else
      printf("%d\n", (int)node->value);
    node = node->next;
  }
};

int main(int argc, char **argv) {

  LL_node *head1, *head2, *tail1, *tail2, *head_res, *tail_res;

  LL_init(&head1, &tail1, 3.0);
  LL_push(&tail1, 1.0);
  LL_push(&tail1, 5.0);

  LL_init(&head2, &tail2, 5.0);
  LL_push(&tail2, 9.0);
  LL_push(&tail2, 2.0);

  LL_add(&head_res, &tail_res, head1, head2);

  printf("Number 1:\n");
  LL_print(head1);

  printf("Number 2:\n");
  LL_print(head2);

  printf("Answer:\n");
  LL_add(&head_res, &tail_res, head1, head2);
  LL_print(head_res);
};
