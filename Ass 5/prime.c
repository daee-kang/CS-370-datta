#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdatomic.h>
#include <unistd.h>

int isPrime(int);
int isSophie(int);
void *noMutex();
void *noWait();
void *testAndSet();
void *filterLock(void*);
void lock(int, int);
void unlock(int, int);

//globals
//for normal
unsigned long counter = 2;
unsigned long * sophies;
unsigned long sophieIndex = 0;
unsigned long maxValue;
int threadCount = 0;
int visualization = 0;
//for atomics
atomic_ulong atomicCounter = 2;
atomic_ulong atomicSophieIndex = 0;
//tas lock stuff
atomic_bool tasLock = 0;
atomic_bool tasIndex = 0;
//petersen garbage
atomic_int * level; //initialized to 0
atomic_int * victim;
atomic_int * level2;
atomic_int * victim2;
atomic_bool isPrinting = 0;

int main(int argc, char ** argv){
    int lockType = 0;
    char * lockName;

//ARGC CHECK UNIMPORTANT like my life
//************************************************************************************
//************************************************************************************
    if(argc == 1){
        printf("USAGE: ./prime [threadCount] [maxValue] [lockType] [visualization]\n");
        return 0;
    }
    if(argc > 5){
        printf("ERROR: Too many arguments. \n");
        return 0;
    } else if (argc < 5){
        printf("ERROR: Not enough arguments. \n");
        return 0;
    }
    //ARGV CHECK
    threadCount = atoi(argv[1]);
    if(threadCount == 0){
        printf("ERROR: thread count\n");
        return 0;
    }
    maxValue = strtoul(argv[2], NULL, 0);

    lockType = atoi(argv[3]);
    if(lockType < 0 || lockType > 3){
        printf("ERROR: Invalid lock type, must be 0 - 3. \n");
        return 0;
    }

    visualization = atoi(argv[4]);
    if(visualization < 0 || visualization > 1){
        printf("ERROR: visualization flag must be 0 or 1. \n");
        return 0;
    }

    //debug print values
    printf("thread count %d\n", threadCount);
    printf("max value %lu\n", maxValue);
    printf("lock type %d\n", lockType);
    printf("visualization %d\n", visualization);

    if(lockType != 1 && visualization == 1)
      printf("Warning: visualization only applicable for Peterson's algo. \n");

//threading time baby
//************************************************************************************
//************************************************************************************

    sophies = (unsigned long*)malloc(maxValue/2 * sizeof(unsigned long));

    clock_t tStart;
    clock_t tEnd;
    pthread_t *threads = (pthread_t*)malloc(sizeof(pthread_t)*threadCount);

    switch(lockType){
      case 0://no mutex
      {
        lockName = "No mutex";
        tStart = clock();
        for(int i = 0; i < threadCount; i++){
          pthread_create(&threads[i], NULL, &noMutex, NULL);
        }
        for(int i = 0; i < threadCount; i++){
    			pthread_join(threads[i], NULL);
        }
        tEnd = clock();
        break;
      }
      case 1://petersen filter n-thread
      {
        lockName = "Peterson filter lock";
        //lock init
        level = (atomic_int*)malloc((threadCount) * sizeof(atomic_int));
        victim = (atomic_int*)malloc((threadCount + 1) * sizeof(atomic_int));
        level2 = (atomic_int*)malloc((threadCount) * sizeof(atomic_int));
        victim2 = (atomic_int*)malloc((threadCount + 1) * sizeof(atomic_int));

        for(int i = 0; i < threadCount - 1; i++){
          level[i] = 0;
          level2[i] = 0;
          victim[i] = 0;
          victim2[i] = 0;
        }
        tStart = clock();
        for(int i = 0; i < threadCount; i++)
          pthread_create(&threads[i], NULL, &filterLock, (void *)i);
        for(int i = 0; i < threadCount; i++)
          pthread_join(threads[i], NULL);
        tEnd = clock();

        free(level);
        free(level2);
        free(victim);
        free(victim2);

        break;
      }
      case 2://tas
      {
        lockName = "Test and Set";
        tStart = clock();
        for(int i = 0; i < threadCount; i++){
          pthread_create(&threads[i], NULL, &testAndSet, NULL);
        }
        for(int i = 0; i < threadCount; i++){
          pthread_join(threads[i], NULL);
        }
        tEnd = clock();
        break;
      }
      case 3://atomic - no wait
      {
        lockName = "No Wait";
        tStart = clock();
        for(int i = 0; i < threadCount; i++)
          if(pthread_create(&threads[i], NULL, &noWait, NULL) != 0){
            //Error
          }
        for(int i = 0; i < threadCount; i++){
          pthread_join(threads[i], NULL);
        }
        sophieIndex = atomicSophieIndex;
        tEnd = clock();
        break;
      }
    }
    int seconds = (tEnd - tStart) / CLOCKS_PER_SEC;
    int mills = (tEnd - tStart) % (CLOCKS_PER_SEC/1000);

//printing time baby
//******************************************************************************
//******************************************************************************

    //print numbers lol so many
    for(unsigned long i = 0; i < sophieIndex; i++){
      printf("%8lu ", sophies[i]);
      if((i + 1) % 10 == 0)
        printf("\n");
    }

    //stats
    printf("\n");
    printf("Time taken: %d seconds %d ms\n", seconds, mills);
    printf("Number of threads: %d\n", threadCount);
    printf("Lock Type: %s\n", lockName);
    printf("Number of primes between 1 and %lu: %lu\n", maxValue,sophieIndex);

    //mem clean up
    free(sophies);
    free(threads);
    lockName = NULL;
    return 0;
}
int isPrime(int n)
{
    //O(sqrt(n)
    if(n == 2 || n == 3)
      return 1;
    if(n % 2 == 0 || n % 3 == 0)
      return 0;

    for(int i = 5; i * i <= n; i = i + 6)
        if (n % i == 0 || n % (i + 2) == 0)
           return 0;
    return 1;
}

