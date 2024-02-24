#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#if !defined(__linux__)
#error "Platform not supported."
#endif

#if defined(__i386__)
#define ARCH "i386"
#elif defined(__amd64__)
#define ARCH "amd64"
#else
#error "Architecture not supported."
#endif

static char exeName[1024] = {0};
static void (*realSDLDisableScreenSaver)(void) = NULL;

static void InitializeExeName(void)
{
  if (exeName[0] == '\0')
  {
    ssize_t len = readlink("/proc/self/exe", exeName, sizeof(exeName) - 1);
    if (len != -1)
      exeName[len] = '\0';
  }
}

static void LoadRealFunction(void)
{
  if (!realSDLDisableScreenSaver)
  {
    realSDLDisableScreenSaver = dlvsym(RTLD_NEXT, "SDL_DisableScreenSaver", "libSDL2-2.0.so.0");
    if (!realSDLDisableScreenSaver)
      realSDLDisableScreenSaver = dlsym(RTLD_NEXT, "SDL_DisableScreenSaver");
  }
}

static int IsSteam(void)
{
  static int checked = 0;
  static int isSteam = 0;

  if (!checked)
  {
    const char *exeBasename = strrchr(exeName, '/') ? strrchr(exeName, '/') + 1 : exeName;
    isSteam = (strcmp(exeBasename, "steam") == 0);
    checked = 1;
  }

  return isSteam;
}

void SDL_DisableScreenSaver(void)
{
  InitializeExeName();

  if (!IsSteam())
  {
    LoadRealFunction();
    if (realSDLDisableScreenSaver)
      realSDLDisableScreenSaver();
  }
}