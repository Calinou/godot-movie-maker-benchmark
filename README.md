# Godot Movie Maker benchmark

Performance comparison for Godot 4.0.alpha's [Movie Maker
mode](https://docs.godotengine.org/en/latest/tutorials/animation/creating_movies.html),
depending on the MJPEG quality chosen.

## Results

### Benchmark configuration

- **Godot version:** 4.0.alpha14
- **OS:** Fedora 36
- **CPU:** Intel Core i7-6700K
- **GPU:** NVIDIA GeForce GTX 1080
- **SSD:** Samsung 850 EVO (1 TB)

### Output specifications

In this project, the output generated by Godot's Movie Maker mode is a 1-second
video at 60 FPS (therefore, with 60 frames). The resolution is 1024×600, and all
frames are identical. Since MJPEG does not feature inter-frame compression (only
intra-frame compression), the file size is identical regardless of how much
motion is present in the recorded video.

A WAV audio channel is also saved by Godot in the AVI file, as this can't be
disabled in the engine.

### Time taken (seconds)

The time taken to save the video (in seconds). A save time of 1 second means
that the video could be saved exactly in real-time speed. Lower values than 1
second mean the video was recorded faster than real-time, and higher values than
1 second mean the video was recorded slower than real-time.

*Lower is better.*\
*X axis represents the MJPEG quality chosen, with higher quality on the right.*

![Chart: Time taken](https://raw.githubusercontent.com/Calinou/media/master/godot-movie-maker-benchmark/chart_time_taken.png)

### File size (MB)

The size of the generated AVI file (in megabytes).

*Lower is better.*\
*X axis represents the MJPEG quality chosen, with higher quality on the right.*

![Chart: File size](https://raw.githubusercontent.com/Calinou/media/master/godot-movie-maker-benchmark/chart_file_size.png)

### Perceptual quality (DSSIM)

The perceptual quality of the video's first frame. A value of 0 indicates
perfectly lossless output, with higher values being increasingly different from
the [lossless reference image](output/reference.png).

*Lower is better.*\
*X axis represents the MJPEG quality chosen, with higher quality on the right.*

![Chart: Perceptual quality](https://raw.githubusercontent.com/Calinou/media/master/godot-movie-maker-benchmark/chart_perceptual_quality.png)

## License

Copyright © 2022 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under the
MIT license. See [LICENSE.md](LICENSE.md) for more information.
