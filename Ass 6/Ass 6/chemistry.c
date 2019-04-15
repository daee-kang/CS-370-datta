#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

//just bool things
#define true 1
#define false 0
typedef char bool;

typedef pthread_cond_t Cond;
typedef pthread_mutex_t Mutex;

//semaphore struct
struct Semaphore {
    int value;
    int wakeups;
    pthread_mutex_t* mutex;
    pthread_cond_t* cond;
};

//function protos
Mutex* make_mutex();
void mutex_lock(Mutex*);
void mutex_unlock(Mutex*);

Cond* make_cond();
void cond_wait(Cond*, Mutex*);
void cond_signal(Cond*);

struct Semaphore * make_semaphore(int);
void _sem_wait(struct Semaphore *);//note: xcode error with conflicting method, renamed with _
void sem_signal(struct Semaphore *);

void* carbon(void*);
void* hydrogen(void*);
void* lithium(void*);

//my global semphore kill me now
struct Semaphore* carbonQueue;
struct Semaphore* carbonMutex;
struct Semaphore* hydrogenQueue;
struct Semaphore* hydrogenMutex;
struct Semaphore* lithiumQueue;
struct Semaphore* lithiumMutex;

int butylMade = 0;


//global waiting
int waitingCarbon = 0;
int waitingHydrogen = 0;
int waitingLithium = 0;

//global assigned
int assignedCarbon = 0;
int assignedHydrogen = 0;
int assignedLithium = 0;



int main(int argc, char ** argv) {
    //--------------------------------------------arg checking
    if(argc == 1){
        printf("Usage: ./chemistry [num of butyllithium]\n");
        exit(1);
    } else if (argc > 2){
        printf("Invalid command. \nUsage: ./chemistry [num of butyllithium]\n");
        exit(1);
    }
    int butyllCount = atoi(argv[1]);
    if(butyllCount < 0){
        printf("Invalid amount of butyllithium, must be positive. \nUsage: ./chemistry [num of butyllithium]\n");
        exit(1);
    }
    
    
    //--------------------------------------------thread making
    int threadCount = butyllCount * 14;
    
    pthread_t *cThreads = (pthread_t*)malloc(sizeof(pthread_t)*(butyllCount * 4));
    pthread_t *hThreads = (pthread_t*)malloc(sizeof(pthread_t)*(butyllCount * 9));
    pthread_t *liThreads = (pthread_t*)malloc(sizeof(pthread_t)*(butyllCount * 1));
    
    //semaphore init
    carbonQueue = make_semaphore(0);
    carbonMutex = make_semaphore(1);
    hydrogenQueue = make_semaphore(0);
    hydrogenMutex = make_semaphore(1);
    lithiumQueue = make_semaphore(0);
    lithiumMutex = make_semaphore(1);

    

    //create
    for(int i = 0; i < butyllCount * 9; i++)
        pthread_create(&hThreads[i], NULL, &hydrogen, (void *)i);
    for(int i = 0; i < butyllCount * 4; i++)
        pthread_create(&cThreads[i], NULL, &carbon, (void *)i);
    for(int i = 0; i < butyllCount * 1; i++)
        pthread_create(&liThreads[i], NULL, &lithium, (void *)i);
    //join
    for(int i = 0; i < butyllCount * 4; i++)
        pthread_join(cThreads[i], NULL);
    for(int i = 0; i < butyllCount * 9; i++)
        pthread_join(hThreads[i], NULL);
    for(int i = 0; i < butyllCount * 1; i++)
        pthread_join(liThreads[i], NULL);

    free(cThreads);
    free(hThreads);
    free(liThreads);
    free(carbonQueue);
    free(hydrogenQueue);
    free(lithiumQueue);
    free(lithiumMutex);
    free(carbonMutex);
    free(hydrogenMutex);
    
    return 0;
}
void* hydrogen(void* threadID){
    printf("\033[0m Hydrogen atom (%d) started\n", (int)threadID);

    _sem_wait(hydrogenMutex);

    waitingHydrogen++;
    while(assignedHydrogen == 0){
        if(waitingCarbon >= 4 && waitingHydrogen >= 9 && waitingLithium >= 1){
            //make butyl
            waitingCarbon -= 4;
            waitingHydrogen -= 9;
            waitingLithium -= 1;
            assignedCarbon += 4;
            assignedHydrogen += 9;
            assignedLithium += 1;
            
            butylMade++;
            printf("\033[0;34m N-Butyllithium (%d) made\n", butylMade);
            sleep(2);

            for(int i = 0; i < 1; i++){
                sem_signal(lithiumQueue);
            }
            for(int i = 0; i < 4; i++){
                sem_signal(carbonQueue);
            }
            for(int i = 0; i < 9; i++){
                sem_signal(hydrogenQueue);
            }
        } else {
            printf("\033[0;31m Hydrogen atom (%d) waiting\n", (int)threadID);
            sem_signal(hydrogenMutex);
            _sem_wait(hydrogenQueue);
            _sem_wait(hydrogenMutex);
        }
    }
    assignedHydrogen -= 1;
    sem_signal(hydrogenMutex);
    printf("\033[0;32m Hydrogen atom (%d) done\n", (int)threadID);
    return NULL;
}
void* carbon(void* threadID){
    printf("\033[0m Carbon atom (%d) started\n", (int)threadID);

    _sem_wait(carbonMutex);

    waitingCarbon++;
    while(assignedCarbon == 0){
        if(waitingCarbon >= 4 && waitingHydrogen >= 9 && waitingLithium >= 1){
            //make butyl
            waitingCarbon -= 4;
            waitingHydrogen -= 9;
            waitingLithium -= 1;
            assignedCarbon += 4;
            assignedHydrogen += 9;
            assignedLithium += 1;
            butylMade++;
            printf("\033[0;34m N-Butyllithium (%d) made\n", butylMade);
            sleep(2);

            for(int i = 0; i < 1; i++){
                sem_signal(lithiumQueue);
            }
            for(int i = 0; i < 9; i++){
                sem_signal(hydrogenQueue);
            }
            for(int i = 0; i < 4; i++){
                sem_signal(carbonQueue);
            }
        } else {
            printf("\033[0;31m Carbon atom (%d) waiting\n", (int)threadID);
            sem_signal(carbonMutex);
            _sem_wait(carbonQueue);
            _sem_wait(carbonMutex);
        }
    }
    assignedCarbon -= 1;
    sem_signal(carbonMutex);
    printf("\033[0;32m Carbon atom (%d) done\n", (int)threadID);
    return NULL;
}
void* lithium(void* threadID){
    printf("\033[0m Lithium atom (%d) started\n", (int)threadID);

    _sem_wait(lithiumMutex);

    waitingLithium++;
    while(assignedLithium == 0){
        if(waitingCarbon >= 4 && waitingHydrogen >= 9 && waitingLithium >= 1){
            //make butyl
            waitingCarbon -= 4;
            waitingHydrogen -= 9;
            waitingLithium -= 1;
            assignedCarbon += 4;
            assignedHydrogen += 9;
            assignedLithium += 1;
            butylMade++;
            printf("\033[0;34m N-Butyllithium (%d) made\n", butylMade);
            sleep(2);

            for(int i = 0; i < 4; i++){
                sem_signal(carbonQueue);
            }
            for(int i = 0; i < 9; i++){
                sem_signal(hydrogenQueue);
            }
            sem_signal(lithiumQueue);
        } else {
            printf("\033[0;31m Lithium atom (%d) waiting\n", (int)threadID);
            sem_signal(lithiumMutex);
            _sem_wait(lithiumQueue);
            _sem_wait(lithiumMutex);
        }
    }
    assignedLithium -= 1;
    sem_signal(lithiumMutex);
    printf("\033[0;32m Lithium atom (%d) done\n", (int)threadID);
    return NULL;
}


