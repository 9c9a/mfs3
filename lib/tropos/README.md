# Tropospheric propagation library

A collection of functions in [MATLAB®](http://www.mathworks.com/products/matlab/) to calculate propagation losses according to ITU-R Recommendations. Most operations have been [vectorized](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html) for better performance on a relatively large coordinate grid, at the cost of increased memory usage.

## Known issues
Vapor height & cloud liquid water content functions rely exclusively on available data and do not interpolate for different percentages of time. This means that, effectively, attenuation can only be calculated for a limited set of probabilities.

## Credits
This library was developed as part of a course in Satellite Communications at the [Polytechnic University of Madrid](http://www.upm.es). The following people contributed to the original project:
- Javier de Pablo
- Juan Ignacio Gaya
- María Lozano
- Beatriz Martínez
- Alberto Sanz

## License
matlab-tropos is open-sourced software licensed under the [MIT License](http://opensource.org/licenses/MIT). For the full copyright and license information, please view the [LICENSE](LICENSE) file that is distributed with this source code.

This software package contains source code and data provided by the [ITU-R Radiowave Propagation Study Group (SG 3)](http://www.itu.int/en/ITU-R/study-groups/rsg3/Pages/iono-tropo-spheric.aspx).
