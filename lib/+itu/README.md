# Ionospheric and tropospheric propagation library

A collection of functions in [MATLAB®](http://www.mathworks.com/products/matlab/) to calculate propagation losses according to ITU-R Recommendations. Most operations have been [vectorized](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html) for better performance on a relatively large coordinate grid, at the cost of increased memory usage.

This library is part of [mfs3](https://github.com/jlcorra/matlab-mfs3), a graphical simulator for multibeam fixed-satellite service (FSS) design.

## Known issues
Vapor height & cloud liquid water content functions rely exclusively on available data and do not interpolate for different percentages of time. This means that, effectively, attenuation can only be calculated for a limited set of probabilities.

## License
mfs3 is open-sourced software licensed under the [MIT License](http://opensource.org/licenses/MIT). This software package contains source code and data provided by the [ITU-R Radiowave Propagation Study Group (SG 3)](http://www.itu.int/en/ITU-R/study-groups/rsg3/Pages/iono-tropo-spheric.aspx).
