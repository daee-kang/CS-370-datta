#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
	int pid = fork();
	if(pid > 0){
		printf(1, "Inside Parent Process: child id = %d \n", pid);
		pid = wait();
		printf(1, "Child %d is done executing \n", pid);
	} else if(pid == 0){
		char *argv[3];
		argv[0] = "echo";
		argv[1] = "Hello xv6 world";
		argv[2] = 0;
		
	
		exec(argv[0], argv);

		exit();
	} else {
		printf(1, "error");
	}

	exit();
}
