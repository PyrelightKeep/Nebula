// Add Vox-specific content for the Heist gamemode (Vox raider outfit, mirror to transform into a Vox as a raider)
#if defined(GAMEMODE_PACK_HEIST) && defined(MODPACK_VOX)
#include "patches/heist_vox.dm"
#endif

#ifdef MODPACK_PSIONICS
#include "patches/psionics.dm"
#endif

#ifdef GAMEMODE_PACK_MIXED
#include "patches/mixed_gamemodes.dm"
#endif

#ifdef MODPACK_FANTASY_SPECIES
#include "patches/fantasy.dm"
#endif

#ifdef CONTENT_PACK_SUPERMATTER
#include "patches/supermatter.dm"
#endif
