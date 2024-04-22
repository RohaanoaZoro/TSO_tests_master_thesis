#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#include "enable_tso.h"

#define NUM_READERS 2
#define NUM_WRITERS 2

// Shared data
int data = 0;
sem_t mutex, writeblock;
int readerCount = 0;

// Reader function
void *reader(void *arg) {
    int id = *((int *)arg);
//    while (1) {
        sem_wait(&mutex);
        readerCount++;
        if (readerCount == 1) {
            sem_wait(&writeblock);
        }
        sem_post(&mutex);
        printf("Reader %d read data: %d\n", id, data);
        sem_wait(&mutex);
        readerCount--;
        if (readerCount == 0) {
            sem_post(&writeblock);
        }
        sem_post(&mutex);
//    }
    pthread_exit(NULL);
}

// Writer function
void *writer(void *arg) {
    int id = *((int *)arg);
//    while (1) {
        sem_wait(&writeblock);
        data++;
        printf("Writer %d wrote data: %d\n", id, data);
        sem_post(&writeblock);
//    }
    pthread_exit(NULL);
}

int main() {
    pthread_t readers[NUM_READERS], writers[NUM_WRITERS];
    int readerIds[NUM_READERS];
    int writerIds[NUM_WRITERS];
    
    sem_init(&mutex, 0, 1);
    sem_init(&writeblock, 0, 1);
    
    pthread_t thread;

    
    // Create writer threads
    for (int i = 0; i < NUM_WRITERS; i++) {
        writerIds[i] = i + 1;
//        pthread_create(&writers[i], NULL, writer, &writerIds[i]);
        
        // Call the overridden pthread_create function
        int result = pthread_create_interpose.overriden_pthread_create(&writers[i], NULL, writer, &writerIds[i]);
        
        if (result == 0) {
            printf("Successfull executed the reader TSO threads: %d\n", result);
        }
    }

    // Create reader threads
    for (int i = 0; i < NUM_READERS; i++) {
        readerIds[i] = i + 1;
//        pthread_create(&readers[i], NULL, reader, &readerIds[i]);

        // Call the overridden pthread_create function
        int result = pthread_create_interpose.overriden_pthread_create(&readers[i], NULL, reader, &readerIds[i]);
        
        if (result == 0) {
            printf("Successfull executed the writer TSO threads: %d\n", result);
        }
        
    }

    // Join threads
    for (int i = 0; i < NUM_READERS; i++) {
        pthread_join(readers[i], NULL);
    }
    for (int i = 0; i < NUM_WRITERS; i++) {
        pthread_join(writers[i], NULL);
    }

    sem_destroy(&mutex);
    sem_destroy(&writeblock);

    return 0;
}
