#include "types.h"
#include "stat.h"
#include "user.h"
#include "date.h"

int main(int argc, char **argv){
//bools wish i had my bools 
int print12 = 0;
int isPos = 0;
int isTimeZone = 0;

int num;

//argument checking
  int argCounter = 1;
  //check arg count
  if(argc > 4){
    printf(1, "Invalid arg count\n");
    exit();
  } 
  //check arg content
  if(strlen(argv[1]) == 1 && (argv[1][0] == '0' || argv[1][0] == '1')){
    if(argv[1][0] == '1') print12 = 1;
    argCounter++;
  } else if (argc == 1){
    //lol
  } else if (!(strlen(argv[argCounter]) == 2 && (argv[argCounter][0] == '-' && argv[argCounter][1] == 't'))){
    printf(1, "Invalid arguments.\n");
    exit();
  } 

  if (strlen(argv[argCounter]) == 2 && (argv[argCounter][0] == '-' && argv[argCounter][1] == 't') && argc >= 3){
    isTimeZone = 1;
    argCounter++;
    //check bounds {-12, 10}
    if(strlen(argv[argCounter]) > 3 || strlen(argv[argCounter]) <= 1){
      printf(1, "Incorrect time zone my dude\n");
      exit();
    }
    //below code is sloppy af please ignore
    if(argv[argCounter][0] == '+' || argv[argCounter][0] == '-'){
      if(argv[argCounter][0] == '+') isPos = 1;
      //single num
      if(strlen(argv[argCounter]) == 2){
        num = (int)(argv[argCounter][1] - '0');
      } else {
        num = (int)(argv[argCounter][2] - '0');
        num += 10 * (int)(argv[argCounter][1] - '0');
      }
      if(isPos){
        if(num > 14){
          printf(1, "Incorrect time zone my dude\n");
          exit();
        } else if(num < 0) {
          printf(1, "How'd u get here lol\n");
          exit();
        }
      } else {
        if(num > 12){
          printf(1, "Incorrect time zone my dude\n");
          exit();
        }
      }
    } else {
      printf(1, "Incorrect time zone my dude\n");
      exit();
    }
  } else if (argc != argCounter){
    printf(1, "Invalid Argument.\n");
    exit();
  }
//wow arg check done that's some terrible code 

//SYS CALL TIME
  struct rtcdate *time = (struct rtcdate *) malloc(sizeof(struct rtcdate)); 
  getDate(time);

//computation for time zone 

if(isTimeZone) {//lol here we go
    int newHour; 
    if(isPos){
      newHour = time->hour + num;
      if(newHour > 24){
        //check to see if it flows over to next month
        int lastday;
        switch(time->month){
          case 1:
          case 3:
          case 5:
          case 7:
          case 8:
          case 10:
          case 12:
            lastday = 31;
            break;
          case 4:
          case 6:
          case 9:
          case 11:
            lastday = 30;
            break;
          case 2 : 
            lastday = 28;
            break;
          default: 
            printf(1, "ur not supposed to be here\n");
            exit();
            break;
          }
        if(time->day == lastday){
          time->day = 1;
          //check new years
          if(time->month == 12){
            time->month = 1;
            time->year++;
          } else time->month++;
        } else time->day++;
        newHour -= 24;
      }
      time->hour = newHour;
    } else {
      newHour = time->hour - num;
      if(newHour < 0){
        //check to see if it goes back a month
        int lastday;
        int newMonth = time->month - 1;
        if(newMonth == 0)
          newMonth = 12;
        switch(newMonth){
          case 1:
          case 3:
          case 5:
          case 7:
          case 8:
          case 10:
          case 12:
            lastday = 31;
            break;
          case 4:
          case 6:
          case 9:
          case 11:
            lastday = 30;
            break;
          case 2 : 
            lastday = 28;
            break;
          default: 
            printf(1, "ur not supposed to be here\n");
            exit();
            break;
          }
        if(time->day == 1){
          //check new years
          if(time->month == 1){
            time->year--;
            time->month = 12;
            time->day = 31;
          } else {
            time->month--;
            time->day = lastday;
          }
        } else time->day--;
        newHour += 24;
      }
      time->hour = newHour;
    }
  }

  int isPm = 0;
  //only get am or pm if non-military time
  if(print12){
    if(time->hour/12 == 1){
      isPm = 1;
    }
    time->hour = time->hour % 12; 
  }  

//printing time
  printf(1, "The date is: ");
  printf(1, "%d:", time->hour);
  //ternary time
  (time->minute < 10) ? printf(1, "0%d:", time->minute) : printf(1, "%d:", time->minute);
  (time->second < 10) ? printf(1, "0%d ", time->second) : printf(1, "%d ", time->second);

  //print am or pm
  if(print12){
    if(isPm){
      printf(1, "PM ");
    } else printf(1, "AM ");
  }
  
  //print date
  printf(1, "on %d/%d/%d.\n", time->month, time->day, time->year);
  
  //goodbye
	free(time);
  exit();
}
