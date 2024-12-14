#ifndef CAMERA_H
#define CAMERA_H

#include "hittable.h"
#include "color.h"
#include "ray.h"

class Camera {
public:
    void render(const Hittable& world) {
        
    }

private:
    void initialize() {
        
    }

    Color ray_color (const Ray& r, const Hittable& world) const {
        
    }
};

#endif // CAMERA_H