struct LL_node {
  double value;
  struct LL_node *next;
  struct LL_node *prev;
};

typedef struct LL_node LL_node;

void LL_init(LL_node **, LL_node **, double);
void LL_push(LL_node **, double);
void LL_unshift(LL_node **, double);

double LL_pop(LL_node **);
double LL_shift(LL_node **);

void LL_free(LL_node **, LL_node **);
