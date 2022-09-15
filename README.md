# RG-CACHE

![](https://img.shields.io/badge/MATLAB-R2017b-green.svg)

![](https://img.shields.io/badge/MATLAB-Image%20Processing%20Toolbox-green.svg)

![](https://img.shields.io/badge/OS-CentOS%206.5-green.svg)

Code for the paper "[Reflectance-guided, contrast-accumulated histogram equalization](https://arxiv.org/abs/2209.06405)" published in ICASSP 2020.

* In this paper, we have proposed a histogram equalization-based image enhancement method that adapts to the data-dependent requirements of brightness enhancement and improves visibility of details without losing global contrast.

* Please read `LICENSE.md` for more information on licenses.

* The original code was tested with MATLAB R2017b on a machine running CentOS 6.5, but it should work on other OSs as well.

* Requirements

  * MATLAB
  * Image processing toolbox (required for LIME)

* Run `mex ContrastAccumulatedHistogram.c` to build the mex function

* Run `demo.m` to see an example of image enhancement.

* `LIME.p` is provided by [Guo et al.](https://sites.google.com/view/xjguo/lime), and used as an edge-preserving filter for illumination estimation.

* Test images are provided by [USC-SIPI](http://sipi.usc.edu/database/) and [Guo et al.](https://sites.google.com/view/xjguo/lime)

* Please send any technical questions to the contact author, Xiaomeng Wu. You can get his email address by scanning the following QR code:

  ![qr](qr.png)
