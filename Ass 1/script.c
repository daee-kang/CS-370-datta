#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
	//command line arguments
	if(argc > 3){
		printf(1, "Error, Too many arguments \n");
		exit();
	}
	if(argc == 1){
		printf(1, "Usage: script <file>.sh {0, 1} \n");
		exit();
	}

	//check argv[1] if valid file extension
	int length = strlen(argv[1]);
	if(argv[1][length-3] != '.' || argv[1][length-2] != 's' || argv[1][length-1] != 'h'){
		printf(1, "invalid file extension\n");
		exit();
	}

	//get print argument
	int printOut = 0;
	if(argc == 3 && strlen(argv[2]) == 1 && argv[2][0] == '1'){
		printOut = 1;
	} else if (argc == 3 && strlen(argv[2]) == 1 && argv[2][0] == '0'){
		printOut = 0;
	} else if (argc == 2) {
		printOut = 0;
	} else{
		printf(1, "invalid print Argument \n");
		exit();
	}
	
	//open file
	int fd = open(argv[1], O_RDONLY);
	if(fd == -1){
		printf(1, "Error, file not found \n");
		exit();
	}

	//read file - straight from textbook lol
	char buf[512];
	int n;

	for(;;){
		n = read(fd, buf, sizeof buf);
		if(n == 0)
			break;
		if(n < 0){
			printf(1, "read error\n");
			exit();
		}

		//setup arg array
		char** args = (char **)malloc(10 * sizeof(char*));
		int i = 0;
		for(; i < 10; i++){
			args[i] = (char*)malloc(128 * sizeof(char*));
			memset(args[i], 0, 128*sizeof(char));
		}

		int wordIndex = 0;
		int argIndex = 0;
		int w = 0; 

		while(buf[w] != 00){
			if(buf[w] == ' '){
				memmove(args[argIndex], buf + wordIndex, w - wordIndex);
				//printf(1, "%s", args[argIndex]);
				argIndex++;
				w++;
				wordIndex = w;
				//memset
			} else if (buf[w] == '\n' || buf[w] == 00){
				memmove(args[argIndex], buf + wordIndex, w - wordIndex);
				w++;
				wordIndex = w;

				argIndex++;
				args[argIndex] = 0;

				int pid = fork();

				if(pid > 0){
					pid = wait();
				} else if(pid == 0){
					if(printOut == 1){
						int k = 0; 
						for(; k < argIndex; k++)
							printf(1, "%s ", args[k]);
						printf(1, "\n");
					}
					exec(args[0], args);
					exit();

				} else {
					printf(1, "pid error");
				}
				argIndex = 0;
				for(i = 0; i < 10; i++){
					args[i] = (char *) malloc(128 * sizeof(char *));
					memset(args[i], 0, 128*sizeof(char));
				}
			} else {
				w++;
			}
		}

		//cL3@N UP TYME!!11!
		int x = 0;
		for(; x < 10; x++){
			free(args[x]);
		}
		free(args);
		break;
	}
//have a beautiful time!!!
	exit();
}
