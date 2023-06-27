#include <stdio.h>

int lru(int frames[], int pages[], int n_frames, int n_pages)
{
    int cache[n_frames];
    int page_faults = 0;
    int i, j, k, min;

    for (i = 0; i < n_pages; i++)
    {
        int found = 0;
        for (j = 0; j < n_frames; j++)
        {
            if (cache[j] == pages[i])
            {
                found = 1;
                break;
            }
        }
        if (!found)
        {
            min = 0;
            for (j = 1; j < n_frames; j++)
            {
                if (frames[j] < frames[min])
                {
                    min = j;
                }
            }
            cache[min] = pages[i];
            frames[min] = i;
            page_faults++;
        }
    }
    return page_faults;
}

int fifo(int frames[], int pages[], int n_frames, int n_pages)
{
    int cache[n_frames];
    int page_faults = 0;
    int i, j, k, oldest;

    for (i = 0; i < n_pages; i++)
    {
        int found = 0;
        for (j = 0; j < n_frames; j++)
        {
            if (cache[j] == pages[i])
            {
                found = 1;
                break;
            }
        }
        if (!found)
        {
            oldest = 0;
            for (j = 1; j < n_frames; j++)
            {
                if (frames[j] < frames[oldest])
                {
                    oldest = j;
                }
            }
            cache[oldest] = pages[i];
            frames[oldest] = i;
            page_faults++;
        }
    }
    return page_faults;
}

int optimal(int frames[], int pages[], int n_frames, int n_pages)
{
    int cache[n_frames];
    int page_faults = 0;
    int i, j, k, max, index;

    for (i = 0; i < n_pages; i++)
    {
        int found = 0;
        for (j = 0; j < n_frames; j++)
        {
            if (cache[j] == pages[i])
            {
                found = 1;
                break;
            }
        }
        if (!found)
        {
            max = 0;
            for (j = 0; j < n_frames; j++)
            {
                int found2 = 0;
                for (k = i + 1; k < n_pages; k++)
                {
                    if (cache[j] == pages[k])
                    {
                        found2 = 1;
                        break;
                    }
                }
                if (!found2)
                {
                    max = j;
                    break;
                }
                if (frames[j] > frames[max])
                {
                    max = j;
                }
            }
            cache[max] = pages[i];
            frames[max] = i;
            page_faults++;
        }
    }
    return page_faults;
}

int main()
{
    int n_frames, n_pages;
    printf("Enter the number of frames: ");
    scanf("%d", &n_frames);
    printf("Enter the number of pages: ");
    scanf("%d", &n_pages);
    int frames[n_frames], pages[n_pages];
    printf("Enter the pages: ");
    for (int i = 0; i < n_pages; i++)
    {
        scanf("%d", &pages[i]);
    }

    // LRU
    int page_faults = lru(frames, pages, n_frames, n_pages);
    printf("LRU: %d page faults\n", page_faults);

    // FIFO
    page_faults = fifo(frames, pages, n_frames, n_pages);
    printf("FIFO: %d page faults\n", page_faults);

    // Optimal
    page_faults = optimal(frames, pages, n_frames, n_pages);
    printf("Optimal: %d page faults\n", page_faults);

    return 0;
}

