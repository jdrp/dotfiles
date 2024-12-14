#ifndef SPHERE_H
#define SPHERE_H

#include "hittable.h"

class Sphere : public Hittable {
public:
    Sphere(const Point3& center, const double radius) : center(center), radius(std::fmax(0, radius)) {}

    bool hit(const Ray& r, Interval ray_t, HitRecord& rec) const override {
        Vec3 oc = center - r.origin();
        auto a = r.direction().length_squared();
        auto h = dot(r.direction(), oc);
        auto c = oc.length_squared() - radius * radius;

        auto discriminant = h*h - a*c;
        if (discriminant < 0)
            return false;

        auto sqrtd = std::sqrt(discriminant);

        // test smallest solution
        auto root = (h - sqrtd) / a;
        if (!ray_t.surrounds(root)) {
            // test largest solution
            root = (h + sqrtd) / a;
            if (!ray_t.surrounds(root))
                return false;
        }

        rec.t = root;
        rec.p = r.at(rec.t);
        rec.set_face_normal(r, (rec.p - center) / radius);  // normalized
        return true;
    }

private:
    Point3 center;
    double radius;
};

#endif //SPHERE_H
