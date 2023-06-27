#include <stdio.h>
#define MAX_SIZE 100

void first_fit(int mem_size[], int n_mem, int req_size[], int n_req) {
    int alloc[n_req];
    for (int i = 0; i < n_req; i++) {
        alloc[i] = -1;
        for (int j = 0; j < n_mem; j++) {
            if (mem_size[j] >= req_size[i]) {
                alloc[i] = j;
                mem_size[j] -= req_size[i];
                break;
            }
        }
    }
    printf("First Fit:\n");
    printf("Process No.\tProcess Size\tBlock No.\n");
    for (int i = 0; i < n_req; i++) {
        printf("%d\t\t%d\t\t", i+1, req_size[i]);
        if (alloc[i] != -1) {
            printf("%d\n", alloc[i]+1);
        } else {
            printf("Not allocated\n");
        }
    }
}

void best_fit(int mem_size[], int n_mem, int req_size[], int n_req) {
    int alloc[n_req];
    for (int i = 0; i < n_req; i++) {
        alloc[i] = -1;
        int best_index = -1;
        for (int j = 0; j < n_mem; j++) {
            if (mem_size[j] >= req_size[i]) {
                if (best_index == -1 || mem_size[j] < mem_size[best_index]) {
                    best_index = j;
                }
            }
        }
        if (best_index != -1) {
            alloc[i] = best_index;
            mem_size[best_index] -= req_size[i];
        }
    }
    printf("Best Fit:\n");
    printf("Process No.\tProcess Size\tBlock No.\n");
    for (int i = 0; i < n_req; i++) {
        printf("%d\t\t%d\t\t", i+1, req_size[i]);
        if (alloc[i] != -1) {
            printf("%d\n", alloc[i]+1);
        } else {
            printf("Not allocated\n");
        }
    }
}

void worst_fit(int mem_size[], int n_mem, int req_size[], int n_req) {
    int alloc[n_req];
    for (int i = 0; i < n_req; i++) {
        alloc[i] = -1;
        int worst_index = -1;
        for (int j = 0; j < n_mem; j++) {
            if (mem_size[j] >= req_size[i]) {
                if (worst_index == -1 || mem_size[j] > mem_size[worst_index]) {
                    worst_index = j;
                }
            }
        }
        if (worst_index != -1) {
            alloc[i] = worst_index;
            mem_size[worst_index] -= req_size[i];
        }
    }
    printf("Worst Fit:\n");
    printf("Process No.\tProcess Size\tBlock No.\n");
    for (int i = 0; i < n_req; i++) {
        printf("%d\t\t%d\t\t", i+1, req_size[i]);
        if (alloc[i] != -1) {
            printf("%d\n", alloc[i]+1);
        } else {
            printf("Not allocated\n");
        }
    }
}

int main() {
    int n_mem, n_req;
    int mem_size[MAX_SIZE], req_size[MAX_SIZE];

    printf("Enter number of memory blocks: ");
    scanf("%d", &n_mem);
    printf("Enter memory block sizes:\n");
    for (int i = 0; i < n_mem; i++) {
        scanf("%d", &mem_size[i]);
    }

    printf("Enter number of processes: ");
    scanf("%d", &n_req);
    printf("Enter process sizes:\n");
    for (int i = 0; i < n_req; i++) {
        scanf("%d", &req_size[i]);
    }

    first_fit(mem_size, n_mem, req_size, n_req);
    best_fit(mem_size, n_mem, req_size, n_req);
    worst_fit(mem_size, n_mem, req_size, n_req);

    return 0;
}
