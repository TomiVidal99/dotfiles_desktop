% Test of graphics toolkit libraries.

gts = available_graphics_toolkits();
dispc("Available")
qt_available = any(strcmp(gts, 'qt'));
