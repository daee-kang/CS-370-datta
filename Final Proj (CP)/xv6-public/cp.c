#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"

//copied and pasted functions from ls
//slightly modified to return names
//this stuff is used to return the file names of directory
void ls(char *path);
char* fmtname(char *path);
int * insideFileCount = 0; // gotta ignore first 2 entries (., ..)
char ** fileNames;

int main(int argc, char *argv[]){
	//command line arguments
  if(argc == 1){
    printf(1, "Usage : cp [from] [to] \n");
    exit();
  }
  if(argc != 3){
    printf(1, "Error, only 2 files \n");
    exit();
  }

  //below code was not necessary lol whoops i will keep it here rip

  // int dirlen1 = strlen(argv[1]);
  // int orglen1 = dirlen1;
  // char * dir1 = (char *)malloc(dirlen1 * sizeof(char));
  // strcpy(dir1, argv[1]);
  //
  // int isDirectory1 = 1;
  // while(isDirectory1 == 1){
  //   int i = 0;
  //   int foundIndex = 0;
  //   for(; i < 128; i++){
  //     if(dir1[i] == '/'){ //found directory
  //       foundIndex = i;
  //
  //       char * directory = (char *)malloc((i-1) * sizeof(char));
  //       memset(directory, 0, (i-1)*sizeof(char));
  //
  //       if(chdir(directory) < 0){
  //         printf(2, "directory doesn't exist\n", directory);
  //         exit();
  //       }
  //       //printf(1, "moved to directory: %s\n", directory);
  //
  //       char * dir2 = (char *)malloc(dirlen1 * sizeof(char));
  //       strcpy(dir2, dir1);
  //       //printf(1, "beforem dir: %s\n", dir);
  //
  //       free(dir1);
  //       dirlen1 = dirlen1 - foundIndex - 1;
  //
  //       dir1 = (char *)malloc(dirlen1 * sizeof(char));
  //
  //       int k = 0;
  //       for(i = foundIndex + 1; i < orglen1; i++){
  //         dir1[k] = dir2[i];
  //         k++;
  //       }
  //       free(dir2);
  //       //printf(1, "after dir: %s\n", dir);
  //
  //       free(directory);
  //       isDirectory1 = 1;
  //       break;
  //     }
  //     isDirectory1 = 0;
  //   }
  // }


	//open from file
	int fd = open(argv[1], O_RDONLY);

  //i tried getting array of file names but some dum bug

  // struct stat st;
  // if(fstat(fd, &st) < 0){
  //   printf(2, "ls: cannot stat %s\n", argv[1]);
  //   close(fd);
  //   exit();
  // }
  // if(st.type == T_DIR){
  //   ls(argv[1]);
  //   int i = 0;
  //
  //   for(; i < (*insideFileCount); i++){
  //     printf(1, "%s\n", fileNames[i]);
  //   }
  //
  // }





	if(fd == -1){
		printf(1, "Error, file not found \n");
		exit();
	}

  int dirlen = strlen(argv[2]);
  int orglen = dirlen;
  char * dir = (char *)malloc(dirlen * sizeof(char));
  strcpy(dir, argv[2]);

  int isDirectory = 1;
  while(isDirectory == 1){
    int i = 0;
    int foundIndex = 0;
    for(; i < 128; i++){
      if(dir[i] == '/'){ //found directory
        foundIndex = i;

        char * directory = (char *)malloc((i-1) * sizeof(char));
        memset(directory, 0, (i-1)*sizeof(char));
    		int c = 0;
    		for(c = 0; c < i; c++)
          directory[c] = dir[c];

        int fd = open(directory, O_RDONLY);
        if(fd < 0){
            if(mkdir(directory) < 0){
              printf(2, "mkdir: %s failed to create\n", directory);
              exit();
            }
          printf(1, "made directory: %s\n", directory);
        }
        if(chdir(directory) < 0){
          printf(2, "chdir: %s failed to move\n", directory);
          exit();
        }
        printf(1, "moved to directory: %s\n", directory);

        char * dir2 = (char *)malloc(dirlen * sizeof(char));
        strcpy(dir2, dir);
        //printf(1, "beforem dir: %s\n", dir);

        free(dir);
        dirlen = dirlen - foundIndex - 1;

        dir = (char *)malloc(dirlen * sizeof(char));

        int k = 0;
        for(i = foundIndex + 1; i < orglen; i++){
          dir[k] = dir2[i];
          k++;
        }
        free(dir2);
        //printf(1, "after dir: %s\n", dir);

        free(directory);
        isDirectory = 1;
        break;
      }
      isDirectory = 0;
    }
  }


  int out = open(dir, O_CREATE|O_WRONLY);
  if(out == -1){
    printf(1, "Error, couldn't create out file \n ");
    exit();
  }

	//read file - copied from my benchmark program lmao
	char buf[512];
	int n;
  int m;

  printf(1,"writing");
	for(;;){
		n = read(fd, buf, sizeof buf);
    //read error check
		if(n == 0)
			break;
		if(n < 0){
			printf(1, "read error\n");
			exit();
		}

    m = write(out, buf, sizeof(buf));
    printf(1, ".");
    if(m < 0){
      printf(1, "read error\n");
      exit();
    }
  }
  printf(1, "\nI am finished thx 4 wait\n");

  close(fd);
  close(out);


  exit();
  return 0;
}

void ls(char *path){
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  fileNames = (char **)malloc(30 * sizeof(char*));


  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:
    fileNames[(*insideFileCount)++] = fmtname(path);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      fileNames[(*insideFileCount)] = fmtname(buf);
      (*insideFileCount)++;
    }
    break;
  }
  close(fd);
}

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
