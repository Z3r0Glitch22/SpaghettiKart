#ifndef ENGINE_STUB_H
#define ENGINE_STUB_H

#ifdef __cplusplus
extern "C" {
#endif

void engine_run(const char *path);
void engine_frame();
void engine_draw_frame();

#ifdef __cplusplus
}
#endif

#endif // ENGINE_STUB_H