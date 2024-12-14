#include "rtutils.h"
#include "sphere.h"
#include "hittable.h"
#include "hittable_list.h"

Color ray_color(const Ray& r, const Hittable& world) {
    HitRecord rec;
    // return normal color
    if (world.hit(r, Interval(0, infinity), rec))
        return 0.5 * (rec.normal + Color(1, 1, 1));
    
    // return background gradient
    const auto a = 0.5 * (unit_vector(r.direction()).y() + 1.0);
    return (1.0-a)*Color(1.0, 1.0, 1.0) + a*Color(0.5, 0.7, 1.0);
}

int main() {
    // Image size
    const auto aspect_ratio = 16.0 / 9.0;
    const int image_width = 400;
    int image_height = static_cast<int>(image_width / aspect_ratio);
    image_height = (image_height < 1) ? 1 : image_height;

    // World
    HittableList world;
    world.add(make_shared<Sphere>(Point3(0,0,-1), 0.5));
    world.add(make_shared<Sphere>(Point3(0,-100.5, -1), 100));

    // Camera
    const auto focal_length = 1.0;
    const auto viewport_height = 2.0;
    auto viewport_width = viewport_height * (static_cast<double>(image_width) / image_height);
    auto camera_center = Point3(0, 0, 0);

    // Viewport vectors
    auto viewport_u = Vec3(viewport_width, 0, 0);
    auto viewport_v = Vec3(0, -viewport_height, 0);

    // Viewport distance between pixels
    auto pixel_delta_u = viewport_u / image_width;
    auto pixel_delta_v = viewport_v / image_height;

    // Upper left pixel
    auto viewport_upper_left = camera_center - Vec3(0, 0, focal_length) - viewport_u/2 - viewport_v/2;
    auto pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

    // Render
    std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";
    for (int j = 0; j < image_height; j++) {
        std::clog << "\rScanlines remaining: " << image_height - j << " " << std::flush;
        for (int i = 0; i < image_width; i++) {
            auto pixel_center = pixel00_loc + (i * pixel_delta_u) + (j * pixel_delta_v);
            auto ray_direction = pixel_center - camera_center;
            ray r(camera_center, ray_direction);
            color pixel_color = ray_color(r, world)/* ;
  */ */           write_color(std::cout, pixel_color);
       }
    }
    std::clog << "\rDone.                 \n";
}