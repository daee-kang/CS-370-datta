#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
//yas
const int CPU_ITERATIONS = 10000000;

int main(int argc, char *argv[]){
  //------------------------COMMAND LINE ARGUMENTS-----------------------//
  //arg count check
  if(argc > 2){
    printf(1, "Error, too many arguments.\nUsage: benchmark <file>.txt\n");
    exit();
  }
  if(argc == 1){
    printf(1, "Usage: benchmark <file>.txt\n");
    exit();
  }

  //arg content check
  //check file extention
  int length = strlen(argv[1]);
  if(argv[1][length-4] != '.' || argv[1][length-3] != 't' ||
  argv[1][length-2] != 'x' || argv[1][length-1] != 't'){
    printf(1, "Invalid file extension.\nUsage: benchmark <file>.txt\n");
    exit();
  }

  //--------------------------PARSE INPUT FILE--------------------------//
  //open file
  int fd = open(argv[1], O_RDONLY);
  if(fd == -1){
    printf(1, "Read error: File not found.\n");
    exit();
  }

  //setup input table (first col will hold total cpu bursts)
  //each row a different process
  //so 1.totalCpuBurst 2.CpuBurst 3.IOBurst ... and so on

  //read in chars
  char buf[512];int n;

  for(;;){
    n = read(fd, buf, sizeof buf);
    if(n == 0)//eof
    break;
    if(n < 0){
      printf(1, "read error\n");//read error
      exit();
    }

    int wordIndex = 0;
    int lineIndex = 0;
    int arrayIndex = 0;
    int totalDigits = 0;

    int w = 0;

    //read first line;
    int digits = 1;
    // while(buf[w + 1] != '\n' || buf[w + 1] != 00 || buf[w + 1] != ' '){
    //   printf(1, "im in it boi %d\n", w);
    //   w++;
    //   digits *= 10;
    // }
    int i = 0;
    uint numberOfProcesses= 0;
    for(i = 0; i < w + 1; i++){
      numberOfProcesses += digits * (int)(buf[i] - '0');
      digits /= 10;
    }

    int ** processes = (int **)malloc(numberOfProcesses * sizeof(int*));

    for(; i < numberOfProcesses; i++){
      processes[i] = (int*)malloc(11 * sizeof(int*));
    }

    for(i = 0; i < numberOfProcesses; i++){
      int m = 0;
      for(m = 0; m < 11; m++)
        processes[i][m] = -1;
    }
    printf(1, "\n----input------\n");
    printf(1, "NUMBER OF PROCESSES %d \n", numberOfProcesses);
    if(numberOfProcesses == 0)
    exit();
    w += 2;
    wordIndex = w;

    while(buf[w] != 00){
      //printf(1, "im in it boi %d\n", w);
      if(buf[w] == ' '){
        //convert to digit
        int number = 0;
        int power = 1;
        for(i = 1; i < totalDigits; i++)
        power *= 10;
        for(i = wordIndex; i < w; i++){
          number += (int)(buf[i] - '0') * power;
          power /= 10;
        }
        totalDigits = 0;

        processes[lineIndex][arrayIndex] = number;
        printf(1, "%d ", processes[lineIndex][arrayIndex]);
        arrayIndex++;
        w++;
        wordIndex = w;
      } else if (buf[w] == '\n' || buf[w] == 00){
        int number = 0;
        int power = 1;
        for(i = 1; i < totalDigits; i++)
        power *= 10;
        for(i = wordIndex; i < w; i++){
          number += (int)(buf[i] - '0') * power;
          power /= 10;
        }
        totalDigits = 0;
        processes[lineIndex][arrayIndex] = number;
        printf(1, "%d \n", processes[lineIndex][arrayIndex]);
        arrayIndex = 0;
        w++;
        wordIndex = w;
        lineIndex++;
      } else {
        totalDigits++;
        w++;
      }
    }
    printf(1, "------END------\n\n");

    //numbers are read in at this point and array is set.
    //time to execute stuff

    int sTime = uptime();
    for(i = 0; i < numberOfProcesses; i++){
      int currentTime = uptime();
      if(processes[i][0] > (currentTime - sTime)){
        sleep(processes[i][0] - (currentTime - sTime));
      }
      int pid = fork2(processes[i][1]);
      if(pid == 0){
        //   //child time
        int count = 0;
        pid = getpid();
        int j = 0;
        for(j = 0; j < processes[i][3] * CPU_ITERATIONS; j++){
          count++;
        }
        for(j = 4; processes[i][j]!=-1; j++){
          int h = 0;
          if(j % 2 != 1)
          for(h = 0; h < processes[i][j]; h++)
          printf(1, "Child %d prints for the %d time\n", pid, h + 1);
          else
          for(h = 0; h < processes[i][j] * CPU_ITERATIONS; h++)
          count++;
        }

        exit();
      }
    }
    //pids array, holds pid id and all other values
    int ** pids = (int**)malloc(numberOfProcesses * sizeof(int*));
    for(i = 0; i < numberOfProcesses; i++)
      pids[i] = (int*)malloc(9 * sizeof(int *));
    for(i = 0; i < numberOfProcesses; i++){
      //fcall wait2 syscall
      int creationTime, startTime, runTime, ioTime, endTime;
      pids[i][0] = wait2(&creationTime, &startTime, &runTime, &ioTime, &endTime);
      //boom boom boom store information
      pids[i][1] = creationTime;
      pids[i][2] = startTime;
      pids[i][3] = endTime;
      pids[i][4] = ioTime;
      pids[i][5] = runTime;
      //wait time
      pids[i][6] = endTime - creationTime - runTime - ioTime;
      //tttime
      pids[i][7] = endTime - creationTime;
      //response time
      pids[i][8] = startTime - creationTime;
    }

    for(i = 0; i < numberOfProcesses; i++){
      //print out
      printf(1, "child %d: ctime - %d - stime %d - etime - %d\n",
      pids[i][0], pids[i][1], pids[i][2], pids[i][3]);
      printf(1, "iotime - %d - rtime - %d - wtime - %d\n",
      pids[i][4], pids[i][5], pids[i][6]);
      printf(1, "turnaround time - %d - response time - %d\n",
      pids[i][7], pids[i][8]);
    }

    int averagett = 0, averageResponseTime = 0;
    for(i = 0; i < numberOfProcesses; i++){
      averagett += pids[i][7];
      averageResponseTime += pids[i][8];
    }
    averagett /= numberOfProcesses;
    averageResponseTime /= numberOfProcesses;
    printf(1, "Avg TAT: %d\n", averagett);
    printf(1, "Avg Response: %d\n", averageResponseTime);

    //cl3@n up T1m3
    for(i = 0; i < numberOfProcesses; i++){
      free(pids[i]);
    }
    free(pids);
    free(processes);
  }
  close(fd);
  exit();
}
