// Add the supermatter monitor to engineering jobs' default software.
#ifdef MODPACK_STANDARD_JOBS
#include "supermatter/supermatter_jobs.dm"
#endif
// Disable Narsie during the supermatter cascade.
#ifdef GAMEMODE_PACK_CULT
#include "supermatter/sm_disable_narsie.dm"
#endif
// Add the supermatter meteor to the meteor gamemode's cataclysmic meteors list.
#ifdef GAMEMODE_PACK_METEOR
#include "supermatter/sm_meteor.dm"
#endif