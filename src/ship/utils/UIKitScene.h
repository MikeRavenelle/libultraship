#pragma once

#if defined(__IOS__) || defined(__TVOS__)
namespace Ship {
void AttachWindowToScene(void* uiWindow);
}
#endif