//----------------------MUTEX FUNCTIONS--------------------------------//
Mutex* make_mutex(){
    Mutex *mutex = malloc(sizeof(Mutex));
    int n = pthread_mutex_init(mutex, NULL);
    if(n != 0){
        perror("make_mutex failed");
        exit(1);
    }
    return mutex;
}

void mutex_lock(Mutex *mutex){
    int n = pthread_mutex_lock(mutex);
    if(n != 0){
        perror("mutex_lock failed");
        exit(1);
    }
}

void mutex_unlock(Mutex *mutex){
    int n = pthread_mutex_unlock(mutex);
    if(n != 0){
        perror("mutex_unlock failed");
        exit(1);
    }
}

//----------------------MUTEX FUNCTIONS--------------------------------//



//----------------------CONDI FUNCTIONS--------------------------------//
Cond* make_cond(){
    Cond* cond = malloc(sizeof(Cond));
    int n = pthread_cond_init(cond, NULL);
    if(n != 0){
        perror("make_cond failed");
        exit(1);
    }
    return cond;
}

void cond_wait(Cond* cond, Mutex* mutex){
    int n = pthread_cond_wait(cond, mutex);
    if(n != 0){
        perror("cond_wait failed");
        exit(1);
    }
}

void cond_signal(Cond* cond){
    int n = pthread_cond_signal(cond);
    if(n != 0){
        perror("cond_signal failed");
        exit(1);
    }
}
//----------------------CONDI FUNCTIONS--------------------------------//

//----------------------SEMAP FUNCTIONS--------------------------------//
struct Semaphore* make_semaphore(int value){
    struct Semaphore* semaphore = malloc(sizeof(struct Semaphore));
    semaphore->value = value;
    semaphore->wakeups = 0;
    semaphore->mutex = make_mutex();
    semaphore->cond = make_cond();
    return semaphore;
}
void _sem_wait(struct Semaphore* semaphore){
    mutex_lock(semaphore->mutex);
    semaphore->value = semaphore->value - 1;
    if(semaphore->value < 0){
        while(semaphore->wakeups < 1)
            cond_wait(semaphore->cond, semaphore->mutex);
        semaphore->wakeups = semaphore->wakeups - 1;
    }
    mutex_unlock(semaphore->mutex);
}
void sem_signal(struct Semaphore* semaphore){
    mutex_lock(semaphore->mutex);
    semaphore->value = semaphore->value + 1;
    if(semaphore->value <= 0){
        semaphore->wakeups = semaphore->wakeups + 1;
        cond_signal(semaphore->cond);
    }
    mutex_unlock(semaphore->mutex);
}
//----------------------SEMAP FUNCTIONS--------------------------------//