int isSophie(int n){
  if(isPrime(n))
    if(isPrime((2 * n) + 1))
      return 1;
  return 0;
}

void *noMutex(){
  while(counter <= maxValue){
    unsigned long temp = counter++;
    if(isSophie(temp)){
      sophies[sophieIndex] = temp;
      sophieIndex++;
    }
  }
  pthread_exit(NULL);
}

void *noWait(){
  unsigned long temp = atomic_fetch_add(&atomicCounter, 1);
  while(temp <= maxValue){
    if(isSophie(temp)){
      unsigned long sophieIndex2 = atomic_fetch_add(&atomicSophieIndex, 1);
      sophies[sophieIndex2] = temp;
    }
    temp = atomic_fetch_add(&atomicCounter, 1);
  }
  pthread_exit(NULL);
}

void *testAndSet(){
  //INITIAL FETCH FOR COUNTER
  //*****************UNLOCK********************************
  while(atomic_fetch_or(&tasLock, 1)){/*do nothing*/}
  unsigned long currentNumber = counter++;
  atomic_store(&tasLock, 0);
  //*****************LOCK**********************************

  //BEGIN THREAD PROCESS
  while(currentNumber <= maxValue){
    if(isSophie(currentNumber)){
      //*****************UNLOCK********************************
      while(atomic_fetch_or(&tasIndex, 1)){/*donothing*/}
      sophies[sophieIndex++] = currentNumber;
      atomic_store(&tasIndex, 0);
      //*****************LOCK**********************************
    }
    //*****************UNLOCK********************************
    while(atomic_fetch_or(&tasLock, 1)){/*do nothing*/}
    currentNumber = counter++;
    atomic_store(&tasLock, 0);
    //*****************LOCK**********************************
  }
  pthread_exit(NULL);
}

void *filterLock(void* threadID){
  unsigned long currentNumber;
  lock((int)threadID, 1);
  currentNumber = counter++;
  unlock((int)threadID, 1);

  while(currentNumber <= maxValue){
    if(isSophie(currentNumber)){
      lock((int)threadID, 0);
      sophies[sophieIndex++] = currentNumber;
      unlock((int)threadID, 0);
    }
    lock((int)threadID, 1);
    currentNumber = counter++;
    unlock((int)threadID, 1);
  }
  pthread_exit(NULL);
}

void lock(int threadID, int lockNumber){
  atomic_int * l;
  atomic_int * v;
  if(lockNumber == 1){
    l = level;
    v = victim;
  } else {
    l = level2;
    v = victim2;
  }
  for(int i = 1; i < threadCount; i++){

    l[threadID] = i;
    v[i] = threadID;
    if(visualization == 1){
    while(atomic_fetch_or(&isPrinting, 1)){
    }
    for(int j = 0; j < threadCount; j++){
      printf("|-");
      int pppppp = 0;
      for(int u = 0; u < threadCount; u++)
        if(level[u] == j){
          printf("%d-", u);
          pppppp++;
        } else printf("--");
      if(j != threadCount - 1)
        printf("-| level: %d At most %d threads. Victim is: %d\n", j + 1, threadCount - j, victim[j]);
      else
        printf("-| level: %d At most %d threads. Critical Section\n", j + 1, threadCount - j);
    }
    //hey i wanna die lol
    sleep(1);
    printf("\n");
    atomic_store(&isPrinting, 0);
  }
    for(int k = 0; k < threadCount; k++)
      while(k != threadID && (level[k] >= i && victim[i] == threadID)){}
      //visualization
  }
}

void unlock(int threadID, int lockNumber){
  atomic_int * l;
  if(lockNumber == 1)
    l = level;
  else l = level2;
  l[threadID] = 0;
}
