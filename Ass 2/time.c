#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char **argv){
	//argument checking, usage message display
	if(argc == 1){
		printf(1, "Usage: time {-s} [execution stuff here]\n");
		exit();
	}

	//check to see if there is an argument to print out time in seconds
	//secondDisplay is used later to align args when putting into exec
	int length = strlen(argv[1]);
	int secondDisplay = 0;
	if(length == 2){
		if(argv[1][0] == '-' && argv[1][1] =='s'){
			secondDisplay = 1;
		}
	}
	
	//allocate mem for new args
	char** args = (char **)malloc(10 * sizeof(char*));
	int i = 0;
	for(; i < 10; i++){
		args[i] = (char*)malloc(128 * sizeof(char*));
		memset(args[i], 0, 128*sizeof(char));
	}

	//put new args into a new argv type array
	//if secondDisplay, starts from argv[2] onwards skipping argv[1] and 2
	i = 1;
	int cutby = 0;
	if(secondDisplay){
		i = 2;
		cutby = 1;
	}
	for(; i < argc; i++){
		args[i - 1 - cutby] = argv[i];
	}
	args[i - 1 - cutby] = 0;


	//fork time
	int pid = fork();
	if(pid > 0){
		//calculate time here
		int uptime1 = uptime();
		pid = wait();
		int uptime2 = uptime();
		int waitTime = uptime2-uptime1;
		if(secondDisplay == 1){
			int seconds = waitTime / 100;
			int afterSeconds = waitTime % 100;
			printf(1, "wait time (seconds): %d.%d\n",seconds, afterSeconds);
		}
		else printf(1, "wait time (ticks): %d\n", waitTime);
	} else if(pid == 0){
		exec(args[0], args);

		exit();
	} else {
		printf(1, "pid error");
		exit();
	}
	
	//CLEAN UP TIME
	for(i = 0; i < 10; i++){
		args[i] = (char *) malloc(128 * sizeof(char *));
		memset(args[i], 0, 128*sizeof(char));
	}	
	for(i = 0;i < 10; i++){
		free(args[i]);
	}
	free(args);
	
	//goodbye
	exit();
}
